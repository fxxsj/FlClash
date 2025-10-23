import 'base_model.dart';

/// 邀请码模型
class InviteModel extends BaseModel {
  /// 邀请码ID
  final int id;
  /// 用户ID
  final int userId;
  /// 邀请码
  final String code;
  /// 状态（0:未使用,1:已使用）
  final int status;
  /// 创建时间
  final int createdAt;
  /// 更新时间
  final int updatedAt;

  const InviteModel({
    required this.id,
    required this.userId,
    required this.code,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  /// 从JSON创建实例
  factory InviteModel.fromJson(Map<String, dynamic> json) {
    return InviteModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      code: json['code'] ?? '',
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? 0,
      updatedAt: json['updated_at'] ?? 0,
    );
  }

  /// 创建一个空的邀请码实例
  factory InviteModel.empty() {
    return const InviteModel(
      id: 0,
      userId: 0,
      code: '',
      status: 0,
      createdAt: 0,
      updatedAt: 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'code': code,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  /// 创建一个新的实例，并可选地替换部分属性
  InviteModel copyWith({
    int? id,
    int? userId,
    String? code,
    int? status,
    int? createdAt,
    int? updatedAt,
  }) {
    return InviteModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      code: code ?? this.code,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// 邀请码是否已使用
  bool get isUsed => status == 1;
  
  /// 邀请码状态名称
  String get statusName => status == 1 ? '已使用' : '未使用';
}

/// 邀请记录模型
class InviteRecordModel extends BaseModel {
  /// 记录ID
  final int id;
  /// 用户ID
  final int userId;
  /// 被邀请用户ID
  final int invitedUserId;
  /// 佣金
  final int commission;
  /// 创建时间
  final int createdAt;
  /// 更新时间
  final int updatedAt;
  /// 被邀请用户邮箱
  final String? invitedUserEmail;

  const InviteRecordModel({
    required this.id,
    required this.userId,
    required this.invitedUserId,
    required this.commission,
    required this.createdAt,
    required this.updatedAt,
    this.invitedUserEmail,
  });

  /// 从JSON创建实例
  factory InviteRecordModel.fromJson(Map<String, dynamic> json) {
    return InviteRecordModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      invitedUserId: json['invited_user_id'] ?? 0,
      commission: json['commission'] ?? 0,
      createdAt: json['created_at'] ?? 0,
      updatedAt: json['updated_at'] ?? 0,
      invitedUserEmail: json['invited_user_email'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'invited_user_id': invitedUserId,
      'commission': commission,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'invited_user_email': invitedUserEmail,
    };
  }

  /// 创建一个新的实例，并可选地替换部分属性
  InviteRecordModel copyWith({
    int? id,
    int? userId,
    int? invitedUserId,
    int? commission,
    int? createdAt,
    int? updatedAt,
    String? invitedUserEmail,
  }) {
    return InviteRecordModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      invitedUserId: invitedUserId ?? this.invitedUserId,
      commission: commission ?? this.commission,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      invitedUserEmail: invitedUserEmail ?? this.invitedUserEmail,
    );
  }

  /// 获取可读的佣金金额
  String get readableCommission => (commission / 100).toStringAsFixed(2);
}

/// 佣金记录模型
class CommissionLogModel extends BaseModel {
  /// 记录ID
  final int id;
  /// 用户ID
  final int userId;
  /// 订单ID
  final int? orderId;
  /// 交易号
  final String? tradeNo;
  /// 佣金金额
  final int commission;
  /// 状态（0:待发放,1:已发放,2:已取消）
  final int status;
  /// 创建时间
  final int createdAt;
  /// 更新时间
  final int updatedAt;

  const CommissionLogModel({
    required this.id,
    required this.userId,
    this.orderId,
    this.tradeNo,
    required this.commission,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  /// 从JSON创建实例
  factory CommissionLogModel.fromJson(Map<String, dynamic> json) {
    return CommissionLogModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      orderId: json['order_id'],
      tradeNo: json['trade_no'],
      commission: json['commission'] ?? 0,
      status: json['status'] ?? 0,
      createdAt: json['created_at'] ?? 0,
      updatedAt: json['updated_at'] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'order_id': orderId,
      'trade_no': tradeNo,
      'commission': commission,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  /// 创建一个新的实例，并可选地替换部分属性
  CommissionLogModel copyWith({
    int? id,
    int? userId,
    int? orderId,
    String? tradeNo,
    int? commission,
    int? status,
    int? createdAt,
    int? updatedAt,
  }) {
    return CommissionLogModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      orderId: orderId ?? this.orderId,
      tradeNo: tradeNo ?? this.tradeNo,
      commission: commission ?? this.commission,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// 获取可读的佣金金额
  String get readableCommission => (commission / 100).toStringAsFixed(2);
  
  /// 佣金状态名称
  String get statusName {
    switch (status) {
      case 0:
        return '待发放';
      case 1:
        return '已发放';
      case 2:
        return '已取消';
      default:
        return '未知';
    }
  }
} 