import 'base_model.dart';
import 'package:fl_clash/board/models/plan.dart';

/// 订单模型
class OrderModel extends BaseModel {
  /// 订单状态：待支付
  static const int STATUS_PENDING = 0;
  /// 订单状态：已完成
  static const int STATUS_COMPLETED = 1;
  /// 订单状态：已取消
  static const int STATUS_CANCELLED = 2;
  /// 订单状态：已退款
  static const int STATUS_REFUNDED = 3;
  
  /// 订单类型：新购
  static const int TYPE_NEW = 1;
  /// 订单类型：续费
  static const int TYPE_RENEW = 2;
  /// 订单类型：升级
  static const int TYPE_UPGRADE = 3;
  /// 订单类型：重置流量
  static const int TYPE_RESET_TRAFFIC = 4;

  /// 邀请用户ID
  final int? inviteUserId;
  /// 套餐ID
  final int planId;
  /// 优惠券ID
  final int? couponId;
  /// 支付方式ID
  final int? paymentId;
  /// 订单类型
  final int type;
  /// 订阅周期
  final String period;
  /// 交易号
  final String tradeNo;
  /// 回调号
  final String? callbackNo;
  /// 总金额(分)
  final int totalAmount;
  /// 手续费(分)
  final int? handlingAmount;
  /// 折扣金额(分)
  final int? discountAmount;
  /// 剩余金额(分)
  final int? surplusAmount;
  /// 退款金额(分)
  final int? refundAmount;
  /// 余额支付金额(分)
  final int? balanceAmount;
  /// 剩余订单ID列表
  final List<int>? surplusOrderIds;
  /// 订单状态
  final int status;
  /// 佣金状态
  final int commissionStatus;
  /// 佣金金额(分)
  final int commissionBalance;
  /// 实际佣金金额(分)
  final int? actualCommissionBalance;
  /// 支付时间
  final int? paidAt;
  /// 创建时间
  final int createdAt;
  /// 更新时间
  final int updatedAt;
  /// 关联的套餐
  final PlanModel? plan;
  /// 试用套餐ID
  final int? tryOutPlanId;
  /// 奖励金额(分)
  final int? bounus;
  /// 获得金额(分)
  final int? getAmount;

  const OrderModel({
    this.inviteUserId,
    required this.planId,
    this.couponId,
    this.paymentId,
    required this.type,
    required this.period,
    required this.tradeNo,
    this.callbackNo,
    required this.totalAmount,
    this.handlingAmount,
    this.discountAmount,
    this.surplusAmount,
    this.refundAmount,
    this.balanceAmount,
    this.surplusOrderIds,
    required this.status,
    required this.commissionStatus,
    required this.commissionBalance,
    this.actualCommissionBalance,
    this.paidAt,
    required this.createdAt,
    required this.updatedAt,
    this.plan,
    this.tryOutPlanId,
    this.bounus,
    this.getAmount,
  });

  /// 从JSON创建实例
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      inviteUserId: json['invite_user_id'],
      planId: json['plan_id'] ?? 0,
      couponId: json['coupon_id'],
      paymentId: json['payment_id'],
      type: json['type'] ?? 0,
      period: json['period'] ?? '',
      tradeNo: json['trade_no'] ?? '',
      callbackNo: json['callback_no'],
      totalAmount: json['total_amount'] ?? 0,
      handlingAmount: json['handling_amount'],
      discountAmount: json['discount_amount'],
      surplusAmount: json['surplus_amount'],
      refundAmount: json['refund_amount'],
      balanceAmount: json['balance_amount'],
      surplusOrderIds: json['surplus_order_ids'] != null
          ? List<int>.from(json['surplus_order_ids'])
          : null,
      status: json['status'] ?? 0,
      commissionStatus: json['commission_status'] ?? 0,
      commissionBalance: json['commission_balance'] ?? 0,
      actualCommissionBalance: json['actual_commission_balance'],
      paidAt: json['paid_at'],
      createdAt: json['created_at'] ?? 0,
      updatedAt: json['updated_at'] ?? 0,
      plan: json['plan'] != null ? PlanModel.fromJson(json['plan']) : null,
      tryOutPlanId: json['try_out_plan_id'],
      bounus: json['bounus'],
      getAmount: json['get_amount'],
    );
  }

  /// 创建一个空的订单实例
  factory OrderModel.empty() {
    return const OrderModel(
      planId: 0,
      type: 0,
      period: '',
      tradeNo: '',
      totalAmount: 0,
      status: STATUS_PENDING,
      commissionStatus: 0,
      commissionBalance: 0,
      createdAt: 0,
      updatedAt: 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'invite_user_id': inviteUserId,
      'plan_id': planId,
      'coupon_id': couponId,
      'payment_id': paymentId,
      'type': type,
      'period': period,
      'trade_no': tradeNo,
      'callback_no': callbackNo,
      'total_amount': totalAmount,
      'handling_amount': handlingAmount,
      'discount_amount': discountAmount,
      'surplus_amount': surplusAmount,
      'refund_amount': refundAmount,
      'balance_amount': balanceAmount,
      'surplus_order_ids': surplusOrderIds,
      'status': status,
      'commission_status': commissionStatus,
      'commission_balance': commissionBalance,
      'actual_commission_balance': actualCommissionBalance,
      'paid_at': paidAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'plan': plan?.toJson(),
      'try_out_plan_id': tryOutPlanId,
      'bounus': bounus,
      'get_amount': getAmount,
    };
  }

  /// 创建一个新的实例，并可选地替换部分属性
  OrderModel copyWith({
    int? inviteUserId,
    int? planId,
    int? couponId,
    int? paymentId,
    int? type,
    String? period,
    String? tradeNo,
    String? callbackNo,
    int? totalAmount,
    int? handlingAmount,
    int? discountAmount,
    int? surplusAmount,
    int? refundAmount,
    int? balanceAmount,
    List<int>? surplusOrderIds,
    int? status,
    int? commissionStatus,
    int? commissionBalance,
    int? actualCommissionBalance,
    int? paidAt,
    int? createdAt,
    int? updatedAt,
    PlanModel? plan,
    int? tryOutPlanId,
    int? bounus,
    int? getAmount,
  }) {
    return OrderModel(
      inviteUserId: inviteUserId ?? this.inviteUserId,
      planId: planId ?? this.planId,
      couponId: couponId ?? this.couponId,
      paymentId: paymentId ?? this.paymentId,
      type: type ?? this.type,
      period: period ?? this.period,
      tradeNo: tradeNo ?? this.tradeNo,
      callbackNo: callbackNo ?? this.callbackNo,
      totalAmount: totalAmount ?? this.totalAmount,
      handlingAmount: handlingAmount ?? this.handlingAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      surplusAmount: surplusAmount ?? this.surplusAmount,
      refundAmount: refundAmount ?? this.refundAmount,
      balanceAmount: balanceAmount ?? this.balanceAmount,
      surplusOrderIds: surplusOrderIds ?? this.surplusOrderIds,
      status: status ?? this.status,
      commissionStatus: commissionStatus ?? this.commissionStatus,
      commissionBalance: commissionBalance ?? this.commissionBalance,
      actualCommissionBalance: actualCommissionBalance ?? this.actualCommissionBalance,
      paidAt: paidAt ?? this.paidAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      plan: plan ?? this.plan,
      tryOutPlanId: tryOutPlanId ?? this.tryOutPlanId,
      bounus: bounus ?? this.bounus,
      getAmount: getAmount ?? this.getAmount,
    );
  }

  /// 订单是否已支付
  bool get isPaid => status == STATUS_COMPLETED;
  
  /// 订单是否待支付
  bool get isPending => status == STATUS_PENDING;
  
  /// 订单是否已取消
  bool get isCancelled => status == STATUS_CANCELLED;
  
  /// 订单是否已退款
  bool get isRefunded => status == STATUS_REFUNDED;
  
  /// 获取可读的总金额
  String get readableTotalAmount => (totalAmount / 100).toStringAsFixed(2);
  
  /// 获取订单对应的产品名称（处理充值订单的特殊情况）
  String getProductName(String Function(String) localizationFunction) {
    // 如果 planId 为 0，说明这是充值订单
    if (planId == 0) {
      return localizationFunction('deposit');
    }
    // 否则返回套餐名称
    return plan?.name ?? localizationFunction('unknown');
  }
  String get typeName {
    switch (type) {
      case TYPE_NEW:
        return '新购';
      case TYPE_RENEW:
        return '续费';
      case TYPE_UPGRADE:
        return '升级';
      case TYPE_RESET_TRAFFIC:
        return '重置流量';
      default:
        return '未知';
    }
  }
  
  /// 获取订单状态名称
  String get statusName {
    switch (status) {
      case STATUS_PENDING:
        return '待支付';
      case STATUS_COMPLETED:
        return '已完成';
      case STATUS_CANCELLED:
        return '已取消';
      case STATUS_REFUNDED:
        return '已退款';
      default:
        return '未知';
    }
  }

  @override
  String toString() {
    return 'OrderModel{tradeNo: $tradeNo, planId: $planId, status: $status, totalAmount: $totalAmount}';
  }
}
