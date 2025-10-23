import 'package:flutter/material.dart';
import 'package:fl_clash/common/error_manager.dart';
import 'package:fl_clash/common/common.dart';

/// 错误边界组件
/// 用于捕获和处理应用中的未处理错误
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(BuildContext context, AppError error)? errorBuilder;
  final void Function(AppError error)? onError;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.errorBuilder,
    this.onError,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  AppError? _error;

  @override
  void initState() {
    super.initState();
    
    // 监听全局错误
    FlutterError.onError = (FlutterErrorDetails details) {
      final error = AppError.fromException(
        Exception(details.exception.toString()),
        type: ErrorType.system,
        severity: ErrorSeverity.high,
        stackTrace: details.stack,
      );
      
      _handleError(error);
    };
  }

  void _handleError(AppError error) {
    setState(() {
      _error = error;
    });

    // 调用回调
    widget.onError?.call(error);

    // 使用错误管理器处理
    errorManager.handleError(error, showToUser: false);
  }

  void _retry() {
    setState(() {
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return widget.errorBuilder?.call(context, _error!) ?? 
             _DefaultErrorWidget(
               error: _error!,
               onRetry: _retry,
             );
    }

    return widget.child;
  }
}

/// 默认错误组件
class _DefaultErrorWidget extends StatelessWidget {
  final AppError error;
  final VoidCallback onRetry;

  const _DefaultErrorWidget({
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.error ?? '错误'),
        backgroundColor: error.getColor(context),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                error.icon,
                size: 64,
                color: error.getColor(context),
              ),
              const SizedBox(height: 24),
              Text(
                error.userFriendlyMessage,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              if (error.suggestion != null) ...[
                Text(
                  error.suggestion!,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh),
                    label: Text(appLocalizations.retry ?? '重试'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      errorManager.showErrorDetails(context, error);
                    },
                    icon: const Icon(Icons.info_outline),
                    label: Text(appLocalizations.viewDetails ?? '查看详情'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 加载状态管理器
class LoadingManager {
  static LoadingManager? _instance;
  static LoadingManager get instance => _instance ??= LoadingManager._();

  LoadingManager._();

  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  final ValueNotifier<String?> _loadingMessage = ValueNotifier(null);

  ValueNotifier<bool> get isLoading => _isLoading;
  ValueNotifier<String?> get loadingMessage => _loadingMessage;

  void showLoading([String? message]) {
    _loadingMessage.value = message;
    _isLoading.value = true;
  }

  void hideLoading() {
    _isLoading.value = false;
    _loadingMessage.value = null;
  }

  /// 执行带加载状态的操作
  Future<T> withLoading<T>(
    Future<T> Function() operation, {
    String? message,
    bool showErrorDialog = true,
  }) async {
    try {
      showLoading(message);
      final result = await operation();
      return result;
    } catch (error, stackTrace) {
      if (showErrorDialog) {
        errorManager.handleError(
          error,
          stackTrace: stackTrace,
          showToUser: true,
        );
      }
      rethrow;
    } finally {
      hideLoading();
    }
  }
}

/// 加载指示器组件
class LoadingIndicator extends StatelessWidget {
  final String? message;
  final bool isFullScreen;

  const LoadingIndicator({
    super.key,
    this.message,
    this.isFullScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(
            message!,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    if (isFullScreen) {
      return Scaffold(
        body: Center(child: content),
      );
    }

    return Center(child: content);
  }
}

/// 全局加载覆盖层
class GlobalLoadingOverlay extends StatelessWidget {
  final Widget child;

  const GlobalLoadingOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: LoadingManager.instance.isLoading,
      builder: (context, isLoading, _) {
        return Stack(
          children: [
            child,
            if (isLoading)
              Container(
                color: Colors.black54,
                child: ValueListenableBuilder<String?>(
                  valueListenable: LoadingManager.instance.loadingMessage,
                  builder: (context, message, _) {
                    return LoadingIndicator(
                      message: message,
                      isFullScreen: true,
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

/// 智能重试组件
class SmartRetry extends StatefulWidget {
  final Future<void> Function() onRetry;
  final Widget Function(BuildContext context, VoidCallback retry)? builder;
  final int maxRetries;
  final Duration retryDelay;

  const SmartRetry({
    super.key,
    required this.onRetry,
    this.builder,
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 2),
  });

  @override
  State<SmartRetry> createState() => _SmartRetryState();
}

class _SmartRetryState extends State<SmartRetry> {
  int _retryCount = 0;
  bool _isRetrying = false;

  Future<void> _handleRetry() async {
    if (_retryCount >= widget.maxRetries || _isRetrying) return;

    setState(() {
      _isRetrying = true;
    });

    try {
      await Future.delayed(widget.retryDelay);
      await widget.onRetry();
      _retryCount = 0; // 成功后重置计数
    } catch (error) {
      _retryCount++;
      errorManager.handleError(
        error,
        showToUser: _retryCount >= widget.maxRetries,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isRetrying = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder?.call(context, _handleRetry) ??
           FilledButton.icon(
             onPressed: _isRetrying ? null : _handleRetry,
             icon: _isRetrying 
               ? const SizedBox(
                   width: 16,
                   height: 16,
                   child: CircularProgressIndicator(strokeWidth: 2),
                 )
               : const Icon(Icons.refresh),
             label: Text(
               _isRetrying 
                 ? appLocalizations.retrying ?? '重试中...'
                 : appLocalizations.retry ?? '重试'
             ),
           );
  }
}

/// 全局实例
final loadingManager = LoadingManager.instance;