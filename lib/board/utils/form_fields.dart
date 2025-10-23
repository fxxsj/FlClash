import 'package:flutter/material.dart';
import 'package:fl_clash/common/app_localizations.dart';
import 'package:fl_clash/common/common.dart';
import 'countdown_button.dart';

/// 密码表单字段
class PasswordFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final ValueNotifier<bool> showPasswordNotifier;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final bool autofocus;

  const PasswordFormField({
    Key? key,
    required this.controller,
    required this.label,
    required this.showPasswordNotifier,
    this.validator,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: showPasswordNotifier,
      builder: (_, showPassword, __) {
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: !showPassword,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          autofocus: autofocus,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock),
            border: const OutlineInputBorder(),
            labelText: label,
            suffixIcon: IconButton(
              icon: Icon(
                showPassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () => showPasswordNotifier.value = !showPassword,
            ),
          ),
          validator: validator ?? (value) {
            if (value?.isEmpty ?? true) {
              return label;
            }
            if ((value?.length ?? 0) < 8) {
              return appLocalizations.passwordTooShort;
            }
            return null;
          },
        );
      },
    );
  }
}

/// 邮箱表单字段
class EmailFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool autofocus;
  final Widget? suffix;

  const EmailFormField({
    Key? key,
    required this.controller,
    this.validator,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
    this.autofocus = false,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      autofocus: autofocus,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email),
        border: const OutlineInputBorder(),
        labelText: appLocalizations.emailHint,
        suffixIcon: suffix,
      ),
      validator: validator ?? (value) {
        if (value?.isEmpty ?? true) {
          return appLocalizations.emailHint;
        }
        return null;
      },
    );
  }
}

/// 验证码表单字段（带发送验证码倒计时按钮）
class EmailCodeFormField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSendCode;
  final bool isSending;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  
  const EmailCodeFormField({
    Key? key,
    required this.controller,
    required this.onSendCode,
    this.isSending = false,
    this.validator,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.security),
        border: const OutlineInputBorder(),
        labelText: appLocalizations.emailCodeHint,
        suffixIcon: CountdownButton(
          text: appLocalizations.sendCode,
          onPressed: onSendCode,
          isLoading: isSending,
        ),
      ),
      validator: validator ?? (value) {
        if (value?.isEmpty ?? true) {
          return appLocalizations.emailCodeHint;
        }
        return null;
      },
    );
  }
}
 