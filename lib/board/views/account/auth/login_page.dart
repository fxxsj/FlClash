import 'package:fl_clash/common/app_localizations.dart';
import 'package:fl_clash/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/board/widgets/auth_page_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  static const String _lastEmailKey = 'last_login_email';

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _obscureController = ValueNotifier<bool>(true);
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadLastEmail();
  }

  Future<void> _loadLastEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final lastEmail = prefs.getString(_lastEmailKey);
    if (lastEmail != null && mounted) {
      _emailController.text = lastEmail;
    }
  }

  Future<void> _saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastEmailKey, email);
  }

  void _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      await _saveEmail(_emailController.text);
      try {
        await ref.read(authStateProvider.notifier).login(
              _emailController.text,
              _passwordController.text,
            );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(appLocalizations.loginSuccess),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        // Error is handled by the notifier, and displayed in the build method.
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _obscureController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return AuthPageLayout(
      pageTitle: appLocalizations.login,
      form: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                labelText: appLocalizations.emailHint,
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return appLocalizations.emailHint;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder(
              valueListenable: _obscureController,
              builder: (_, obscure, __) {
                return TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  obscureText: obscure,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {
                    _handleLogin();
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    labelText: appLocalizations.passwordHint,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscure ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        _obscureController.value = !obscure;
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return appLocalizations.passwordHint;
                    }
                    return null;
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            if (authState.error != null)
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        authState.error!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: authState.isLoading ? null : _handleLogin,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: authState.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        appLocalizations.login,
                        style: const TextStyle(fontSize: 16),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(appLocalizations.hasNoAccount),
                TextButton(
                  onPressed: () {
                    // 切换页面前清除错误信息
                    ref.read(authStateProvider.notifier).clearError();
                    Navigator.of(context).pushReplacementNamed('/register');
                  },
                  child: Text(appLocalizations.registerButton),
                ),
              ],
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  // 切换页面前清除错误信息
                  ref.read(authStateProvider.notifier).clearError();
                  Navigator.of(context).pushNamed('/reset_password');
                },
                child: Text(appLocalizations.forgotPassword),
              ),
            ),
          ],
        ),
      ),
    );
  }
}