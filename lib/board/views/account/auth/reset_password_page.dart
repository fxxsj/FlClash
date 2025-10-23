import 'dart:async';
import 'package:fl_clash/common/app_localizations.dart';
import 'package:fl_clash/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/board/widgets/auth_page_layout.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final _emailController = TextEditingController();
  final _emailCodeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _showPassword = ValueNotifier<bool>(false);
  final _showConfirmPassword = ValueNotifier<bool>(false);
  Timer? _timer;
  final _countdown = ValueNotifier<int>(0);

  void _startCountdown() {
    _countdown.value = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown.value <= 0) {
        timer.cancel();
      } else {
        _countdown.value--;
      }
    });
  }

  void _handleResetPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await ref.read(authStateProvider.notifier).resetPassword(
              _emailController.text,
              _emailCodeController.text,
              _passwordController.text,
            );
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/login');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(appLocalizations.resetPasswordSuccess),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        // Error is handled by the notifier
      }
    }
  }

  void _handleSendCode() async {
    if (_countdown.value > 0) return;

    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(appLocalizations.emailHint)),
      );
      return;
    }

    try {
      await ref.read(authStateProvider.notifier).sendEmailVerify(_emailController.text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(appLocalizations.sendCodeSuccess),
            backgroundColor: Colors.green,
          ),
        );
        _startCountdown();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailCodeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _showPassword.dispose();
    _showConfirmPassword.dispose();
    _countdown.dispose();
    _timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return AuthPageLayout(
      pageTitle: appLocalizations.resetPassword,
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
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return appLocalizations.emailHint;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailCodeController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.security),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                labelText: appLocalizations.emailCodeHint,
                suffixIcon: ValueListenableBuilder<int>(
                  valueListenable: _countdown,
                  builder: (_, count, __) {
                    final bool disabled = authState.isSendingCode || count > 0;
                    return TextButton(
                      onPressed: disabled ? null : _handleSendCode,
                      child: authState.isSendingCode
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                            )
                          : Text(count > 0 ? '${count}s' : appLocalizations.sendCode),
                    );
                  },
                ),
              ),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return appLocalizations.emailCodeHint;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder(
              valueListenable: _showPassword,
              builder: (_, showPassword, __) {
                return TextFormField(
                  controller: _passwordController,
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    labelText: appLocalizations.passwordHint,
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        _showPassword.value = !showPassword;
                      },
                    ),
                  ),
                  textInputAction: TextInputAction.next,
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
            ValueListenableBuilder(
              valueListenable: _showConfirmPassword,
              builder: (_, showConfirmPassword, __) {
                return TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !showConfirmPassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    labelText: appLocalizations.confirmPasswordHint,
                    suffixIcon: IconButton(
                      icon: Icon(
                        showConfirmPassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        _showConfirmPassword.value = !showConfirmPassword;
                      },
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {
                    _handleResetPassword();
                  },
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return appLocalizations.confirmPasswordHint;
                    }
                    if (value != _passwordController.text) {
                      return appLocalizations.passwordNotMatch;
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
                onPressed: authState.isLoading ? null : _handleResetPassword,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: authState.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        appLocalizations.resetPassword,
                        style: const TextStyle(fontSize: 16),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {
                  // 切换页面前清除错误信息
                  ref.read(authStateProvider.notifier).clearError();
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: Text(appLocalizations.login),
              ),
            ),
          ],
        ),
      ),
    );
  }
}