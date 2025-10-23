import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 启动阶段枚举
enum StartupPhase {
  initial,
  coreLoading,
  configLoading,
  authChecking,
  dataPreloading,
  ready,
}

/// 启动任务优先级
enum StartupTaskPriority {
  critical,  // 必须完成才能继续的任务
  high,      // 影响用户体验的重要任务
  medium,    // 可以延迟但较重要的任务
  low,       // 可以后台执行的任务
}

/// 启动任务
class StartupTask {
  final String id;
  final String name;
  final StartupTaskPriority priority;
  final StartupPhase phase;
  final Future<void> Function() executor;
  final VoidCallback? onComplete;
  final Duration? timeout;
  
  const StartupTask({
    required this.id,
    required this.name,
    required this.priority,
    required this.phase,
    required this.executor,
    this.onComplete,
    this.timeout,
  });
}

/// 启动状态
class StartupState {
  final StartupPhase currentPhase;
  final Map<String, bool> taskStatuses;
  final double progress;
  final String? currentTaskName;
  final bool isComplete;
  final String? error;

  const StartupState({
    required this.currentPhase,
    required this.taskStatuses,
    required this.progress,
    this.currentTaskName,
    this.isComplete = false,
    this.error,
  });

  StartupState copyWith({
    StartupPhase? currentPhase,
    Map<String, bool>? taskStatuses,
    double? progress,
    String? currentTaskName,
    bool? isComplete,
    String? error,
  }) {
    return StartupState(
      currentPhase: currentPhase ?? this.currentPhase,
      taskStatuses: taskStatuses ?? this.taskStatuses,
      progress: progress ?? this.progress,
      currentTaskName: currentTaskName ?? this.currentTaskName,
      isComplete: isComplete ?? this.isComplete,
      error: error ?? this.error,
    );
  }
}

/// 启动优化器
class StartupOptimizer extends StateNotifier<StartupState> {
  final List<StartupTask> _tasks = [];
  final Map<StartupPhase, List<StartupTask>> _phaseTasksMap = {};
  
  StartupOptimizer() : super(const StartupState(
    currentPhase: StartupPhase.initial,
    taskStatuses: {},
    progress: 0.0,
  ));

  /// 注册启动任务
  void registerTask(StartupTask task) {
    _tasks.add(task);
    _phaseTasksMap.putIfAbsent(task.phase, () => []).add(task);
    
    // 按优先级排序
    _phaseTasksMap[task.phase]!.sort((a, b) {
      const priorityOrder = {
        StartupTaskPriority.critical: 0,
        StartupTaskPriority.high: 1,
        StartupTaskPriority.medium: 2,
        StartupTaskPriority.low: 3,
      };
      return priorityOrder[a.priority]!.compareTo(priorityOrder[b.priority]!);
    });
  }

  /// 开始启动流程
  Future<void> startupFlow() async {
    try {
      state = state.copyWith(currentPhase: StartupPhase.initial);
      
      for (final phase in StartupPhase.values) {
        if (phase == StartupPhase.initial) continue;
        
        await _executePhase(phase);
        
        if (state.error != null) {
          break;
        }
      }
      
      if (state.error == null) {
        state = state.copyWith(
          isComplete: true,
          progress: 1.0,
          currentTaskName: '启动完成',
        );
      }
    } catch (e) {
      state = state.copyWith(
        error: '启动失败: ${e.toString()}',
      );
    }
  }

  /// 执行阶段任务
  Future<void> _executePhase(StartupPhase phase) async {
    final phaseTasks = _phaseTasksMap[phase] ?? [];
    if (phaseTasks.isEmpty) return;

    state = state.copyWith(currentPhase: phase);

    // 分离关键任务和非关键任务
    final criticalTasks = phaseTasks
        .where((task) => task.priority == StartupTaskPriority.critical)
        .toList();
    final nonCriticalTasks = phaseTasks
        .where((task) => task.priority != StartupTaskPriority.critical)
        .toList();

    // 顺序执行关键任务
    for (final task in criticalTasks) {
      await _executeTask(task);
      if (state.error != null) return;
    }

    // 并行执行非关键任务（高优先级优先）
    final highPriorityTasks = nonCriticalTasks
        .where((task) => task.priority == StartupTaskPriority.high)
        .toList();
    final mediumPriorityTasks = nonCriticalTasks
        .where((task) => task.priority == StartupTaskPriority.medium)
        .toList();
    final lowPriorityTasks = nonCriticalTasks
        .where((task) => task.priority == StartupTaskPriority.low)
        .toList();

    // 高优先级任务并行执行
    if (highPriorityTasks.isNotEmpty) {
      await Future.wait(
        highPriorityTasks.map((task) => _executeTaskSafely(task))
      );
    }

    // 中优先级任务并行执行
    if (mediumPriorityTasks.isNotEmpty) {
      await Future.wait(
        mediumPriorityTasks.map((task) => _executeTaskSafely(task))
      );
    }

    // 低优先级任务后台执行（不等待完成）
    for (final task in lowPriorityTasks) {
      _executeTaskSafely(task);
    }
  }

  /// 执行单个任务（安全版本，不会抛出异常）
  Future<void> _executeTaskSafely(StartupTask task) async {
    try {
      await _executeTask(task);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('启动任务失败 [${task.id}]: $e');
      }
      // 非关键任务失败不影响整体启动流程
      final updatedStatuses = Map<String, bool>.from(state.taskStatuses);
      updatedStatuses[task.id] = false;
      state = state.copyWith(taskStatuses: updatedStatuses);
    }
  }

  /// 执行单个任务
  Future<void> _executeTask(StartupTask task) async {
    state = state.copyWith(currentTaskName: task.name);
    
    try {
      if (task.timeout != null) {
        await task.executor().timeout(task.timeout!);
      } else {
        await task.executor();
      }
      
      final updatedStatuses = Map<String, bool>.from(state.taskStatuses);
      updatedStatuses[task.id] = true;
      
      state = state.copyWith(
        taskStatuses: updatedStatuses,
        progress: _calculateProgress(),
      );
      
      task.onComplete?.call();
      
    } catch (e) {
      if (task.priority == StartupTaskPriority.critical) {
        state = state.copyWith(
          error: '关键任务失败 [${task.name}]: ${e.toString()}',
        );
        rethrow;
      } else {
        // 非关键任务失败记录但不中断流程
        final updatedStatuses = Map<String, bool>.from(state.taskStatuses);
        updatedStatuses[task.id] = false;
        state = state.copyWith(taskStatuses: updatedStatuses);
        
        if (kDebugMode) {
          debugPrint('非关键任务失败 [${task.name}]: $e');
        }
      }
    }
  }

  /// 计算总体进度
  double _calculateProgress() {
    if (_tasks.isEmpty) return 1.0;
    
    final completedTasks = state.taskStatuses.values
        .where((completed) => completed)
        .length;
    
    return completedTasks / _tasks.length;
  }

  /// 重置启动状态
  void reset() {
    state = const StartupState(
      currentPhase: StartupPhase.initial,
      taskStatuses: {},
      progress: 0.0,
    );
  }

  /// 获取阶段描述
  String getPhaseDescription(StartupPhase phase) {
    switch (phase) {
      case StartupPhase.initial:
        return '初始化';
      case StartupPhase.coreLoading:
        return '加载核心组件';
      case StartupPhase.configLoading:
        return '加载配置信息';
      case StartupPhase.authChecking:
        return '验证用户身份';
      case StartupPhase.dataPreloading:
        return '预加载数据';
      case StartupPhase.ready:
        return '准备就绪';
    }
  }
}

/// 启动优化器提供者
final startupOptimizerProvider = StateNotifierProvider<StartupOptimizer, StartupState>((ref) {
  return StartupOptimizer();
});

/// 启动加载组件
class StartupLoadingWidget extends ConsumerWidget {
  final Widget? child;
  final VoidCallback? onStartupComplete;
  
  const StartupLoadingWidget({
    super.key,
    this.child,
    this.onStartupComplete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startupState = ref.watch(startupOptimizerProvider);
    final startupOptimizer = ref.read(startupOptimizerProvider.notifier);

    if (startupState.isComplete) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onStartupComplete?.call();
      });
      return child ?? const SizedBox.shrink();
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 应用图标或Logo
              const Icon(
                Icons.flash_on,
                size: 64,
                color: Colors.blue,
              ),
              const SizedBox(height: 32),
              
              // 阶段描述
              Text(
                startupOptimizer.getPhaseDescription(startupState.currentPhase),
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              
              // 当前任务名称
              if (startupState.currentTaskName != null) ...[
                Text(
                  startupState.currentTaskName!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
              ],
              
              // 进度条
              SizedBox(
                width: 200,
                child: LinearProgressIndicator(
                  value: startupState.progress,
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              
              // 进度百分比
              Text(
                '${(startupState.progress * 100).toInt()}%',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              
              // 错误信息
              if (startupState.error != null) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Theme.of(context).colorScheme.error,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        startupState.error!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          startupOptimizer.reset();
                          startupOptimizer.startupFlow();
                        },
                        child: const Text('重试'),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}