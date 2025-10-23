import 'base_model.dart';

/// 支付方式模型
class PaymentMethodModel extends BaseModel {
  /// 支付方式ID
  final int id;
  /// 支付方式名称
  final String name;
  /// 支付方式标识
  final String payment;
  /// 支付方式图标
  final String icon;
  /// 固定手续费(分)
  final int handlingFeeFixed;
  /// 百分比手续费(%)
  final int handlingFeePercent;

  const PaymentMethodModel({
    required this.id,
    required this.name,
    required this.payment,
    required this.icon,
    required this.handlingFeeFixed,
    required this.handlingFeePercent,
  });

  /// 从JSON创建实例
  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      payment: json['payment'] ?? '',
      icon: json['icon'] ?? '',
      handlingFeeFixed: json['handling_fee_fixed'] ?? 0,
      handlingFeePercent: json['handling_fee_percent'] ?? 0,
    );
  }

  /// 创建一个空的支付方式实例
  factory PaymentMethodModel.empty() {
    return const PaymentMethodModel(
      id: 0,
      name: '',
      payment: '',
      icon: '',
      handlingFeeFixed: 0,
      handlingFeePercent: 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'payment': payment,
      'icon': icon,
      'handling_fee_fixed': handlingFeeFixed,
      'handling_fee_percent': handlingFeePercent,
    };
  }

  /// 创建一个新的实例，并可选地替换部分属性
  PaymentMethodModel copyWith({
    int? id,
    String? name,
    String? payment,
    String? icon,
    int? handlingFeeFixed,
    int? handlingFeePercent,
  }) {
    return PaymentMethodModel(
      id: id ?? this.id,
      name: name ?? this.name,
      payment: payment ?? this.payment,
      icon: icon ?? this.icon,
      handlingFeeFixed: handlingFeeFixed ?? this.handlingFeeFixed,
      handlingFeePercent: handlingFeePercent ?? this.handlingFeePercent,
    );
  }

  /// 计算手续费
  int calculateHandlingFee(int amount) {
    return handlingFeeFixed + (amount * handlingFeePercent ~/ 100);
  }

  @override
  String toString() {
    return 'PaymentMethodModel{id: $id, name: $name, payment: $payment}';
  }
}
