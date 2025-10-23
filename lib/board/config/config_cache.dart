import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_configuration.dart';

/// 配置缓存管理器
class ConfigCache {
  static const String _cacheKey = 'app_config_cache';
  static const String _cacheVersionKey = 'app_config_cache_version';
  static const Duration _cacheExpiry = Duration(hours: 24);
  static const int _currentCacheVersion = 1;

  /// 缓存配置
  static Future<void> cacheConfig(AppConfiguration config) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      final cacheData = {
        'config': config.toJson(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'version': config.version,
        'cacheVersion': _currentCacheVersion,
      };
      
      await prefs.setString(_cacheKey, json.encode(cacheData));
      await prefs.setInt(_cacheVersionKey, _currentCacheVersion);
      
      if (kDebugMode) {
        debugPrint('配置已缓存: ${config.toString()}');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('缓存配置失败: $e');
      }
    }
  }

  /// 获取缓存的配置
  static Future<AppConfiguration?> getCachedConfig() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // 检查缓存版本
      final cacheVersion = prefs.getInt(_cacheVersionKey) ?? 0;
      if (cacheVersion != _currentCacheVersion) {
        if (kDebugMode) {
          debugPrint('缓存版本不匹配，清除缓存');
        }
        await clearCache();
        return null;
      }
      
      final cached = prefs.getString(_cacheKey);
      if (cached == null) {
        if (kDebugMode) {
          debugPrint('未找到缓存配置');
        }
        return null;
      }
      
      final data = json.decode(cached) as Map<String, dynamic>;
      final timestamp = DateTime.fromMillisecondsSinceEpoch(data['timestamp'] ?? 0);
      
      // 检查缓存是否过期
      if (DateTime.now().difference(timestamp) > _cacheExpiry) {
        if (kDebugMode) {
          debugPrint('缓存配置已过期，清除缓存');
        }
        await clearCache();
        return null;
      }
      
      final config = AppConfiguration.fromJson(data['config'] as Map<String, dynamic>);
      
      if (kDebugMode) {
        debugPrint('从缓存加载配置: ${config.toString()}');
      }
      
      return config;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('获取缓存配置失败: $e');
      }
      // 如果缓存损坏，清除缓存
      await clearCache();
      return null;
    }
  }

  /// 检查缓存是否存在且有效
  static Future<bool> isCacheValid() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // 检查缓存版本
      final cacheVersion = prefs.getInt(_cacheVersionKey) ?? 0;
      if (cacheVersion != _currentCacheVersion) {
        return false;
      }
      
      final cached = prefs.getString(_cacheKey);
      if (cached == null) return false;
      
      final data = json.decode(cached) as Map<String, dynamic>;
      final timestamp = DateTime.fromMillisecondsSinceEpoch(data['timestamp'] ?? 0);
      
      return DateTime.now().difference(timestamp) <= _cacheExpiry;
    } catch (e) {
      return false;
    }
  }

  /// 清除缓存
  static Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cacheKey);
      await prefs.remove(_cacheVersionKey);
      
      if (kDebugMode) {
        debugPrint('配置缓存已清除');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('清除缓存失败: $e');
      }
    }
  }

  /// 获取缓存信息
  static Future<Map<String, dynamic>?> getCacheInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cached = prefs.getString(_cacheKey);
      
      if (cached == null) return null;
      
      final data = json.decode(cached) as Map<String, dynamic>;
      final timestamp = DateTime.fromMillisecondsSinceEpoch(data['timestamp'] ?? 0);
      final isExpired = DateTime.now().difference(timestamp) > _cacheExpiry;
      
      return {
        'timestamp': timestamp.toIso8601String(),
        'version': data['version'],
        'cacheVersion': data['cacheVersion'],
        'isExpired': isExpired,
        'expiresAt': timestamp.add(_cacheExpiry).toIso8601String(),
      };
    } catch (e) {
      return null;
    }
  }

  /// 更新缓存时间戳（用于延长缓存有效期）
  static Future<void> touchCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cached = prefs.getString(_cacheKey);
      
      if (cached != null) {
        final data = json.decode(cached) as Map<String, dynamic>;
        data['timestamp'] = DateTime.now().millisecondsSinceEpoch;
        
        await prefs.setString(_cacheKey, json.encode(data));
        
        if (kDebugMode) {
          debugPrint('缓存时间戳已更新');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('更新缓存时间戳失败: $e');
      }
    }
  }
}