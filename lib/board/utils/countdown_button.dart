import 'dart:async';
import 'package:flutter/material.dart';

/// 倒计时按钮，用于发送验证码等场景
class CountdownButton extends StatefulWidget {
  /// 点击按钮的回调函数
  final VoidCallback onPressed;
  
  /// 按钮显示文本
  final String text;
  
  /// 倒计时时长（秒）
  final int duration;
  
  /// 是否显示加载指示器
  final bool isLoading;
  
  /// 是否禁用按钮
  final bool disabled;

  const CountdownButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.duration = 60,
    this.isLoading = false,
    this.disabled = false,
  }) : super(key: key);

  @override
  State<CountdownButton> createState() => _CountdownButtonState();
}

class _CountdownButtonState extends State<CountdownButton> {
  Timer? _timer;
  int _countdown = 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      _countdown = widget.duration;
    });
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown <= 0) {
        timer.cancel();
      } else {
        setState(() {
          _countdown--;
        });
      }
    });
  }

  void _handlePressed() {
    if (_countdown > 0 || widget.isLoading || widget.disabled) return;
    
    widget.onPressed();
    _startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    final bool disabled = _countdown > 0 || widget.isLoading || widget.disabled;
    
    return TextButton(
      onPressed: disabled ? null : _handlePressed,
      child: widget.isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(_countdown > 0 ? '${_countdown}s' : widget.text),
    );
  }
} 