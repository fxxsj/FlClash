import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/providers.dart';
import 'states/user_center_state.dart';
import 'board.dart';

// 保存静态容器实例
ProviderContainer? _container;

/// 初始化 Riverpod 提供者
Future<ProviderContainer> setupRiverpod() async {
  // 如果容器已经初始化，直接返回
  if (_container != null) {
    return _container!;
  }
  
  // 初始化 SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  
  // 创建带有覆盖的容器
  _container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
    ],
  );

  // 初始化 Board 模块
  await initializeBoard(_container!); 
  
  return _container!;
}

/// 构建 ProviderScope
class BoardProviderScope extends StatelessWidget {
  final Widget child;
  final ProviderContainer? container;
  
  const BoardProviderScope({
    Key? key,
    required this.child,
    this.container,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return UncontrolledProviderScope(
      container: container ?? ProviderContainer(),
      child: child,
    );
  }
} 