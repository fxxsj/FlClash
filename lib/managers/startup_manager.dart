import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/clash/core.dart';
import 'package:fl_clash/board/riverpod_setup.dart';
import 'package:fl_clash/board/config/security_config.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/managers/async_geo_loader.dart';

/// 启动阶段枚举
enum StartupPhase {
  security,       // 安全配置
  system,         // 系统信息
  riverpod,       // Riverpod设置
  clashCore,      // Clash核心
  globalState,    // 全局状态
  platform,       // 平台初始化
  completed,      // 完成
}

/// 启动进度回调
typedef StartupProgressCallback = void Function(StartupPhase phase, double progress, String message);

/// 优化的启动管理器
class OptimizedStartupManager {
  static OptimizedStartupManager? _instance;
  static OptimizedStartupManager get instance => _instance ??= OptimizedStartupManager._();
  
  OptimizedStartupManager._();

  /// 启动进度监听器
  final List<StartupProgressCallback> _progressListeners = [];
  
  /// 当前启动阶段
  StartupPhase _currentPhase = StartupPhase.security;
  
  /// 启动是否完成
  bool _isCompleted = false;
  bool get isCompleted => _isCompleted;
  
  /// Riverpod容器
  dynamic _container;
  dynamic get container => _container;
  
  /// 添加进度监听器
  void addProgressListener(StartupProgressCallback listener) {
    _progressListeners.add(listener);
  }
  
  /// 移除进度监听器
  void removeProgressListener(StartupProgressCallback listener) {
    _progressListeners.remove(listener);
  }
  
  /// 通知进度更新
  void _notifyProgress(StartupPhase phase, double progress, String message) {
    _currentPhase = phase;
    for (final listener in _progressListeners) {
      try {
        listener(phase, progress, message);
      } catch (e) {
        debugPrint('进度监听器错误: $e');
      }
    }
  }

  /// 优化的并行启动流程
  Future<void> performOptimizedStartup() async {
    if (_isCompleted) return;
    
    final stopwatch = Stopwatch()..start();
    
    try {
      debugPrint('🚀 开始优化启动流程...');
      
      // 阶段1: 安全配置初始化 (即时完成)
      await _initializeSecurity();
      
      // 阶段2: 并行初始化核心组件
      await _parallelCoreInitialization();
      
      // 阶段3: 依赖全局状态的组件初始化
      await _initializeGlobalState();
      
      // 阶段4: 平台特定初始化
      await _initializePlatform();
      
      // 阶段5: 启动后台任务（异步，不阻塞UI）
      _startBackgroundTasks();
      
      // 完成
      _notifyProgress(StartupPhase.completed, 1.0, '启动完成');
      _isCompleted = true;
      
      stopwatch.stop();
      debugPrint('✅ 启动完成，总耗时: ${stopwatch.elapsedMilliseconds}ms');
      
    } catch (e, stackTrace) {
      debugPrint('❌ 启动失败: $e');
      debugPrint('堆栈跟踪: $stackTrace');
      
      // 即使失败也标记为完成，避免卡住
      _isCompleted = true;
      _notifyProgress(StartupPhase.completed, 1.0, '启动完成 (部分功能可能受限)');
      rethrow;
    }
  }

  /// 阶段1: 安全配置初始化
  Future<void> _initializeSecurity() async {
    _notifyProgress(StartupPhase.security, 0.1, '初始化安全配置...');
    
    try {
      SecurityConfig.init();
      await Future.delayed(const Duration(milliseconds: 50)); // 确保初始化完成
      debugPrint('✓ 安全配置初始化完成');
    } catch (e) {
      debugPrint('⚠ 安全配置初始化失败: $e');
      // 非关键错误，继续执行
    }
  }

  /// 阶段2: 并行初始化核心组件
  Future<void> _parallelCoreInitialization() async {
    _notifyProgress(StartupPhase.system, 0.2, '并行加载核心组件...');
    
    try {
      // 创建并行任务列表
      final futures = <Future>[
        _initializeSystemInfo(),
        _initializeRiverpod(),
        _preloadClashCore(),
      ];
      
      // 并行执行，等待所有任务完成
      await Future.wait(futures);
      
      debugPrint('✓ 核心组件并行初始化完成');
    } catch (e) {
      debugPrint('⚠ 核心组件初始化部分失败: $e');
      // 继续执行，某些功能可能受限
    }
  }

  /// 系统信息获取
  Future<void> _initializeSystemInfo() async {
    try {
      final version = await system.version;
      debugPrint('✓ 系统版本获取完成: $version');
    } catch (e) {
      debugPrint('⚠ 系统信息获取失败: $e');
    }
  }

  /// Riverpod容器初始化
  Future<void> _initializeRiverpod() async {
    try {
      _container = await setupRiverpod();
      debugPrint('✓ Riverpod容器初始化完成');
    } catch (e) {
      debugPrint('⚠ Riverpod初始化失败: $e');
      rethrow; // Riverpod是关键组件，失败需要抛出
    }
  }

  /// Clash核心预加载
  Future<void> _preloadClashCore() async {
    try {
      await clashCore.preload();
      debugPrint('✓ Clash核心预加载完成');
    } catch (e) {
      debugPrint('⚠ Clash核心预加载失败: $e');
      // 非关键错误，核心可以延迟加载
    }
  }

  /// 阶段3: 全局状态初始化
  Future<void> _initializeGlobalState() async {
    _notifyProgress(StartupPhase.globalState, 0.7, '初始化应用状态...');
    
    try {
      final version = await system.version;
      await globalState.initApp(version);
      debugPrint('✓ 全局状态初始化完成');
    } catch (e) {
      debugPrint('⚠ 全局状态初始化失败: $e');
      rethrow; // 全局状态是关键组件
    }
  }

  /// 阶段4: 平台特定初始化
  Future<void> _initializePlatform() async {
    _notifyProgress(StartupPhase.platform, 0.9, '初始化平台组件...');
    
    try {
      // 并行初始化平台组件
      final futures = <Future>[];
      
      if (android != null) {
        futures.add(_initializeAndroid());
      }
      
      if (window != null) {
        futures.add(_initializeWindow());
      }
      
      // 设置HTTP覆盖
      futures.add(_setupHttpOverrides());
      
      // 等待所有平台初始化完成
      await Future.wait(futures);
      
      debugPrint('✓ 平台组件初始化完成');
    } catch (e) {
      debugPrint('⚠ 平台初始化部分失败: $e');
      // 平台特定功能失败不影响核心功能
    }
  }

  /// Android平台初始化
  Future<void> _initializeAndroid() async {
    try {
      await android?.init();
      debugPrint('✓ Android平台初始化完成');
    } catch (e) {
      debugPrint('⚠ Android初始化失败: $e');
    }
  }

  /// Windows平台初始化
  Future<void> _initializeWindow() async {
    try {
      final version = await system.version;
      await window?.init(version);
      debugPrint('✓ Windows平台初始化完成');
    } catch (e) {
      debugPrint('⚠ Windows初始化失败: $e');
    }
  }

  /// 设置HTTP覆盖
  Future<void> _setupHttpOverrides() async {
    try {
      HttpOverrides.global = FlClashHttpOverrides();
      debugPrint('✓ HTTP覆盖设置完成');
    } catch (e) {
      debugPrint('⚠ HTTP覆盖设置失败: $e');
    }
  }

  /// 启动后台任务（异步执行，不阻塞UI）
  void _startBackgroundTasks() {
    debugPrint('🔄 启动后台任务...');
    
    // 异步加载Geo数据
    _startAsyncGeoLoading();
    
    // 其他后台任务可以在这里添加
    _startOtherBackgroundTasks();
  }

  /// 异步加载Geo数据
  void _startAsyncGeoLoading() {
    // 设置进度回调
    asyncGeoLoader.setProgressCallback((progress, fileName) {
      debugPrint('Geo加载进度: ${(progress * 100).toInt()}% - $fileName');
    });
    
    // 在后台加载
    asyncGeoLoader.loadGeoDataAsync().then((_) {
      debugPrint('✅ Geo数据后台加载完成');
    }).catchError((e) {
      debugPrint('⚠ Geo数据后台加载失败: $e');
    });
  }

  /// 启动其他后台任务
  void _startOtherBackgroundTasks() {
    // 这里可以添加其他需要后台执行的任务
    // 比如：配置文件预热、缓存预加载等
  }

  /// 重置启动状态（用于测试）
  void reset() {
    _isCompleted = false;
    _currentPhase = StartupPhase.security;
    _progressListeners.clear();
    _container = null;
  }

  /// 获取启动进度百分比
  double getProgressPercentage() {
    switch (_currentPhase) {
      case StartupPhase.security:
        return 0.1;
      case StartupPhase.system:
        return 0.3;
      case StartupPhase.riverpod:
        return 0.5;
      case StartupPhase.clashCore:
        return 0.6;
      case StartupPhase.globalState:
        return 0.8;
      case StartupPhase.platform:
        return 0.95;
      case StartupPhase.completed:
        return 1.0;
    }
  }

  /// 获取当前阶段描述
  String getCurrentPhaseDescription() {
    switch (_currentPhase) {
      case StartupPhase.security:
        return '初始化安全配置...';
      case StartupPhase.system:
        return '获取系统信息...';
      case StartupPhase.riverpod:
        return '设置状态管理...';
      case StartupPhase.clashCore:
        return '预加载Clash核心...';
      case StartupPhase.globalState:
        return '初始化应用状态...';
      case StartupPhase.platform:
        return '初始化平台组件...';
      case StartupPhase.completed:
        return '启动完成';
    }
  }
}

/// 全局启动管理器实例
final startupManager = OptimizedStartupManager.instance;