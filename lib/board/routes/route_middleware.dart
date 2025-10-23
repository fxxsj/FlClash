import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../views/account/auth/login_page.dart';
import '../providers/providers.dart';

/// 身份认证中间件，用于保护需要登录才能访问的路由
/// 
/// 当 [requireAuth] 为 true 且用户未登录时，会显示登录界面
/// 用户登录成功后会自动显示受保护的内容
/// 
/// 示例用法:
/// ```dart
/// AuthMiddleware(
///   child: UserProfilePage(),
///   requireAuth: true,
/// )
/// ```
class AuthMiddleware extends ConsumerWidget {
  /// 需要保护的子组件
  final Widget child;
  
  /// 是否需要登录才能访问，默认为 true
  final bool requireAuth;

  const AuthMiddleware({
    Key? key,
    required this.child,
    this.requireAuth = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    
    if (requireAuth && !authState.isAuthenticated) {
      return LoginPage();
    }
    return child;
  }
}
