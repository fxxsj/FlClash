import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'app_configuration.dart';
import 'config_cache.dart';

/// 配置错误类型
enum ConfigErrorType {
  networkError,
  decryptionError,
  validationError,
  cacheError,
  unknownError,
}

/// 配置错误信息
class ConfigError {
  final ConfigErrorType type;
  final String message;
  final dynamic originalError;
  final StackTrace? stackTrace;

  ConfigError({
    required this.type,
    required this.message,
    this.originalError,
    this.stackTrace,
  });

  @override
  String toString() {
    return 'ConfigError(type: $type, message: $message)';
  }
}

/// 配置错误处理器
class ConfigErrorHandler {
  /// 处理配置错误，返回可用的配置
  static Future<AppConfiguration> handleConfigError(
    dynamic error, 
    AppConfiguration fallbackConfig,
  ) async {
    final configError = _parseError(error);
    
    if (kDebugMode) {
      debugPrint('配置错误: ${configError.toString()}');
      if (configError.originalError != null) {
        debugPrint('原始错误: ${configError.originalError}');
      }
    }

    // 根据错误类型选择恢复策略
    switch (configError.type) {
      case ConfigErrorType.networkError:
        return await _handleNetworkError(configError, fallbackConfig);
      
      case ConfigErrorType.decryptionError:
        return await _handleDecryptionError(configError, fallbackConfig);
      
      case ConfigErrorType.validationError:
        return await _handleValidationError(configError, fallbackConfig);
      
      case ConfigErrorType.cacheError:
        return await _handleCacheError(configError, fallbackConfig);
      
      case ConfigErrorType.unknownError:
        return await _handleUnknownError(configError, fallbackConfig);
    }
  }

  /// 解析错误类型
  static ConfigError _parseError(dynamic error) {
    if (error is DioException) {
      return ConfigError(
        type: ConfigErrorType.networkError,
        message: '网络请求失败: ${error.message}',
        originalError: error,
      );
    }
    
    if (error is FormatException) {
      return ConfigError(
        type: ConfigErrorType.decryptionError,
        message: '数据解密或解析失败: ${error.message}',
        originalError: error,
      );
    }
    
    if (error is ArgumentError) {
      return ConfigError(
        type: ConfigErrorType.validationError,
        message: '配置验证失败: ${error.message}',
        originalError: error,
      );
    }
    
    if (error is Exception) {
      final message = error.toString();
      if (message.contains('缓存') || message.contains('cache')) {
        return ConfigError(
          type: ConfigErrorType.cacheError,
          message: '缓存操作失败: $message',
          originalError: error,
        );
      }
      
      if (message.contains('解密') || message.contains('decrypt')) {
        return ConfigError(
          type: ConfigErrorType.decryptionError,
          message: '解密失败: $message',
          originalError: error,
        );
      }
    }
    
    return ConfigError(
      type: ConfigErrorType.unknownError,
      message: '未知错误: ${error.toString()}',
      originalError: error,
    );
  }

  /// 处理网络错误
  static Future<AppConfiguration> _handleNetworkError(
    ConfigError error, 
    AppConfiguration fallbackConfig,
  ) async {
    if (kDebugMode) {
      debugPrint('处理网络错误，尝试从缓存恢复...');
    }
    
    // 尝试从缓存恢复
    final cachedConfig = await ConfigCache.getCachedConfig();
    if (cachedConfig != null && cachedConfig.isValid()) {
      if (kDebugMode) {
        debugPrint('从缓存成功恢复配置');
      }
      return cachedConfig;
    }
    
    // 使用降级配置
    if (kDebugMode) {
      debugPrint('缓存不可用，使用降级配置');
    }
    return fallbackConfig;
  }

  /// 处理解密错误
  static Future<AppConfiguration> _handleDecryptionError(
    ConfigError error, 
    AppConfiguration fallbackConfig,
  ) async {
    if (kDebugMode) {
      debugPrint('处理解密错误，清除可能损坏的缓存...');
    }
    
    // 清除可能损坏的缓存
    await ConfigCache.clearCache();
    
    // 尝试从缓存恢复（如果有旧的有效缓存）
    final cachedConfig = await ConfigCache.getCachedConfig();
    if (cachedConfig != null && cachedConfig.isValid()) {
      if (kDebugMode) {
        debugPrint('从备用缓存恢复配置');
      }
      return cachedConfig;
    }
    
    // 使用降级配置
    if (kDebugMode) {
      debugPrint('解密失败，使用降级配置');
    }
    return fallbackConfig;
  }

  /// 处理验证错误
  static Future<AppConfiguration> _handleValidationError(
    ConfigError error, 
    AppConfiguration fallbackConfig,
  ) async {
    if (kDebugMode) {
      debugPrint('处理验证错误，尝试修复配置...');
    }
    
    // 如果降级配置也无效，创建最小可用配置
    if (!fallbackConfig.isValid()) {
      final minimalConfig = AppConfiguration.defaults();
      if (kDebugMode) {
        debugPrint('创建最小可用配置');
      }
      return minimalConfig;
    }
    
    return fallbackConfig;
  }

  /// 处理缓存错误
  static Future<AppConfiguration> _handleCacheError(
    ConfigError error, 
    AppConfiguration fallbackConfig,
  ) async {
    if (kDebugMode) {
      debugPrint('处理缓存错误，清除损坏的缓存...');
    }
    
    // 清除损坏的缓存
    await ConfigCache.clearCache();
    
    // 使用降级配置
    return fallbackConfig;
  }

  /// 处理未知错误
  static Future<AppConfiguration> _handleUnknownError(
    ConfigError error, 
    AppConfiguration fallbackConfig,
  ) async {
    if (kDebugMode) {
      debugPrint('处理未知错误，使用降级配置...');
    }
    
    // 记录错误但不影响应用运行
    _logError(error);
    
    // 尝试从缓存恢复
    final cachedConfig = await ConfigCache.getCachedConfig();
    if (cachedConfig != null && cachedConfig.isValid()) {
      if (kDebugMode) {
        debugPrint('从缓存恢复配置');
      }
      return cachedConfig;
    }
    
    // 使用降级配置
    return fallbackConfig;
  }

  /// 记录错误信息
  static void _logError(ConfigError error) {
    if (kDebugMode) {
      debugPrint('=== 配置错误详情 ===');
      debugPrint('类型: ${error.type}');
      debugPrint('消息: ${error.message}');
      if (error.originalError != null) {
        debugPrint('原始错误: ${error.originalError}');
      }
      if (error.stackTrace != null) {
        debugPrint('堆栈跟踪: ${error.stackTrace}');
      }
      debugPrint('==================');
    }
  }

  /// 创建安全的降级配置
  static AppConfiguration createSafeFallbackConfig() {
    return AppConfiguration.defaults().copyWith(
      appTitle: 'FlClash',
      baseUrl: '', // 空baseUrl会在运行时被处理
      apiVersion: '/api/v1',
      updateUrl: 'https://cloud.ziu.ooo/FxClash/',
      updateCheckUrl: 'https://f005.backblazeb2.com/file/fx2025/app_latest_version.json',
      version: 1,
      lastUpdated: DateTime.now(),
    );
  }

  /// 检查配置健康状态
  static Future<Map<String, dynamic>> checkConfigHealth() async {
    final healthStatus = <String, dynamic>{
      'timestamp': DateTime.now().toIso8601String(),
      'cache': {},
      'errors': [],
    };

    try {
      // 检查缓存状态
      final cacheInfo = await ConfigCache.getCacheInfo();
      final isCacheValid = await ConfigCache.isCacheValid();
      
      healthStatus['cache'] = {
        'info': cacheInfo,
        'isValid': isCacheValid,
        'status': isCacheValid ? 'healthy' : 'expired_or_invalid',
      };
      
      // 检查缓存配置
      final cachedConfig = await ConfigCache.getCachedConfig();
      if (cachedConfig != null) {
        final validationErrors = cachedConfig.validate();
        if (validationErrors.isNotEmpty) {
          healthStatus['errors'].addAll(validationErrors);
        }
      }
      
    } catch (e) {
      healthStatus['errors'].add('健康检查失败: ${e.toString()}');
    }

    return healthStatus;
  }
}