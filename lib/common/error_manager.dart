import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/state.dart';

/// 错误类型枚举
enum ErrorType {
  network,      // 网络错误
  auth,         // 认证错误
  permission,   // 权限错误
  validation,   // 验证错误
  system,       // 系统错误
  unknown,      // 未知错误
}

/// 错误严重程度
enum ErrorSeverity {
  low,          // 低级错误，用户可以继续使用
  medium,       // 中级错误，需要用户注意
  high,         // 高级错误，需要立即处理
  critical,     // 严重错误，可能导致应用崩溃
}

/// 统一的错误处理类
class AppError {
  final String message;
  final String? details;
  final ErrorType type;
  final ErrorSeverity severity;
  final String? code;
  final StackTrace? stackTrace;
  final DateTime timestamp;
  final String? suggestion;

  AppError({
    required this.message,
    this.details,
    required this.type,
    required this.severity,
    this.code,
    this.stackTrace,
    DateTime? timestamp,
    this.suggestion,
  }) : timestamp = timestamp ?? DateTime.now();

  /// 从异常创建错误
  factory AppError.fromException(
    Exception exception, {
    ErrorType? type,
    ErrorSeverity? severity,
    String? suggestion,
    StackTrace? stackTrace,
  }) {
    String message = exception.toString();
    ErrorType errorType = type ?? ErrorType.unknown;
    ErrorSeverity errorSeverity = severity ?? ErrorSeverity.medium;
    String? errorSuggestion = suggestion;

    // 根据异常类型自动判断错误类型和建议
    if (exception.toString().contains('network') || 
        exception.toString().contains('connection') ||
        exception.toString().contains('timeout')) {
      errorType = ErrorType.network;
      errorSuggestion ??= appLocalizations.networkErrorSuggestion ?? '请检查网络连接';
    } else if (exception.toString().contains('401') || 
               exception.toString().contains('unauthorized') ||
               exception.toString().contains('auth')) {
      errorType = ErrorType.auth;
      errorSeverity = ErrorSeverity.high;
      errorSuggestion ??= appLocalizations.authErrorSuggestion ?? '请重新登录';
    } else if (exception.toString().contains('403') || 
               exception.toString().contains('permission')) {
      errorType = ErrorType.permission;
      errorSeverity = ErrorSeverity.high;
      errorSuggestion ??= appLocalizations.permissionErrorSuggestion ?? '没有操作权限';
    }

    return AppError(
      message: message,
      type: errorType,
      severity: errorSeverity,
      suggestion: errorSuggestion,
      stackTrace: stackTrace,
    );
  }

  /// 网络错误
  factory AppError.network(String message, {String? suggestion}) {
    return AppError(
      message: message,
      type: ErrorType.network,
      severity: ErrorSeverity.medium,
      suggestion: suggestion ?? appLocalizations.networkErrorSuggestion ?? '请检查网络连接',
    );
  }

  /// 认证错误
  factory AppError.auth(String message, {String? suggestion}) {
    return AppError(
      message: message,
      type: ErrorType.auth,
      severity: ErrorSeverity.high,
      suggestion: suggestion ?? appLocalizations.authErrorSuggestion ?? '请重新登录',
    );
  }

  /// 验证错误
  factory AppError.validation(String message, {String? suggestion}) {
    return AppError(
      message: message,
      type: ErrorType.validation,
      severity: ErrorSeverity.low,
      suggestion: suggestion,
    );
  }

  /// 系统错误
  factory AppError.system(String message, {String? suggestion}) {
    return AppError(
      message: message,
      type: ErrorType.system,
      severity: ErrorSeverity.high,
      suggestion: suggestion ?? appLocalizations.systemErrorSuggestion ?? '请重启应用',
    );
  }

  /// 获取错误图标
  IconData get icon {
    switch (type) {
      case ErrorType.network:
        return Icons.wifi_off;
      case ErrorType.auth:
        return Icons.lock_outline;
      case ErrorType.permission:
        return Icons.security;
      case ErrorType.validation:
        return Icons.warning_outlined;
      case ErrorType.system:
        return Icons.bug_report_outlined;
      case ErrorType.unknown:
        return Icons.error_outline;
    }
  }

  /// 获取错误颜色
  Color getColor(BuildContext context) {
    switch (severity) {
      case ErrorSeverity.low:
        return Theme.of(context).colorScheme.primary;
      case ErrorSeverity.medium:
        return Colors.orange;
      case ErrorSeverity.high:
        return Colors.red;
      case ErrorSeverity.critical:
        return Colors.red.shade900;
    }
  }

  /// 转换为用户友好的消息
  String get userFriendlyMessage {
    switch (type) {
      case ErrorType.network:
        return appLocalizations.networkError ?? '网络连接失败';
      case ErrorType.auth:
        return appLocalizations.authError ?? '身份验证失败';
      case ErrorType.permission:
        return appLocalizations.permissionError ?? '权限不足';
      case ErrorType.validation:
        return appLocalizations.validationError ?? '输入验证失败';
      case ErrorType.system:
        return appLocalizations.systemError ?? '系统错误';
      case ErrorType.unknown:
        return appLocalizations.unknownError ?? '未知错误';
    }
  }

  @override
  String toString() {
    return 'AppError(type: $type, severity: $severity, message: $message)';
  }
}

/// 错误处理管理器
class ErrorManager {
  static ErrorManager? _instance;
  static ErrorManager get instance => _instance ??= ErrorManager._();

  ErrorManager._();

  final List<AppError> _errorHistory = [];
  final ValueNotifier<AppError?> _currentError = ValueNotifier(null);

  /// 当前错误流
  ValueNotifier<AppError?> get currentError => _currentError;

  /// 错误历史记录
  List<AppError> get errorHistory => List.unmodifiable(_errorHistory);

  /// 处理错误
  void handleError(
    dynamic error, {
    StackTrace? stackTrace,
    ErrorType? type,
    ErrorSeverity? severity,
    String? suggestion,
    bool showToUser = true,
  }) {
    AppError appError;

    if (error is AppError) {
      appError = error;
    } else if (error is Exception) {
      appError = AppError.fromException(
        error,
        type: type,
        severity: severity,
        suggestion: suggestion,
        stackTrace: stackTrace,
      );
    } else {
      appError = AppError(
        message: error.toString(),
        type: type ?? ErrorType.unknown,
        severity: severity ?? ErrorSeverity.medium,
        suggestion: suggestion,
        stackTrace: stackTrace,
      );
    }

    // 记录错误
    _errorHistory.add(appError);
    if (_errorHistory.length > 100) {
      _errorHistory.removeAt(0); // 保持历史记录在合理范围内
    }

    // 调试模式下打印详细错误信息
    if (kDebugMode) {
      debugPrint('Error: ${appError.message}');
      if (appError.details != null) {
        debugPrint('Details: ${appError.details}');
      }
      if (appError.stackTrace != null) {
        debugPrint('StackTrace: ${appError.stackTrace}');
      }
    }

    // 显示给用户
    if (showToUser) {
      _currentError.value = appError;
      _showErrorToUser(appError);
    }
  }

  /// 显示错误给用户
  void _showErrorToUser(AppError error) {
    final context = globalState.navigatorKey.currentContext;
    if (context == null) return;

    switch (error.severity) {
      case ErrorSeverity.low:
        _showSnackBar(context, error);
        break;
      case ErrorSeverity.medium:
      case ErrorSeverity.high:
        _showErrorDialog(context, error);
        break;
      case ErrorSeverity.critical:
        _showCriticalErrorDialog(context, error);
        break;
    }
  }

  /// 显示 SnackBar
  void _showSnackBar(BuildContext context, AppError error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(error.icon, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(error.userFriendlyMessage)),
          ],
        ),
        backgroundColor: error.getColor(context),
        duration: const Duration(seconds: 4),
        action: error.suggestion != null
            ? SnackBarAction(
                label: appLocalizations.viewDetails ?? '查看详情',
                textColor: Colors.white,
                onPressed: () => errorManager.showErrorDetails(context, error),
              )
            : null,
      ),
    );
  }

  /// 显示错误对话框
  void _showErrorDialog(BuildContext context, AppError error) {
    showDialog(
      context: context,
      builder: (context) => ErrorDialog(error: error),
    );
  }

  /// 显示严重错误对话框
  void _showCriticalErrorDialog(BuildContext context, AppError error) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CriticalErrorDialog(error: error),
    );
  }

  /// 显示错误详情
  void showErrorDetails(BuildContext context, AppError error) {
    showDialog(
      context: context,
      builder: (context) => ErrorDetailsDialog(error: error),
    );
  }

  /// 清除当前错误
  void clearCurrentError() {
    _currentError.value = null;
  }

  /// 清除错误历史
  void clearHistory() {
    _errorHistory.clear();
  }
}

/// 错误对话框组件
class ErrorDialog extends StatelessWidget {
  final AppError error;

  const ErrorDialog({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(error.icon, color: error.getColor(context), size: 32),
      title: Text(error.userFriendlyMessage),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (error.suggestion != null) ...[
            Text(
              appLocalizations.suggestion ?? '建议：',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            Text(error.suggestion!),
            const SizedBox(height: 12),
          ],
          Text(
            appLocalizations.errorDetails ?? '错误详情：',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 4),
          Text(
            error.message,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      actions: [
        if (error.details != null || error.stackTrace != null)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              errorManager.showErrorDetails(context, error);
            },
            child: Text(appLocalizations.viewDetails ?? '查看详情'),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(appLocalizations.close ?? '关闭'),
        ),
      ],
    );
  }
}

/// 严重错误对话框
class CriticalErrorDialog extends StatelessWidget {
  final AppError error;

  const CriticalErrorDialog({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(Icons.error, color: Colors.red.shade900, size: 48),
      title: Text(appLocalizations.criticalError ?? '严重错误'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(error.userFriendlyMessage),
          const SizedBox(height: 16),
          if (error.suggestion != null) ...[
            Text(
              appLocalizations.suggestion ?? '建议：',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.red.shade900,
              ),
            ),
            const SizedBox(height: 4),
            Text(error.suggestion!),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            errorManager.showErrorDetails(context, error);
          },
          child: Text(appLocalizations.viewDetails ?? '查看详情'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          style: FilledButton.styleFrom(backgroundColor: Colors.red.shade900),
          child: Text(appLocalizations.restart ?? '重启应用'),
        ),
      ],
    );
  }
}

/// 错误详情对话框
class ErrorDetailsDialog extends StatelessWidget {
  final AppError error;

  const ErrorDetailsDialog({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(appLocalizations.errorDetails ?? '错误详情'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(
              appLocalizations.errorType ?? '错误类型',
              error.type.toString().split('.').last,
            ),
            _buildInfoRow(
              appLocalizations.severity ?? '严重程度',
              error.severity.toString().split('.').last,
            ),
            _buildInfoRow(
              appLocalizations.timestamp ?? '时间戳',
              error.timestamp.toLocal().toString(),
            ),
            if (error.code != null)
              _buildInfoRow(appLocalizations.errorCode ?? '错误代码', error.code!),
            const Divider(),
            Text(
              appLocalizations.message ?? '消息',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            SelectableText(error.message),
            if (error.details != null) ...[
              const SizedBox(height: 12),
              Text(
                appLocalizations.details ?? '详情',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              SelectableText(error.details!),
            ],
            if (error.stackTrace != null && kDebugMode) ...[
              const SizedBox(height: 12),
              Text(
                'Stack Trace',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              SelectableText(
                error.stackTrace.toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(appLocalizations.close ?? '关闭'),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: SelectableText(value)),
        ],
      ),
    );
  }
}

/// 全局错误处理器
final errorManager = ErrorManager.instance;