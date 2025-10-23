import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/startup_optimizer.dart';
import 'package:fl_clash/clash/clash.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/common/network_manager.dart';

/// 应用启动任务配置
class AppStartupTasks {
  static void registerTasks(StartupOptimizer optimizer, WidgetRef ref) {
    // 关键任务 - 核心初始化
    optimizer.registerTask(StartupTask(
      id: 'core_init',
      name: '初始化核心组件',
      priority: StartupTaskPriority.critical,
      phase: StartupPhase.coreLoading,
      timeout: const Duration(seconds: 10),
      executor: () async {
        await globalState.initCore();
        if (kDebugMode) {
          debugPrint('[Startup] 核心组件初始化完成');
        }
      },
    ));

    // 关键任务 - 加载基础配置
    optimizer.registerTask(StartupTask(
      id: 'basic_config',
      name: '加载基础配置',
      priority: StartupTaskPriority.critical,
      phase: StartupPhase.configLoading,
      timeout: const Duration(seconds: 5),
      executor: () async {
        await globalState.loadProfiles();
        if (kDebugMode) {
          debugPrint('[Startup] 基础配置加载完成');
        }
      },
    ));

    // 高优先级任务 - 认证检查
    optimizer.registerTask(StartupTask(
      id: 'auth_check',
      name: '检查用户认证状态',
      priority: StartupTaskPriority.high,
      phase: StartupPhase.authChecking,
      timeout: const Duration(seconds: 8),
      executor: () async {
        final authNotifier = ref.read(authStateProvider.notifier);
        await authNotifier.checkAuthStatus();
        if (kDebugMode) {
          debugPrint('[Startup] 用户认证状态检查完成');
        }
      },
    ));

    // 高优先级任务 - 配置更新检查
    optimizer.registerTask(StartupTask(
      id: 'config_update_check',
      name: '检查配置更新',
      priority: StartupTaskPriority.high,
      phase: StartupPhase.configLoading,
      timeout: const Duration(seconds: 10),
      executor: () async {
        final configNotifier = ref.read(configStateProvider.notifier);
        await configNotifier.fetchConfig();
        if (kDebugMode) {
          debugPrint('[Startup] 配置更新检查完成');
        }
      },
    ));

    // 中优先级任务 - 用户信息预加载
    optimizer.registerTask(StartupTask(
      id: 'user_data_preload',
      name: '预加载用户数据',
      priority: StartupTaskPriority.medium,
      phase: StartupPhase.dataPreloading,
      timeout: const Duration(seconds: 15),
      executor: () async {
        final authState = ref.read(authStateProvider);
        if (authState.isAuthenticated) {
          try {
            final userNotifier = ref.read(userStateProvider.notifier);
            await userNotifier.fetchUserInfo();
            
            // 预加载计划信息
            final planNotifier = ref.read(planStateProvider.notifier);
            await planNotifier.fetchPlans();
            
            if (kDebugMode) {
              debugPrint('[Startup] 用户数据预加载完成');
            }
          } catch (e) {
            if (kDebugMode) {
              debugPrint('[Startup] 用户数据预加载失败: $e');
            }
            // 非关键错误，不影响启动流程
          }
        }
      },
    ));

    // 中优先级任务 - 网络检测
    optimizer.registerTask(StartupTask(
      id: 'network_detection',
      name: '网络连接检测',
      priority: StartupTaskPriority.medium,
      phase: StartupPhase.dataPreloading,
      timeout: const Duration(seconds: 8),
      executor: () async {
        try {
          await NetworkManager.instance.detectNetworkConnectivity();
          if (kDebugMode) {
            debugPrint('[Startup] 网络连接检测完成');
          }
        } catch (e) {
          if (kDebugMode) {
            debugPrint('[Startup] 网络连接检测失败: $e');
          }
          // 网络问题不影响基本功能
        }
      },
    ));

    // 低优先级任务 - IP信息获取
    optimizer.registerTask(StartupTask(
      id: 'ip_info_fetch',
      name: '获取IP信息',
      priority: StartupTaskPriority.low,
      phase: StartupPhase.dataPreloading,
      timeout: const Duration(seconds: 10),
      executor: () async {
        try {
          // 延迟执行，避免启动时网络拥堵
          await Future.delayed(const Duration(seconds: 2));
          await NetworkManager.instance.updateIpInfo();
          if (kDebugMode) {
            debugPrint('[Startup] IP信息获取完成');
          }
        } catch (e) {
          if (kDebugMode) {
            debugPrint('[Startup] IP信息获取失败: $e');
          }
          // IP信息获取失败不影响核心功能
        }
      },
    ));

    // 低优先级任务 - 公告预加载
    optimizer.registerTask(StartupTask(
      id: 'notices_preload',
      name: '预加载公告信息',
      priority: StartupTaskPriority.low,
      phase: StartupPhase.dataPreloading,
      timeout: const Duration(seconds: 10),
      executor: () async {
        try {
          final authState = ref.read(authStateProvider);
          if (authState.isAuthenticated) {
            final noticeNotifier = ref.read(noticeStateProvider.notifier);
            await noticeNotifier.fetchNotices();
            if (kDebugMode) {
              debugPrint('[Startup] 公告信息预加载完成');
            }
          }
        } catch (e) {
          if (kDebugMode) {
            debugPrint('[Startup] 公告信息预加载失败: $e');
          }
          // 公告预加载失败不影响核心功能
        }
      },
    ));

    // 低优先级任务 - 更新检查
    optimizer.registerTask(StartupTask(
      id: 'update_check',
      name: '检查应用更新',
      priority: StartupTaskPriority.low,
      phase: StartupPhase.dataPreloading,
      timeout: const Duration(seconds: 8),
      executor: () async {
        try {
          // 延迟执行更新检查
          await Future.delayed(const Duration(seconds: 5));
          await NetworkManager.instance.checkForUpdate();
          if (kDebugMode) {
            debugPrint('[Startup] 应用更新检查完成');
          }
        } catch (e) {
          if (kDebugMode) {
            debugPrint('[Startup] 应用更新检查失败: $e');
          }
          // 更新检查失败不影响核心功能
        }
      },
    ));
  }
}

/// 启动性能监控
class StartupPerformanceMonitor {
  static final Map<String, DateTime> _checkpoints = {};
  
  static void markCheckpoint(String name) {
    _checkpoints[name] = DateTime.now();
    if (kDebugMode) {
      debugPrint('[Startup Performance] Checkpoint: $name at ${DateTime.now()}');
    }
  }
  
  static void logPerformanceReport() {
    if (!kDebugMode) return;
    
    debugPrint('=== 启动性能报告 ===');
    final startTime = _checkpoints['app_start'];
    if (startTime == null) {
      debugPrint('未找到启动开始时间');
      return;
    }
    
    for (final entry in _checkpoints.entries) {
      if (entry.key == 'app_start') continue;
      
      final duration = entry.value.difference(startTime).inMilliseconds;
      debugPrint('${entry.key}: ${duration}ms');
    }
    
    final endTime = _checkpoints['startup_complete'];
    if (endTime != null) {
      final totalDuration = endTime.difference(startTime).inMilliseconds;
      debugPrint('总启动时间: ${totalDuration}ms');
    }
    
    debugPrint('==================');
  }
}