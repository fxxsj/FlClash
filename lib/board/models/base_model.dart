import 'package:flutter/foundation.dart';

/// Model基类，所有模型都应该继承此类
abstract class BaseModel {
  /// 构造函数
  const BaseModel();

  /// 将模型转换为JSON
  Map<String, dynamic> toJson();
  
  /// 比较内容是否相等
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BaseModel && 
           runtimeType == other.runtimeType &&
           mapEquals(_toCompare(), other._toCompare());
  }
  
  /// 生成哈希码
  @override
  int get hashCode => toJson().toString().hashCode;
  
  /// 获取用于比较的Map
  Map<String, dynamic> _toCompare() {
    return toJson();
  }
  
  /// 模型描述信息
  @override
  String toString() {
    return '$runtimeType${toJson()}';
  }
} 