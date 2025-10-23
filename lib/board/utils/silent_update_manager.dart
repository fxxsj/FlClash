import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/board/constants/app_config.dart';

/// 全局静默更新管理器
/// 负责在多个页面中统一管理订阅的静默更新逻辑
class SilentUpdateManager {
  static DateTime? _lastUpdateTime;
  static const Duration _updateInterval = Duration(minutes: 30); // 30分钟间隔
  static bool _isUpdating = false;

  /// 检查是否需要触发静默更新
  /// 可以从任何页面调用这个方法
  static void triggerSilentUpdateIfNeeded(WidgetRef ref, {String? pageName}) {
    if (kDebugMode) {
      debugPrint('SilentUpdateManager: ${pageName ?? "未知页面"} 请求静默更新检查');
    }
    
    final authState = ref.read(authStateProvider);
    if (!authState.isAuthenticated) {
      if (kDebugMode) {
        debugPrint('SilentUpdateManager: 用户未认证，跳过静默更新');
      }
      return;
    }

    // 防止并发更新
    if (_isUpdating) {
      if (kDebugMode) {
        debugPrint('SilentUpdateManager: 正在更新中，跳过本次请求');
      }
      return;
    }

    final now = DateTime.now();
    
    if (kDebugMode) {
      debugPrint('SilentUpdateManager: 当前时间: ${now.toString()}');
      debugPrint('SilentUpdateManager: 上次更新时间: ${_lastUpdateTime?.toString() ?? "null"}');
    }
    
    // 如果是第一次更新，或者距离上次更新已超过间隔时间，则执行更新
    if (_lastUpdateTime == null || now.difference(_lastUpdateTime!) > _updateInterval) {
      _lastUpdateTime = now;
      _silentUpdateSubscription(ref, pageName: pageName);
      
      if (kDebugMode) {
        debugPrint('SilentUpdateManager: ✅ 触发静默更新订阅 - 时间: ${now.toString()} - 页面: ${pageName ?? "未知"}');
      }
    } else {
      if (kDebugMode) {
        final remainingTime = _updateInterval - now.difference(_lastUpdateTime!);
        debugPrint('SilentUpdateManager: ❌ 跳过静默更新 - 剩余冷却时间: ${remainingTime.inMinutes}分${remainingTime.inSeconds % 60}秒');
      }
    }
  }

  /// 手动触发更新检查（忽略时间间隔限制）
  static void forceUpdate(WidgetRef ref, {String? pageName}) {
    if (kDebugMode) {
      debugPrint('SilentUpdateManager: ${pageName ?? "未知页面"} 强制触发静默更新');
    }
    
    final authState = ref.read(authStateProvider);
    if (!authState.isAuthenticated) {
      if (kDebugMode) {
        debugPrint('SilentUpdateManager: 用户未认证，无法强制更新');
      }
      return;
    }

    _lastUpdateTime = DateTime.now();
    _silentUpdateSubscription(ref, pageName: pageName);
  }

  /// 静默更新订阅配置
  /// 在后台执行，不显示加载状态或错误提示，确保不影响用户体验
  /// 优先使用现有配置更新，避免中断连接
  static Future<void> _silentUpdateSubscription(WidgetRef ref, {String? pageName}) async {
    if (_isUpdating) return;
    
    _isUpdating = true;
    
    try {
      final userStateNotifier = ref.read(userStateProvider.notifier);
      final subscribeInfo = await userStateNotifier.getSubscribeInfo();

      if (subscribeInfo == null) {
        if (kDebugMode) {
          debugPrint('SilentUpdateManager: 无订阅信息');
        }
        return;
      }

      // 获取token并构建订阅URL
      final String? token = subscribeInfo['token'] as String?;
      
      String? subscribeUrl;
      if (token != null) {
        final String? originalUrl = subscribeInfo['url'] as String?;
        if (originalUrl != null) {
          // 查找 api/v1/ 的位置
          final int apiIndex = originalUrl.indexOf('api/v1/');
          if (apiIndex != -1) {
            // 提取 api/v1/ 后面的部分
            final String pathAfterApi = originalUrl.substring(apiIndex + 'api/v1/'.length);
            subscribeUrl = '${AppConfig.fullApiUrl}/$pathAfterApi';
          } else {
            // 如果没有找到 api/v1/，回退到原来的逻辑
            subscribeUrl = '${AppConfig.fullApiUrl}/client/subscribe?token=$token';
          }
        } else {
          // 如果没有原始URL，使用默认逻辑
          subscribeUrl = '${AppConfig.fullApiUrl}/client/subscribe?token=$token';
        }
      }
      
      if (token == null || subscribeUrl == null) {
        if (kDebugMode) {
          debugPrint('SilentUpdateManager: token或URL无效');
        }
        return;
      }
      
      // 智能更新策略：优先使用现有配置更新，避免中断连接
      await _smartUpdateSubscription(token, subscribeUrl, userStateNotifier, pageName: pageName);
      
    } catch (e) {
      // 静默处理错误，不显示给用户，只记录到调试日志
      if (kDebugMode) {
        debugPrint('SilentUpdateManager: 静默更新订阅失败: $e');
      }
    } finally {
      _isUpdating = false;
    }
  }

  /// 智能更新订阅配置
  /// 优先尝试更新现有包含token的配置，失败时才进行完全重新订阅
  static Future<void> _smartUpdateSubscription(String token, String subscribeUrl, dynamic userStateNotifier, {String? pageName}) async {
    final profiles = globalState.config.profiles;
    
    if (kDebugMode) {
      debugPrint('SilentUpdateManager: 智能更新开始检查现有配置 (${pageName ?? "未知页面"})');
      debugPrint('  当前配置数量: ${profiles.length}');
      debugPrint('  目标token: $token');
      debugPrint('  目标URL: $subscribeUrl');
    }
    
    // 查找包含当前token的配置
    List<Profile> tokenProfiles = [];
    for (final profile in profiles) {
      if (profile.url.contains(token)) {
        tokenProfiles.add(profile);
        if (kDebugMode) {
          debugPrint('  找到匹配配置: ${profile.label ?? profile.id} (${profile.id})');
        }
      }
    }
    
    bool updateSuccess = false;
    
    if (tokenProfiles.isNotEmpty) {
      if (kDebugMode) {
        debugPrint('SilentUpdateManager: 尝试更新现有配置 (${tokenProfiles.length}个)');
      }
      
      // 尝试更新现有包含token的配置
      for (final profile in tokenProfiles) {
        try {
          if (kDebugMode) {
            debugPrint('  正在更新配置: ${profile.label ?? profile.id}');
          }
          
          // 如果URL已经是最新的，直接更新配置内容
          if (profile.url == subscribeUrl) {
            await globalState.appController.updateProfile(profile);
          } else {
            // 如果URL需要更新，先更新Profile对象的URL再进行更新
            final updatedProfile = profile.copyWith(url: subscribeUrl);
            await globalState.appController.updateProfile(updatedProfile);
          }
          
          updateSuccess = true;
          if (kDebugMode) {
            debugPrint('  ✅ 配置更新成功: ${profile.label ?? profile.id}');
          }
        } catch (e) {
          if (kDebugMode) {
            debugPrint('  ❌ 配置更新失败: ${profile.label ?? profile.id} - $e');
          }
        }
      }
    }
    
    // 如果现有配置更新失败或不存在匹配配置，则进行完全重新订阅
    if (!updateSuccess) {
      if (kDebugMode) {
        debugPrint('SilentUpdateManager: 现有配置更新失败，进行完全重新订阅');
      }
      
      // 删除所有现有配置
      for (final profile in profiles) {
        await globalState.appController.deleteProfile(profile.id);
        if (kDebugMode) {
          debugPrint('  删除配置: ${profile.label ?? profile.id}');
        }
      }
      
      // 创建新配置
      final profile = await Profile.normal(url: subscribeUrl).update();
      await globalState.appController.addProfile(profile);
      
      if (kDebugMode) {
        debugPrint('  ✅ 新配置创建成功: ${profile.label ?? profile.id}');
      }
    }
    
    // 刷新用户状态
    await userStateNotifier.refresh();
    
    if (kDebugMode) {
      debugPrint('SilentUpdateManager: 订阅更新完成 (策略: ${updateSuccess ? "现有配置更新" : "完全重新订阅"}) - 页面: ${pageName ?? "未知"}');
    }
  }

  /// 重置更新时间（用于测试或特殊情况）
  static void resetUpdateTime() {
    _lastUpdateTime = null;
    _isUpdating = false;
    if (kDebugMode) {
      debugPrint('SilentUpdateManager: 更新时间已重置');
    }
  }

  /// 获取距离下次更新的剩余时间
  static Duration? getTimeUntilNextUpdate() {
    if (_lastUpdateTime == null) return null;
    final now = DateTime.now();
    final nextUpdateTime = _lastUpdateTime!.add(_updateInterval);
    if (now.isAfter(nextUpdateTime)) return Duration.zero;
    return nextUpdateTime.difference(now);
  }
}