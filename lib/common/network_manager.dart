import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/board/constants/app_config.dart';
import 'package:fl_clash/board/utils/storage.dart';
import 'package:fl_clash/common/error_manager.dart';

/// 统一的网络请求管理器
/// 整合了之前分散在多个文件中的网络请求逻辑
class NetworkManager {
  static NetworkManager? _instance;
  static NetworkManager get instance => _instance ??= NetworkManager._();

  NetworkManager._() {
    _initializeDioInstances();
  }

  // HTTP 相关配置
  static const int connectTimeout = 60;
  static const int receiveTimeout = 60;
  // 使用动态 User-Agent，包含 clash-verge 以确保订阅服务器返回完整配置
  // 如果 config 未初始化，使用默认值
  static String get userAgent {
    try {
      return globalState.ua;
    } catch (e) {
      // config 未初始化时，返回包含 clash-verge 的默认 User-Agent
      return 'FlClash/v1.0 clash-verge Platform/${Platform.operatingSystem}';
    }
  }

  // Dio 实例 - 改为可重新赋值
  late Dio _directDio;
  late Dio _proxyDio;
  late Dio _clashDio;

  // 为了兼容现有代码，提供公共访问器
  Dio get directDio => _directDio;
  Dio get proxyDio => _proxyDio;
  Dio get clashDio => _clashDio;

  // 认证存储
  AuthStorage? _authStorage;
  bool _isInitialized = false;

  /// 初始化网络管理器
  void initialize({AuthStorage? authStorage}) {
    if (kDebugMode) {
      debugPrint('NetworkManager.initialize 被调用: authStorage=${authStorage != null ? "不为null" : "null"}');
    }
    
    // 如果提供了authStorage，则更新它
    if (authStorage != null) {
      _authStorage = authStorage;
    }
    
    if (!_isInitialized) {
      _initializeDioInstances();
      _isInitialized = true;
      if (kDebugMode) debugPrint('NetworkManager 首次初始化完成');
    } else {
      // 如果已经初始化过，只更新认证存储
      _updateAuthStorage();
      if (kDebugMode) debugPrint('NetworkManager 认证存储已更新');
    }
  }

  /// 更新认证存储
  void _updateAuthStorage() {
    if (kDebugMode) {
      debugPrint('更新认证存储: ${_authStorage != null ? "已设置" : "null"}');
    }
    
    // 清除所有InterceptorsWrapper类型的拦截器，然后重新添加
    _directDio.interceptors.clear();
    _proxyDio.interceptors.clear();
    
    // 重新添加所有拦截器
    _directDio.interceptors.addAll([
      _createAuthInterceptor(),
      _createLogInterceptor('[直连模式]'),
      _createErrorInterceptor(),
    ]);
    
    _proxyDio.interceptors.addAll([
      _createAuthInterceptor(),
      _createLogInterceptor('[代理模式]'),
      _createErrorInterceptor(),
    ]);
  }

  void _initializeDioInstances() {
    // 创建基本配置（使用动态 User-Agent）
    final baseOptions = BaseOptions(
      connectTimeout: Duration(seconds: connectTimeout),
      receiveTimeout: Duration(seconds: receiveTimeout),
      headers: {'User-Agent': userAgent},  // 现在 userAgent 是动态的，包含 clash-verge
      validateStatus: (_) => true,
    );

    // Clash 专用配置（不设置 User-Agent header，让 HttpClient 的 userAgent 生效）
    final clashOptions = BaseOptions(
      connectTimeout: Duration(seconds: connectTimeout),
      receiveTimeout: Duration(seconds: receiveTimeout),
      validateStatus: (_) => true,
    );

    // 直连 Dio 实例（不走代理）
    _directDio = Dio(baseOptions)
      ..httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();
          client.findProxy = (uri) => 'DIRECT';
          return client;
        },
      )
      ..interceptors.addAll([
        _createAuthInterceptor(), // 总是添加认证拦截器
        _createLogInterceptor('[直连模式]'),
        _createErrorInterceptor(),
      ]);

    // 代理 Dio 实例
    _proxyDio = Dio(baseOptions)
      ..interceptors.addAll([
        _createAuthInterceptor(), // 总是添加认证拦截器
        _createLogInterceptor('[代理模式]'),
        _createErrorInterceptor(),
      ]);

    // Clash 专用 Dio 实例（使用独立配置，确保 User-Agent 正确）
    _clashDio = Dio(clashOptions)
      ..httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();
          client.findProxy = (Uri uri) {
            // 设置正确的 User-Agent，包含 clash-verge
            client.userAgent = globalState.ua;
            return FlClashHttpOverrides.handleFindProxy(uri);
          };
          return client;
        },
      )
      ..interceptors.add(_createLogInterceptor('[Clash模式]'));
  }

  /// 创建认证拦截器
  Interceptor _createAuthInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = _authStorage?.token;
        if (kDebugMode && options.path.contains('user/info')) {
          debugPrint('认证拦截器检查: token=${token != null ? "存在" : "null"}, _authStorage=${_authStorage != null ? "存在" : "null"}');
        }
        
        if (token != null) {
          String authToken = token.trim();
          // V2Board可能不需要Bearer前缀，尝试直接发送token
          // 注释掉Bearer前缀添加逻辑进行测试
          // if (authToken.startsWith('eyJ') && !authToken.toLowerCase().startsWith('bearer ')) {
          //   authToken = 'Bearer $authToken';
          // }
          options.headers['Authorization'] = authToken;
          if (kDebugMode && options.path.contains('user/info')) {
            debugPrint('添加认证头（无Bearer前缀）: ${authToken.substring(0, authToken.length > 30 ? 30 : authToken.length)}...');
          }
        } else {
          if (kDebugMode && options.path.contains('user/info')) {
            debugPrint('没有token，跳过添加认证头');
          }
        }
        handler.next(options);
      },
    );
  }

  /// 创建日志拦截器
  Interceptor _createLogInterceptor(String mode) {
    return LogInterceptor(
      requestBody: false,
      responseBody: false,
      error: true,
      logPrint: (log) => kDebugMode ? debugPrint('$mode $log') : null,
    );
  }

  /// 创建错误处理拦截器
  Interceptor _createErrorInterceptor() {
    return InterceptorsWrapper(
      onResponse: (response, handler) {
        // 对于200状态码，直接通过
        if (response.statusCode == 200) {
          handler.next(response);
          return;
        }
        
        // 对于非200状态码，尝试提取服务器的错误信息
        if (response.statusCode != 200) {
          String errorMessage = '请求失败: ${response.statusCode}';
          
          // 打印服务器响应数据用于调试
          if (kDebugMode) {
            debugPrint('服务器响应状态码: ${response.statusCode}');
            debugPrint('服务器响应数据: ${response.data}');
            debugPrint('服务器响应数据类型: ${response.data.runtimeType}');
          }
          
          // 尝试从响应体中提取错误信息
          try {
            if (response.data != null) {
              if (response.data is Map) {
                final data = response.data as Map<String, dynamic>;
                
                // 优先从errors中提取具体的错误信息
                if (data['errors'] != null) {
                  final errors = data['errors'];
                  if (errors is Map && errors.isNotEmpty) {
                    // 获取第一个错误字段的第一个错误信息
                    final firstField = errors.values.first;
                    if (firstField is List && firstField.isNotEmpty) {
                      errorMessage = firstField.first.toString();
                      if (kDebugMode) debugPrint('从errors中提取到错误信息: $errorMessage');
                    } else if (firstField is String) {
                      errorMessage = firstField;
                      if (kDebugMode) debugPrint('从errors中提取到错误信息: $errorMessage');
                    }
                  }
                }
                
                // 如果errors中没有提取到有效错误信息，则使用message
                if (errorMessage == '请求失败: ${response.statusCode}') {
                  if (data['message'] != null) {
                    errorMessage = data['message'].toString();
                    if (kDebugMode) debugPrint('从message中提取到错误信息: $errorMessage');
                  } else if (data['error'] != null) {
                    errorMessage = data['error'].toString();
                    if (kDebugMode) debugPrint('从error中提取到错误信息: $errorMessage');
                  } else if (data['msg'] != null) {
                    errorMessage = data['msg'].toString();
                    if (kDebugMode) debugPrint('从msg中提取到错误信息: $errorMessage');
                  }
                }
              } else if (response.data is String) {
                errorMessage = response.data as String;
                if (kDebugMode) debugPrint('提取到字符串错误信息: $errorMessage');
              }
            }
          } catch (e) {
            // 如果解析失败，使用默认错误信息
            if (kDebugMode) {
              debugPrint('解析服务器错误信息失败: $e');
            }
          }
          
          // 如果没有提取到具体错误信息，使用状态码默认信息
          if (errorMessage == '请求失败: ${response.statusCode}') {
            switch (response.statusCode) {
              case 400:
                errorMessage = '请求参数错误';
                break;
              case 401:
                errorMessage = '身份验证失败';
                break;
              case 403:
                errorMessage = '权限不足';
                break;
              case 404:
                errorMessage = '请求的资源不存在';
                break;
              case 422:
                errorMessage = '请求数据验证失败';
                break;
              case 429:
                errorMessage = '请求过于频繁，请稍后重试';
                break;
              case 500:
                errorMessage = '服务器内部错误';
                break;
              case 502:
                errorMessage = '网关错误';
                break;
              case 503:
                errorMessage = '服务暂时不可用';
                break;
              default:
                errorMessage = '请求失败: ${response.statusCode}';
            }
          }
          
          if (kDebugMode) {
            debugPrint('最终错误信息: $errorMessage');
          }
          
          handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              response: response,
              error: errorMessage, // 使用提取的服务器错误信息
            ),
          );
          return;
        }

        handler.next(response);
      },
      onError: (error, handler) {
        final statusCode = error.response?.statusCode;
        
        // 特殊处理认证错误
        if (statusCode == 401) {
          if (kDebugMode) debugPrint('未授权错误，正在清除认证信息');
          try {
            _authStorage?.clearAuth();
          } catch (e) {
            if (kDebugMode) debugPrint('清除认证失败: $e');
          }
          // 使用错误管理器处理认证错误
          errorManager.handleError(
            AppError.auth('认证失败，请重新登录'),
            showToUser: false, // 不立即显示，让调用方决定
          );
        }
        
        if (kDebugMode) {
          debugPrint('请求错误: ${error.message}');
          debugPrint('URL: ${error.requestOptions.uri}');
          debugPrint('请求方法: ${error.requestOptions.method}');
          if (error.response != null) {
            debugPrint('状态码: ${error.response?.statusCode}');
            debugPrint('响应数据: ${error.response?.data}');
          }
        }
        
        handler.next(error);
      },
    );
  }

  /// 更新API基础URL
  void updateBaseUrl(String newBaseUrl) {
    String baseUrl = newBaseUrl.trim();
    if (baseUrl.isNotEmpty) {
      if (!baseUrl.startsWith('http://') && !baseUrl.startsWith('https://')) {
        baseUrl = 'https://$baseUrl';
      }
      
      final apiPath = baseUrl + AppConfig.apiVersion;
      _proxyDio.options.baseUrl = apiPath;
      _directDio.options.baseUrl = apiPath;
      
      if (kDebugMode) debugPrint('Dio baseUrl 更新成功: $apiPath');
    }
  }

  /// 智能请求方法
  /// 根据网络状况自动选择最优的请求方式
  Future<Response> smartRequest({
    required Future<Response> Function(Dio dio) requestFunc,
    bool forceProxy = false,
    bool forceDirect = false,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    try {
      if (kDebugMode) {
        debugPrint('开始智能请求：forceProxy=$forceProxy, forceDirect=$forceDirect');
      }
      
      if (forceDirect) {
        if (kDebugMode) debugPrint('强制使用直连模式发送请求');
        return await requestFunc(_directDio);
      } else if (forceProxy) {
        if (kDebugMode) debugPrint('强制使用代理模式发送请求');
        return await requestFunc(_proxyDio);
      } else {
        // 智能模式：先尝试直连，只有在真正的网络问题时才使用代理
        try {
          if (kDebugMode) debugPrint('尝试使用直连模式发送请求');
          return await requestFunc(_directDio).timeout(
            timeout,
            onTimeout: () {
              throw TimeoutException('直连请求超时');
            },
          );
        } catch (directError) {
          // 检查是否是真正的网络连接问题
          if (_isNetworkConnectionError(directError)) {
            if (kDebugMode) debugPrint('直连遇到网络连接问题，尝试使用代理: $directError');
            return await requestFunc(_proxyDio);
          } else {
            // 如果是服务器响应的业务逻辑错误，直接抛出，不尝试代理
            if (kDebugMode) debugPrint('直连请求收到服务器响应，不尝试代理: $directError');
            rethrow;
          }
        }
      }
    } catch (e) {
      if (kDebugMode) debugPrint('请求最终失败: $e');
      rethrow;
    }
  }

  /// 判断是否是网络连接错误
  bool _isNetworkConnectionError(dynamic error) {
    if (error is TimeoutException) {
      return true;
    }
    
    if (error is DioException) {
      // 只有真正的网络连接问题才需要尝试代理
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.connectionError:
          return true;
        case DioExceptionType.badResponse:
        case DioExceptionType.cancel:
        case DioExceptionType.badCertificate:
        case DioExceptionType.unknown:
          // 如果有服务器响应，说明网络连接正常，不需要尝试代理
          return error.response == null;
      }
    }
    
    // 其他类型的错误默认认为是网络问题
    return true;
  }

  /// 判断是否应该重试请求
  bool _shouldRetryRequest(dynamic error) {
    // 如果是AppError，检查其类型
    if (error is AppError) {
      // 以下类型的错误不应该重试
      switch (error.type) {
        case ErrorType.auth:         // 认证错误（如密码错误）
        case ErrorType.permission:  // 权限错误
        case ErrorType.validation:  // 验证错误（如参数错误）
          return false;
        case ErrorType.network:     // 网络错误可以重试
        case ErrorType.system:     // 系统错误可以重试
        case ErrorType.unknown:    // 未知错误可以重试
          return true;
      }
    }
    
    // 如果是DioException，检查错误类型
    if (error is DioException) {
      // 核心原则：只要服务器有响应，就不重试
      if (error.response != null) {
        if (kDebugMode) {
          debugPrint('服务器有响应 (${error.response!.statusCode})，不重试');
        }
        return false; // 有响应就不重试，无论是什么状态码
      }
      
      // 只有真正的网络连接问题才重试
      switch (error.type) {
        case DioExceptionType.connectionTimeout:   // 连接超时
        case DioExceptionType.receiveTimeout:      // 接收超时  
        case DioExceptionType.sendTimeout:         // 发送超时
        case DioExceptionType.connectionError:     // 连接错误
          if (kDebugMode) {
            debugPrint('网络连接问题，可以重试: ${error.type}');
          }
          return true;
        case DioExceptionType.badResponse:         // 有响应但格式错误
        case DioExceptionType.cancel:              // 请求被取消
        case DioExceptionType.badCertificate:      // 证书错误
        case DioExceptionType.unknown:             // 未知错误
          if (kDebugMode) {
            debugPrint('非网络连接问题，不重试: ${error.type}');
          }
          return false;
      }
    }
    
    // 其他类型的错误（如TimeoutException等）可以重试
    return true;
  }

  /// 带重试机制的请求（优化版：智能重试判断）
  Future<Response> retryRequest(
    Future<Response> Function() apiCall, {
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 1),
  }) async {
    int attemptCount = 0; // 改为尝试计数，更清晰
    dynamic lastError;

    while (attemptCount <= maxRetries) { // 总共执行 maxRetries+1 次（1次初始+maxRetries次重试）
      try {
        return await apiCall();
      } catch (e) {
        lastError = e;
        attemptCount++;
        
        // 检查是否应该重试
        if (!_shouldRetryRequest(e)) {
          if (kDebugMode) {
            debugPrint('错误不适合重试，直接抛出: $e');
          }
          break; // 不重试，直接跳出循环
        }
        
        // 如果已经是最后一次尝试，不再重试
        if (attemptCount > maxRetries) {
          if (kDebugMode) {
            debugPrint('已达最大尝试次数 ($attemptCount/${maxRetries + 1})，停止重试');
          }
          break;
        }
        
        if (kDebugMode) {
          debugPrint('请求失败，正在重试 ($attemptCount/$maxRetries): $e');
        }
        
        // 指数退避：每次重试间隔递增
        await Future.delayed(retryDelay * attemptCount);
      }
    }

    if (kDebugMode) debugPrint('重试次数已用完，请求失败');
    
    // 直接抛出最终错误，不再包装
    if (lastError is DioException) {
      // 如果是DioException，直接抛出，保持错误信息
      throw lastError;
    } else if (lastError is AppError) {
      throw lastError;
    } else {
      final appError = AppError(
        message: lastError.toString(),
        type: ErrorType.system,
        severity: ErrorSeverity.medium,
        suggestion: '请稍后重试',
      );
      throw appError;
    }
  }

  /// GET 请求
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    int maxRetries = 3,
    bool forceProxy = false,
    bool forceDirect = false,
  }) async {
    return smartRequest(
      requestFunc: (dio) => retryRequest(
        () => dio.get(path, queryParameters: queryParameters, options: options),
        maxRetries: maxRetries,
      ),
      forceProxy: forceProxy,
      forceDirect: forceDirect,
    );
  }

  /// POST 请求
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    int maxRetries = 3,
    bool forceProxy = false,
    bool forceDirect = false,
  }) async {
    return smartRequest(
      requestFunc: (dio) => retryRequest(
        () => dio.post(
          path, 
          data: data, 
          queryParameters: queryParameters, 
          options: options
        ),
        maxRetries: maxRetries,
      ),
      forceProxy: forceProxy,
      forceDirect: forceDirect,
    );
  }

  /// PUT 请求
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    int maxRetries = 3,
    bool forceProxy = false,
    bool forceDirect = false,
  }) async {
    return smartRequest(
      requestFunc: (dio) => retryRequest(
        () => dio.put(
          path, 
          data: data, 
          queryParameters: queryParameters, 
          options: options
        ),
        maxRetries: maxRetries,
      ),
      forceProxy: forceProxy,
      forceDirect: forceDirect,
    );
  }

  /// DELETE 请求
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    int maxRetries = 3,
    bool forceProxy = false,
    bool forceDirect = false,
  }) async {
    return smartRequest(
      requestFunc: (dio) => retryRequest(
        () => dio.delete(
          path, 
          data: data, 
          queryParameters: queryParameters, 
          options: options
        ),
        maxRetries: maxRetries,
      ),
      forceProxy: forceProxy,
      forceDirect: forceDirect,
    );
  }

  /// 获取文件响应
  Future<Response> getFileResponse(String url) async {
    return await _clashDio.get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
  }

  /// 获取文本响应
  Future<Response> getTextResponse(String url) async {
    return await _clashDio.get(
      url,
      options: Options(
        responseType: ResponseType.plain,
      ),
    );
  }

  /// 获取图片
  Future<MemoryImage?> getImage(String url) async {
    if (url.isEmpty) return null;
    try {
      final response = await _directDio.get<Uint8List>(
        url,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      final data = response.data;
      if (data == null) return null;
      return MemoryImage(data);
    } catch (e) {
      if (kDebugMode) debugPrint('获取图片失败: $e');
      return null;
    }
  }

  /// 检查应用更新（优化版：添加超时和缓存）
  Future<Map<String, dynamic>?> checkForUpdate() async {
    try {
      debugPrint('[FlClash] 开始检查更新...');
      
      // 创建带超时的dio实例
      final dio = Dio();
      dio.options.connectTimeout = const Duration(seconds: 10);
      dio.options.receiveTimeout = const Duration(seconds: 10);
      
      final response = await dio.get(
        AppConfig.appUpdateCheckUrl,
        options: Options(
          headers: {
            'User-Agent': userAgent,
          },
          responseType: ResponseType.json,
        ),
      );
      
      if (response.statusCode != 200) {
        debugPrint('[FlClash] 更新检查失败: ${response.statusCode}');
        return null;
      }
      
      final data = response.data as Map<String, dynamic>;
      final remoteVersion = data['tag_name'];
      final version = globalState.packageInfo.version;
      
      debugPrint('[FlClash] 当前版本: $version');
      debugPrint('[FlClash] 远程版本: $remoteVersion');
      
      final hasUpdate = utils.compareVersions(
        remoteVersion.replaceAll('v', ''), 
        version
      ) > 0;
      
      debugPrint('[FlClash] 版本比较结果: hasUpdate=$hasUpdate');
      
      if (!hasUpdate) {
        debugPrint('[FlClash] 当前已是最新版本');
        return null; // 返回null而不是抛出异常
      }
      
      debugPrint('[FlClash] 发现新版本: $remoteVersion');
      return data;
    } catch (e) {
      if (kDebugMode) debugPrint('[FlClash] 检查更新失败: $e');
      rethrow;
    }
  }

  /// IP 信息源配置（按优先级排序）
  final List<MapEntry<String, IpInfo Function(Map<String, dynamic>)>> _ipInfoSources = [
    MapEntry("https://ipinfo.io/json/", IpInfo.fromIpInfoIoJson),
    MapEntry("https://ipwho.is/", IpInfo.fromIpwhoIsJson),
    MapEntry("https://api.ip.sb/geoip/", IpInfo.fromIpSbJson),
    MapEntry("https://ipapi.co/json/", IpInfo.fromIpApiCoJson),
  ];

  /// IP检测缓存
  IpInfo? _cachedIpInfo;
  DateTime? _lastIpCheckTime;
  bool? _preProxyState; // 记录上次代理状态，用于检测状态变化
  static const Duration _ipCacheValidDuration = Duration(minutes: 10); // 10分钟缓存

  /// 检查IP信息（优化版：顺序尝试 + 缓存 + 代理支持）
  Future<Result<IpInfo?>> checkIp({CancelToken? cancelToken}) async {
    // 获取代理状态
    final isStart = globalState.appState.runTime != null;
    
    // 如果代理状态改变，清除缓存以获取最新IP
    if (_lastIpCheckTime != null && _preProxyState != isStart) {
      _cachedIpInfo = null;
      _lastIpCheckTime = null;
      _preProxyState = isStart;
      debugPrint('[FlClash] 代理状态改变，清除IP缓存');
    }
    
    // 检查缓存
    if (_cachedIpInfo != null && 
        _lastIpCheckTime != null && 
        DateTime.now().difference(_lastIpCheckTime!) < _ipCacheValidDuration) {
      debugPrint('[FlClash] 使用缓存的IP信息');
      return Result.success(_cachedIpInfo);
    }

    debugPrint('[FlClash] 开始IP检测 (顺序尝试), 代理状态: ${isStart ? "已启动" : "未启动"}');
    
    // 顺序尝试每个IP检测服务
    for (int i = 0; i < _ipInfoSources.length; i++) {
      final source = _ipInfoSources[i];
      
      try {
        debugPrint('[FlClash] 尝试 ${source.key}');
        
        // 创建Dio实例并根据代理状态配置
        final dio = Dio();
        dio.options.connectTimeout = const Duration(seconds: 8);
        dio.options.receiveTimeout = const Duration(seconds: 8);
        
        // 如果代理已启动，配置HTTP客户端使用Clash代理
        if (isStart) {
          final mixedPort = globalState.config.patchClashConfig.mixedPort;
          dio.httpClientAdapter = IOHttpClientAdapter(
            createHttpClient: () {
              final client = HttpClient();
              client.findProxy = (uri) {
                // 使用Clash混合端口作为代理
                debugPrint('[FlClash] IP检测通过代理: localhost:$mixedPort');
                return "PROXY localhost:$mixedPort";
              };
              return client;
            },
          );
        } else {
          // 代理未启动，使用直连
          dio.httpClientAdapter = IOHttpClientAdapter(
            createHttpClient: () {
              final client = HttpClient();
              client.findProxy = (uri) => 'DIRECT';
              return client;
            },
          );
        }
        
        final res = await dio.get<Map<String, dynamic>>(
          source.key,
          cancelToken: cancelToken,
          options: Options(
            responseType: ResponseType.json,
          ),
        );
        
        if (res.statusCode == HttpStatus.ok && res.data != null) {
          final ipInfo = source.value(res.data!);
          
          // 缓存成功的结果
          _cachedIpInfo = ipInfo;
          _lastIpCheckTime = DateTime.now();
          
          debugPrint('[FlClash] IP检测成功: ${source.key}, IP: ${ipInfo.ip}');
          return Result.success(ipInfo);
        }
      } catch (e) {
        debugPrint('[FlClash] IP检测失败 ${source.key}: $e');
        
        if (e is DioException && e.type == DioExceptionType.cancel) {
          return Result.error("cancelled");
        }
        
        // 如果不是最后一个，继续尝试下一个
        if (i < _ipInfoSources.length - 1) {
          continue;
        }
      }
    }
    
    debugPrint('[FlClash] 所有IP检测服务都失败');
    return Result.success(null);
  }

  /// Helper 相关方法
  Future<bool> pingHelper() async {
    try {
      final response = await _directDio
          .get(
            "http://$localhost:$helperPort/ping",
            options: Options(
              responseType: ResponseType.plain,
            ),
          )
          .timeout(const Duration(milliseconds: 2000));
      if (response.statusCode != HttpStatus.ok) {
        return false;
      }
      return (response.data as String) == globalState.coreSHA256;
    } catch (_) {
      return false;
    }
  }

  Future<bool> startCoreByHelper(String arg) async {
    try {
      final response = await _directDio
          .post(
            "http://$localhost:$helperPort/start",
            data: json.encode({
              "path": appPath.corePath,
              "arg": arg,
            }),
            options: Options(
              responseType: ResponseType.plain,
            ),
          )
          .timeout(const Duration(milliseconds: 2000));
      if (response.statusCode != HttpStatus.ok) {
        return false;
      }
      final data = response.data as String;
      return data.isEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<bool> stopCoreByHelper() async {
    try {
      final response = await _directDio
          .post(
            "http://$localhost:$helperPort/stop",
            options: Options(
              responseType: ResponseType.plain,
            ),
          )
          .timeout(const Duration(milliseconds: 2000));
      if (response.statusCode != HttpStatus.ok) {
        return false;
      }
      final data = response.data as String;
      return data.isEmpty;
    } catch (_) {
      return false;
    }
  }

  /// 释放资源
  void dispose() {
    _directDio.close();
    _proxyDio.close();
    _clashDio.close();
  }
}

/// 全局网络管理器实例
final networkManager = NetworkManager.instance;