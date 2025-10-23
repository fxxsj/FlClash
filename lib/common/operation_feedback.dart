import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/error_handler.dart';

/// 操作状态枚举
enum OperationStatus {
  idle,
  loading,
  success,
  error,
}

/// 操作反馈状态
class OperationFeedbackState {
  final OperationStatus status;
  final String? message;
  final String? operationId;
  final DateTime? lastUpdate;
  final Duration? timeout;

  const OperationFeedbackState({
    this.status = OperationStatus.idle,
    this.message,
    this.operationId,
    this.lastUpdate,
    this.timeout,
  });

  OperationFeedbackState copyWith({
    OperationStatus? status,
    String? message,
    String? operationId,
    DateTime? lastUpdate,
    Duration? timeout,
  }) {
    return OperationFeedbackState(
      status: status ?? this.status,
      message: message ?? this.message,
      operationId: operationId ?? this.operationId,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      timeout: timeout ?? this.timeout,
    );
  }

  bool get isLoading => status == OperationStatus.loading;
  bool get isSuccess => status == OperationStatus.success;
  bool get isError => status == OperationStatus.error;
  bool get isIdle => status == OperationStatus.idle;
}

/// 操作反馈管理器
class OperationFeedbackNotifier extends StateNotifier<OperationFeedbackState> {
  final Map<String, DateTime> _operationStartTimes = {};
  
  OperationFeedbackNotifier() : super(const OperationFeedbackState());

  /// 开始操作
  void startOperation(String operationId, String message, {Duration? timeout}) {
    _operationStartTimes[operationId] = DateTime.now();
    
    state = state.copyWith(
      status: OperationStatus.loading,
      message: message,
      operationId: operationId,
      lastUpdate: DateTime.now(),
      timeout: timeout,
    );

    // 如果设置了超时，自动失败
    if (timeout != null) {
      Future.delayed(timeout, () {
        if (state.operationId == operationId && state.isLoading) {
          failOperation(operationId, '操作超时');
        }
      });
    }
  }

  /// 操作成功
  void completeOperation(String operationId, String? successMessage) {
    if (state.operationId != operationId) return;

    final duration = _getDuration(operationId);
    final message = successMessage ?? '操作完成';
    final finalMessage = duration != null ? '$message (耗时${duration}ms)' : message;

    state = state.copyWith(
      status: OperationStatus.success,
      message: finalMessage,
      lastUpdate: DateTime.now(),
    );

    // 3秒后自动重置状态
    Future.delayed(const Duration(seconds: 3), () {
      if (state.operationId == operationId && state.isSuccess) {
        resetState();
      }
    });

    _operationStartTimes.remove(operationId);
  }

  /// 操作失败
  void failOperation(String operationId, String errorMessage) {
    if (state.operationId != operationId) return;

    state = state.copyWith(
      status: OperationStatus.error,
      message: errorMessage,
      lastUpdate: DateTime.now(),
    );

    // 5秒后自动重置状态
    Future.delayed(const Duration(seconds: 5), () {
      if (state.operationId == operationId && state.isError) {
        resetState();
      }
    });

    _operationStartTimes.remove(operationId);
  }

  /// 更新进度消息
  void updateMessage(String operationId, String message) {
    if (state.operationId != operationId || !state.isLoading) return;

    state = state.copyWith(
      message: message,
      lastUpdate: DateTime.now(),
    );
  }

  /// 重置状态
  void resetState() {
    state = const OperationFeedbackState();
  }

  /// 获取操作持续时间
  int? _getDuration(String operationId) {
    final startTime = _operationStartTimes[operationId];
    if (startTime == null) return null;
    return DateTime.now().difference(startTime).inMilliseconds;
  }
}

/// 操作反馈提供者
final operationFeedbackProvider = StateNotifierProvider<OperationFeedbackNotifier, OperationFeedbackState>((ref) {
  return OperationFeedbackNotifier();
});

/// 操作反馈组件
class OperationFeedbackWidget extends ConsumerWidget {
  final Widget child;
  final bool showSnackBar;
  final bool showOverlay;

  const OperationFeedbackWidget({
    super.key,
    required this.child,
    this.showSnackBar = true,
    this.showOverlay = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackState = ref.watch(operationFeedbackProvider);

    ref.listen<OperationFeedbackState>(operationFeedbackProvider, (previous, next) {
      if (!showSnackBar) return;

      // 显示加载状态
      if (next.isLoading && (previous == null || !previous.isLoading)) {
        _showLoadingSnackBar(context, next.message ?? '正在处理...');
      }
      
      // 显示成功状态
      if (next.isSuccess && (previous == null || !previous.isSuccess)) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        UserFriendlyErrorHandler.showSuccessSnackBar(
          context,
          next.message ?? '操作成功',
        );
      }
      
      // 显示错误状态
      if (next.isError && (previous == null || !previous.isError)) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        UserFriendlyErrorHandler.showErrorSnackBar(
          context,
          AppError(
            type: AppErrorType.unknown,
            severity: ErrorSeverity.medium,
            code: 'OPERATION_ERROR',
            originalMessage: next.message ?? '操作失败',
            userMessage: next.message ?? '操作失败',
          ),
        );
      }
    });

    return Stack(
      children: [
        child,
        if (showOverlay && feedbackState.isLoading)
          _buildLoadingOverlay(context, feedbackState),
      ],
    );
  }

  void _showLoadingSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        duration: const Duration(minutes: 5), // 长时间显示，直到操作完成
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildLoadingOverlay(BuildContext context, OperationFeedbackState state) {
    return Positioned.fill(
      child: Container(
        color: Colors.black54,
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    state.message ?? '正在处理...',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  if (state.timeout != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      '最长等待 ${state.timeout!.inSeconds} 秒',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 操作反馈扩展
extension OperationFeedbackExtension on WidgetRef {
  /// 执行带反馈的异步操作
  Future<T> executeWithFeedback<T>(
    String operationId,
    String loadingMessage,
    Future<T> Function() operation, {
    String? successMessage,
    Duration? timeout,
  }) async {
    final notifier = read(operationFeedbackProvider.notifier);
    
    try {
      notifier.startOperation(operationId, loadingMessage, timeout: timeout);
      
      final result = await operation();
      
      notifier.completeOperation(operationId, successMessage);
      return result;
    } catch (e) {
      String errorMessage = '操作失败';
      if (e is AppError) {
        errorMessage = e.userMessage ?? e.originalMessage;
      } else {
        errorMessage = e.toString();
      }
      
      notifier.failOperation(operationId, errorMessage);
      rethrow;
    }
  }
}

/// 操作反馈按钮
class FeedbackButton extends ConsumerWidget {
  final String operationId;
  final String text;
  final String loadingText;
  final String? successText;
  final Future<void> Function() onPressed;
  final VoidCallback? onSuccess;
  final VoidCallback? onError;
  final Duration? timeout;
  final ButtonStyle? style;
  final Widget? icon;

  const FeedbackButton({
    super.key,
    required this.operationId,
    required this.text,
    required this.loadingText,
    required this.onPressed,
    this.successText,
    this.onSuccess,
    this.onError,
    this.timeout,
    this.style,
    this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackState = ref.watch(operationFeedbackProvider);
    final isCurrentOperation = feedbackState.operationId == operationId;
    final isLoading = isCurrentOperation && feedbackState.isLoading;

    return ElevatedButton(
      style: style,
      onPressed: isLoading ? null : () async {
        try {
          await ref.executeWithFeedback(
            operationId,
            loadingText,
            onPressed,
            successMessage: successText,
            timeout: timeout,
          );
          onSuccess?.call();
        } catch (e) {
          onError?.call();
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLoading) ...[
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 8),
          ] else if (icon != null) ...[
            icon!,
            const SizedBox(width: 8),
          ],
          Text(isLoading ? loadingText : text),
        ],
      ),
    );
  }
}