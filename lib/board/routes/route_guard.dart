import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../views/account/auth/login_page.dart';

/// @deprecated 使用 AuthMiddleware 代替，此类将在未来版本中移除
/// Example: AuthMiddleware(child: YourWidget(), requireAuth: true)
class RouteGuard extends ConsumerWidget {
  final Widget child;

  const RouteGuard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.isAuthenticated ? child : const LoginPage();
  }
}
