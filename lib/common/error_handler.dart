import 'package:flutter/material.dart';

/// 错误类型枚举
enum AppErrorType {
  network,
  auth,
  subscription,
  node,
  configuration,
  payment,
  validation,
  permission,
  system,
  unknown,
}

/// 错误严重程度
enum ErrorSeverity {
  low,
  medium,
  high,
  critical,
}

/// 应用错误模型
class AppError {
  final AppErrorType type;
  final ErrorSeverity severity;
  final String code;
  final String originalMessage;
  final String? userMessage;
  final VoidCallback? retryAction;
  final Map<String, dynamic>? context;

  const AppError({
    required this.type,
    required this.severity,
    required this.code,
    required this.originalMessage,
    this.userMessage,
    this.retryAction,
    this.context,
  });

  /// 返回用户友好的错误信息
  @override
  String toString() {
    return userMessage ?? originalMessage;
  }

  /// 从异常创建错误
  factory AppError.fromException(Exception exception, {
    AppErrorType? type,
    VoidCallback? retryAction,
  }) {
    final message = exception.toString();
    final detectedType = type ?? _detectErrorType(message);
    
    return AppError(
      type: detectedType,
      severity: _getSeverityForType(detectedType),
      code: _generateErrorCode(detectedType, message),
      originalMessage: message,
      userMessage: _getUserFriendlyMessage(detectedType, message),
      retryAction: retryAction,
    );
  }

  /// 检测错误类型
  static AppErrorType _detectErrorType(String message) {
    final lowerMessage = message.toLowerCase();
    
    if (lowerMessage.contains('network') || 
        lowerMessage.contains('connection') ||
        lowerMessage.contains('timeout') ||
        lowerMessage.contains('unreachable')) {
      return AppErrorType.network;
    }
    
    if (lowerMessage.contains('auth') || 
        lowerMessage.contains('login') ||
        lowerMessage.contains('token') ||
        lowerMessage.contains('unauthorized')) {
      return AppErrorType.auth;
    }
    
    if (lowerMessage.contains('subscription') ||
        lowerMessage.contains('expired') ||
        lowerMessage.contains('quota')) {
      return AppErrorType.subscription;
    }
    
    if (lowerMessage.contains('node') ||
        lowerMessage.contains('proxy') ||
        lowerMessage.contains('server')) {
      return AppErrorType.node;
    }
    
    if (lowerMessage.contains('config') ||
        lowerMessage.contains('profile') ||
        lowerMessage.contains('yaml')) {
      return AppErrorType.configuration;
    }
    
    if (lowerMessage.contains('payment') ||
        lowerMessage.contains('billing') ||
        lowerMessage.contains('order')) {
      return AppErrorType.payment;
    }
    
    if (lowerMessage.contains('permission') ||
        lowerMessage.contains('access')) {
      return AppErrorType.permission;
    }
    
    return AppErrorType.unknown;
  }

  /// 获取错误类型对应的严重程度
  static ErrorSeverity _getSeverityForType(AppErrorType type) {
    switch (type) {
      case AppErrorType.system:
        return ErrorSeverity.critical;
      case AppErrorType.auth:
      case AppErrorType.payment:
        return ErrorSeverity.high;
      case AppErrorType.network:
      case AppErrorType.subscription:
      case AppErrorType.node:
        return ErrorSeverity.medium;
      default:
        return ErrorSeverity.low;
    }
  }

  /// 生成错误代码
  static String _generateErrorCode(AppErrorType type, String message) {
    final typeCode = type.name.toUpperCase();
    final hash = message.hashCode.abs().toString().substring(0, 4);
    return '$typeCode-$hash';
  }

  /// 获取用户友好的错误信息
  static String _getUserFriendlyMessage(AppErrorType type, String originalMessage) {
    switch (type) {
      case AppErrorType.network:
        if (originalMessage.contains('timeout')) {
          return '网络连接超时，请检查网络设置后重试';
        }
        if (originalMessage.contains('unreachable')) {
          return '无法连接到服务器，请检查网络连接';
        }
        return '网络连接异常，请检查网络后重试';
      
      case AppErrorType.auth:
        if (originalMessage.contains('token')) {
          return '登录已过期，请重新登录';
        }
        if (originalMessage.contains('unauthorized')) {
          return '用户名或密码错误，请重试';
        }
        return '身份验证失败，请重新登录';
      
      case AppErrorType.subscription:
        if (originalMessage.contains('expired')) {
          return '订阅已过期，请及时续费';
        }
        if (originalMessage.contains('quota')) {
          return '流量已用完，请购买套餐或等待重置';
        }
        return '订阅服务异常，请检查订阅状态';
      
      case AppErrorType.node:
        return '当前节点不可用，建议切换其他节点';
      
      case AppErrorType.configuration:
        return '配置文件错误，请检查配置或重新下载';
      
      case AppErrorType.payment:
        return '支付处理失败，请稍后重试或联系客服';
      
      case AppErrorType.validation:
        return '输入信息有误，请检查后重新提交';
      
      case AppErrorType.permission:
        return '权限不足，请检查应用权限设置';
      
      case AppErrorType.system:
        return '系统错误，请稍后重试';
      
      default:
        return '操作失败，请稍后重试';
    }
  }
}

/// 用户友好的错误处理器
class UserFriendlyErrorHandler {
  /// 显示错误对话框
  static Future<void> showErrorDialog(
    BuildContext context,
    AppError error, {
    VoidCallback? onRetry,
    VoidCallback? onReport,
  }) async {
    return showDialog(
      context: context,
      builder: (context) => ErrorDialog(
        error: error,
        onRetry: onRetry ?? error.retryAction,
        onReport: onReport,
      ),
    );
  }

  /// 显示错误提示条
  static void showErrorSnackBar(
    BuildContext context,
    AppError error, {
    VoidCallback? onRetry,
    Duration duration = const Duration(seconds: 4),
  }) {
    final messenger = ScaffoldMessenger.of(context);
    
    // 隐藏当前显示的提示条
    messenger.hideCurrentSnackBar();
    
    messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              _getIconForErrorType(error.type),
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                error.userMessage ?? error.originalMessage,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: _getColorForSeverity(error.severity),
        duration: duration,
        action: onRetry != null || error.retryAction != null
            ? SnackBarAction(
                label: '重试',
                textColor: Colors.white,
                onPressed: onRetry ?? error.retryAction!,
              )
            : null,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// 显示成功提示
  static void showSuccessSnackBar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    
    messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// 获取错误类型对应的图标
  static IconData _getIconForErrorType(AppErrorType type) {
    switch (type) {
      case AppErrorType.network:
        return Icons.wifi_off;
      case AppErrorType.auth:
        return Icons.lock_outline;
      case AppErrorType.subscription:
        return Icons.card_membership;
      case AppErrorType.node:
        return Icons.router;
      case AppErrorType.configuration:
        return Icons.settings;
      case AppErrorType.payment:
        return Icons.payment;
      case AppErrorType.validation:
        return Icons.error_outline;
      case AppErrorType.permission:
        return Icons.security;
      default:
        return Icons.warning;
    }
  }

  /// 获取严重程度对应的颜色
  static Color _getColorForSeverity(ErrorSeverity severity) {
    switch (severity) {
      case ErrorSeverity.critical:
        return const Color(0xFFD32F2F); // 深红色
      case ErrorSeverity.high:
        return const Color(0xFFF57C00); // 橙色
      case ErrorSeverity.medium:
        return const Color(0xFF1976D2); // 蓝色
      case ErrorSeverity.low:
        return const Color(0xFF616161); // 灰色
    }
  }
}

/// 错误对话框组件
class ErrorDialog extends StatelessWidget {
  final AppError error;
  final VoidCallback? onRetry;
  final VoidCallback? onReport;

  const ErrorDialog({
    super.key,
    required this.error,
    this.onRetry,
    this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(
        UserFriendlyErrorHandler._getIconForErrorType(error.type),
        size: 48,
        color: UserFriendlyErrorHandler._getColorForSeverity(error.severity),
      ),
      title: Text(_getDialogTitle()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            error.userMessage ?? error.originalMessage,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (error.severity == ErrorSeverity.critical ||
              error.severity == ErrorSeverity.high) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.orange, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _getSuggestion(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      actions: [
        if (onReport != null)
          TextButton(
            onPressed: onReport,
            child: const Text('反馈问题'),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('关闭'),
        ),
        if (onRetry != null)
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onRetry!();
            },
            child: const Text('重试'),
          ),
      ],
    );
  }

  String _getDialogTitle() {
    switch (error.type) {
      case AppErrorType.network:
        return '网络连接问题';
      case AppErrorType.auth:
        return '身份验证失败';
      case AppErrorType.subscription:
        return '订阅服务问题';
      case AppErrorType.node:
        return '节点连接问题';
      case AppErrorType.configuration:
        return '配置错误';
      case AppErrorType.payment:
        return '支付处理失败';
      case AppErrorType.validation:
        return '输入验证失败';
      case AppErrorType.permission:
        return '权限不足';
      default:
        return '操作失败';
    }
  }

  String _getSuggestion() {
    switch (error.type) {
      case AppErrorType.network:
        return '建议检查网络连接状态，或切换到其他网络环境';
      case AppErrorType.auth:
        return '请确认账号密码正确，或联系客服重置密码';
      case AppErrorType.subscription:
        return '请检查订阅状态，必要时联系客服处理';
      case AppErrorType.node:
        return '建议切换到其他可用节点，或稍后重试';
      case AppErrorType.payment:
        return '请检查支付信息或选择其他支付方式';
      default:
        return '如问题持续出现，请联系客服获得帮助';
    }
  }
}