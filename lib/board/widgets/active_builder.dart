import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/providers/app.dart';

typedef StateAndChildWidgetBuilder = Widget Function(bool isCurrent, Widget? child);

/// ActiveBuilder 用于构建在特定标签页活跃时才执行某些操作的小部件
/// 在迁移到 Riverpod 后使用
class ActiveBuilder extends ConsumerStatefulWidget {
  /// 当前标签的名称
  final String label;
  
  /// 构建函数
  final StateAndChildWidgetBuilder builder;
  
  /// 子组件
  final Widget? child;

  const ActiveBuilder({
    Key? key,
    required this.label,
    required this.builder,
    required this.child,
  }) : super(key: key);

  @override
  ConsumerState<ActiveBuilder> createState() => _ActiveBuilderState();
}

class _ActiveBuilderState extends ConsumerState<ActiveBuilder> {
  @override
  Widget build(BuildContext context) {
    // 通过 Riverpod 监听当前页面标签
    final currentPageLabel = ref.watch(currentPageLabelProvider);
    
    // 将小写的标签名与小写的当前页面标签名进行比较
    final labelString = widget.label.toLowerCase();
    final currentLabelString = currentPageLabel.name.toLowerCase();
    
    final isCurrent = labelString == currentLabelString || 
                      labelString == 'usercenter' && currentLabelString == 'usercenter';
    
    // 返回由构建函数构建的小部件
    return widget.builder(isCurrent, widget.child);
  }
} 