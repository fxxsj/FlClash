import 'package:fl_clash/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/board/constants/app_config.dart';

class AuthPageLayout extends ConsumerWidget {
  final Widget form;
  final String pageTitle;

  const AuthPageLayout({
    super.key,
    required this.form,
    required this.pageTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 应用标题
                Text(
                  AppConfig.appTitle,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                // 应用描述
                if (authState.appDescription != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      authState.appDescription!,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                
                const SizedBox(height: 32),
                
                // 页面标题
                Text(
                  pageTitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // 表单内容
                form,
              ],
            ),
          ),
        ),
      ),
    );
  }
}