import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:fl_clash/board/constants/crypto_utils.dart';
import 'package:fl_clash/board/constants/app_config.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/common/network_manager.dart';
import 'app_configuration.dart';
import 'config_cache.dart';
import 'config_error_handler.dart';

/// 配置来源枚举
enum ConfigSource {
  defaults,
  encrypted,
  remote,
  cache,
}

/// 配置管理器
class ConfigManager {
  static ConfigManager? _instance;
  static ConfigManager get instance => _instance ??= ConfigManager._();

  ConfigManager._();

  /// 当前配置
  AppConfiguration? _currentConfig;
  AppConfiguration get currentConfig => _currentConfig ?? AppConfiguration.defaults();

  /// 配置状态监听器
  final List<void Function(AppConfiguration)> _listeners = [];

  /// 配置加载状态
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// 远程配置加载状态
  bool _isRemoteLoading = false;
  bool get isRemoteLoading => _isRemoteLoading;

  /// 初始化配置（简化流程）
  Future<void> initialize() async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      if (kDebugMode) {
        debugPrint('ConfigManager: 开始初始化配置...');
      }

      // 1. 加载默认配置
      _currentConfig = await _loadDefaultConfig();
      
      // 2. 尝试从缓存加载配置
      final cachedConfig = await _loadCachedConfig();
      if (cachedConfig != null) {
        _currentConfig = _currentConfig!.merge(cachedConfig);
        if (kDebugMode) {
          debugPrint('ConfigManager: 从缓存加载配置成功');
        }
      }

      // 3. 通知监听器
      _notifyListeners();

      // 4. 异步加载远程配置（不阻塞初始化）
      _loadRemoteConfigAsync();

      if (kDebugMode) {
        debugPrint('ConfigManager: 配置初始化完成');
        debugPrint(_currentConfig!.debugInfo);
      }

    } catch (e) {
      if (kDebugMode) {
        debugPrint('ConfigManager: 配置初始化失败: $e');
      }
      
      // 使用错误处理器获取安全配置
      _currentConfig = await ConfigErrorHandler.handleConfigError(
        e, 
        ConfigErrorHandler.createSafeFallbackConfig(),
      );
      
      _notifyListeners();
    } finally {
      _isLoading = false;
    }
  }

  /// 加载默认配置
  Future<AppConfiguration> _loadDefaultConfig() async {
    try {
      // 尝试解密硬编码配置
      final decryptedConfig = await _loadEncryptedConfig();
      return decryptedConfig;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('ConfigManager: 解密配置失败，使用默认配置: $e');
      }
      return AppConfiguration.defaults();
    }
  }

  /// 加载加密配置
  Future<AppConfiguration> _loadEncryptedConfig() async {
    try {
      // 从原AppConfig获取加密的配置
      final appTitle = _decryptValue('appTitle');
      final baseUrl = _decryptValue('baseUrl');
      final apiVersion = _decryptValue('apiVersion');

      return AppConfiguration(
        appTitle: appTitle.isNotEmpty ? appTitle : 'FlClash',
        baseUrl: baseUrl,
        apiVersion: apiVersion.isNotEmpty ? apiVersion : '/api/v1',
        updateUrl: 'https://cloud.ziu.ooo/FxClash/',
        updateCheckUrl: 'https://f005.backblazeb2.com/file/fx2025/app_latest_version.json',
        version: 1,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      throw Exception('解密配置失败: $e');
    }
  }

  /// 解密配置值
  String _decryptValue(String key) {
    try {
      switch (key) {
        case 'appTitle':
          return CryptoUtils.decrypt('e202b9e3c96d25039eae93d03dd889ec5c4608dedd759eb322a71f058a9ee17605b90c6b28e307');
        case 'baseUrl':
          return CryptoUtils.decrypt('fbb63073a0caa44990dce80368e31e87b7b6320f84043953c650be1505485d892bb53b773aaa40d76b71a136c9e091df97687e2420a8c2b916');
        case 'apiVersion':
          return CryptoUtils.decrypt('faa8f05b480e8dc8cc035bd9397b10d8b664e4017b2ff1d1fe7a22bf9ebb62e56ca03f6e66e65e');
        default:
          return '';
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('解密失败 $key: $e');
      }
      return '';
    }
  }

  /// 从缓存加载配置
  Future<AppConfiguration?> _loadCachedConfig() async {
    try {
      return await ConfigCache.getCachedConfig();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('ConfigManager: 从缓存加载配置失败: $e');
      }
      return null;
    }
  }

  /// 异步加载远程配置
  void _loadRemoteConfigAsync() {
    if (_isRemoteLoading) return;
    
    Future.delayed(Duration.zero, () async {
      await loadRemoteConfig();
    });
  }

  /// 加载远程配置（合并了RemoteConfigLoader功能）
  Future<void> loadRemoteConfig() async {
    if (_isRemoteLoading) return;
    _isRemoteLoading = true;

    try {
      if (kDebugMode) {
        debugPrint('ConfigManager: 开始加载远程配置...');
      }

      final configUrl = ApiConstants.configUrl;
      if (configUrl.isEmpty) {
        if (kDebugMode) {
          debugPrint('ConfigManager: 远程配置URL为空，跳过');
        }
        return;
      }

      // 创建带超时的dio实例
      final dio = Dio();
      dio.options.connectTimeout = const Duration(seconds: 15);
      dio.options.receiveTimeout = const Duration(seconds: 15);
      
      final response = await dio.get(configUrl);

      if (response.statusCode == 200) {
        final remoteConfig = await _parseRemoteConfig(response.data);
        
        if (remoteConfig != null) {
          // 合并远程配置
          final newConfig = _currentConfig!.merge(remoteConfig);
          await _updateConfig(newConfig, ConfigSource.remote);
          
          // 缓存新配置
          await ConfigCache.cacheConfig(newConfig);
          
          if (kDebugMode) {
            debugPrint('ConfigManager: 远程配置加载成功');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('ConfigManager: 远程配置加载失败: $e');
      }
      
      // 使用错误处理器处理远程配置错误
      await ConfigErrorHandler.handleConfigError(e, _currentConfig!);
    } finally {
      _isRemoteLoading = false;
    }
  }

  /// 兼容旧的RemoteConfigLoader接口
  Future<void> loadRemoteConfigForContainer(ProviderContainer container) async {
    await loadRemoteConfig();
    
    // 更新Riverpod状态
    await updateRiverpodState(container);
  }

  /// 解析远程配置
  Future<AppConfiguration?> _parseRemoteConfig(dynamic responseData) async {
    try {
      Map<String, dynamic> outerJson;

      if (responseData is String) {
        outerJson = json.decode(responseData);
      } else if (responseData is Map<String, dynamic>) {
        outerJson = responseData;
      } else {
        throw Exception('未知的远程配置格式');
      }

      if (outerJson.containsKey('config') && outerJson['config'] is String) {
        final encryptedConfig = outerJson['config'] as String;
        final decryptedConfigString = CryptoUtils.decrypt(encryptedConfig);

        if (decryptedConfigString.isEmpty) {
          throw Exception('远程配置解密失败');
        }

        final configData = json.decode(decryptedConfigString) as Map<String, dynamic>;
        return AppConfiguration.fromJson(configData);
      } else {
        throw Exception('远程配置数据格式不正确');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('ConfigManager: 解析远程配置失败: $e');
      }
      return null;
    }
  }

  /// 更新配置
  Future<void> _updateConfig(AppConfiguration newConfig, ConfigSource source) async {
    if (newConfig.isValid()) {
      _currentConfig = newConfig;
      
      // 更新网络管理器
      networkManager.updateBaseUrl(newConfig.baseUrl);
      
      // 通知监听器
      _notifyListeners();
      
      if (kDebugMode) {
        debugPrint('ConfigManager: 配置更新完成，来源: $source');
      }
    } else {
      final errors = newConfig.validate();
      if (kDebugMode) {
        debugPrint('ConfigManager: 配置验证失败: $errors');
      }
      throw ArgumentError('配置验证失败: ${errors.join(', ')}');
    }
  }

  /// 更新Riverpod状态
  Future<void> updateRiverpodState(ProviderContainer? container) async {
    if (container == null || _currentConfig == null) return;
    
    try {
      // 更新baseUrl provider
      container.read(baseUrlProvider.notifier).state = _currentConfig!.baseUrl;
      
      // 更新auth state配置
      container.read(authStateProvider.notifier).updateConfig(_currentConfig!.toJson());
      
      if (kDebugMode) {
        debugPrint('ConfigManager: Riverpod状态更新完成');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('ConfigManager: Riverpod状态更新失败: $e');
      }
    }
  }

  /// 手动更新配置
  Future<void> updateConfig(Map<String, dynamic> configData) async {
    try {
      final newConfig = AppConfiguration.fromJson(configData);
      await _updateConfig(newConfig, ConfigSource.remote);
      
      // 缓存更新后的配置
      await ConfigCache.cacheConfig(newConfig);
      
    } catch (e) {
      if (kDebugMode) {
        debugPrint('ConfigManager: 手动更新配置失败: $e');
      }
      rethrow;
    }
  }

  /// 添加配置监听器
  void addListener(void Function(AppConfiguration) listener) {
    _listeners.add(listener);
  }

  /// 移除配置监听器
  void removeListener(void Function(AppConfiguration) listener) {
    _listeners.remove(listener);
  }

  /// 通知监听器
  void _notifyListeners() {
    if (_currentConfig != null) {
      for (final listener in _listeners) {
        try {
          listener(_currentConfig!);
        } catch (e) {
          if (kDebugMode) {
            debugPrint('ConfigManager: 通知监听器失败: $e');
          }
        }
      }
    }
  }

  /// 重新加载配置
  Future<void> reload() async {
    await initialize();
  }

  /// 清除缓存并重新加载
  Future<void> clearCacheAndReload() async {
    await ConfigCache.clearCache();
    await reload();
  }

  /// 获取配置健康状态
  Future<Map<String, dynamic>> getHealthStatus() async {
    final health = await ConfigErrorHandler.checkConfigHealth();
    
    health['current_config'] = {
      'isValid': _currentConfig?.isValid() ?? false,
      'source': 'merged',
      'lastUpdated': _currentConfig?.lastUpdated.toIso8601String(),
      'version': _currentConfig?.version,
    };
    
    health['manager_status'] = {
      'isLoading': _isLoading,
      'isRemoteLoading': _isRemoteLoading,
      'listenersCount': _listeners.length,
    };
    
    return health;
  }

  /// 释放资源
  void dispose() {
    _listeners.clear();
    _currentConfig = null;
  }
}

/// 全局配置管理器实例
final configManager = ConfigManager.instance;

/// 向后兼容的RemoteConfigLoader
class RemoteConfigLoader {
  Future<void> load(ProviderContainer container) async {
    await configManager.loadRemoteConfigForContainer(container);
  }
}