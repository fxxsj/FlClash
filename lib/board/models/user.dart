import 'package:fl_clash/common/base_model.dart' as base;

/// 用户模型，存储用户数据
class UserModel extends base.BaseModel {
  /// 用户ID
  final int userId;
  /// 用户邮箱
  final String email;
  /// 已启用的流量（字节）
  final int transferEnable;
  /// 设备限制数
  final int? deviceLimit;
  /// 上次登录时间戳
  final int? lastLoginAt;
  /// 创建账户的时间戳
  final int createdAt;
  /// 是否已封禁
  final bool banned;
  /// 是否自动续费
  final bool autoRenewal;
  /// 是否提醒过期
  final bool remindExpire;
  /// 是否提醒流量
  final bool remindTraffic;
  /// 过期时间戳
  final int? expiredAt;
  /// 账户余额
  final int balance;
  /// 佣金余额
  final int commissionBalance;
  /// 套餐ID
  final int? planId;
  /// 折扣值
  final int discount;
  /// 佣金比例
  final int commissionRate;
  /// Telegram ID
  final String? telegramId;
  /// UUID
  final String uuid;
  /// 登录令牌
  final String? token;
  /// 头像URL
  final String? avatarUrl;

  const UserModel({
    required this.userId,
    required this.email,
    required this.transferEnable,
    this.deviceLimit,
    this.lastLoginAt,
    required this.createdAt,
    required this.banned,
    required this.autoRenewal,
    required this.remindExpire,
    required this.remindTraffic,
    this.expiredAt,
    required this.balance,
    required this.commissionBalance,
    this.planId,
    required this.discount,
    required this.commissionRate,
    this.telegramId,
    required this.uuid,
    this.token,
    this.avatarUrl,
  });

  /// 从JSON创建实例
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: base.ModelConverter.getInt(json['id']),
      email: base.ModelConverter.getString(json['email']),
      transferEnable: base.ModelConverter.getInt(json['transfer_enable']),
      deviceLimit: json['device_limit'] as int?,
      lastLoginAt: json['last_login_at'] as int?,
      createdAt: base.ModelConverter.getInt(json['created_at']),
      banned: base.ModelConverter.getBool(json['banned']),
      autoRenewal: base.ModelConverter.getBool(json['auto_renewal']),
      remindExpire: base.ModelConverter.getBool(json['remind_expire']),
      remindTraffic: base.ModelConverter.getBool(json['remind_traffic']),
      expiredAt: json['expired_at'] as int?,
      balance: base.ModelConverter.getInt(json['balance']),
      commissionBalance: base.ModelConverter.getInt(json['commission_balance']),
      planId: json['plan_id'] as int?,
      discount: base.ModelConverter.getInt(json['discount']),
      commissionRate: base.ModelConverter.getInt(json['commission_rate']),
      telegramId: base.ModelConverter.getString(json['telegram_id'], ''),
      uuid: base.ModelConverter.getString(json['uuid']),
      token: base.ModelConverter.getString(json['token'], ''),
      avatarUrl: base.ModelConverter.getString(json['avatar_url'], ''),
    );
  }

  /// 创建一个空的用户实例
  factory UserModel.empty() {
    return const UserModel(
      userId: 0,
      email: '',
      transferEnable: 0,
      createdAt: 0,
      banned: false,
      autoRenewal: false,
      remindExpire: false,
      remindTraffic: false,
      balance: 0,
      commissionBalance: 0,
      discount: 0,
      commissionRate: 0,
      uuid: '',
    );
  }

  /// 转换为JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'email': email,
      'transfer_enable': transferEnable,
      'device_limit': deviceLimit,
      'last_login_at': lastLoginAt,
      'created_at': createdAt,
      'banned': banned ? 1 : 0,
      'auto_renewal': autoRenewal ? 1 : 0,
      'remind_expire': remindExpire ? 1 : 0,
      'remind_traffic': remindTraffic ? 1 : 0,
      'expired_at': expiredAt,
      'balance': balance,
      'commission_balance': commissionBalance,
      'plan_id': planId,
      'discount': discount,
      'commission_rate': commissionRate,
      'telegram_id': telegramId,
      'uuid': uuid,
      'token': token,
      'avatar_url': avatarUrl,
    };
  }

  /// 创建一个新的实例，并可选地替换部分属性
  @override
  UserModel copyWith({
    int? userId,
    String? email,
    int? transferEnable,
    int? deviceLimit,
    int? lastLoginAt,
    int? createdAt,
    bool? banned,
    bool? autoRenewal,
    bool? remindExpire,
    bool? remindTraffic,
    int? expiredAt,
    int? balance,
    int? commissionBalance,
    int? planId,
    int? discount,
    int? commissionRate,
    String? telegramId,
    String? uuid,
    String? token,
    String? avatarUrl,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      transferEnable: transferEnable ?? this.transferEnable,
      deviceLimit: deviceLimit ?? this.deviceLimit,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      createdAt: createdAt ?? this.createdAt,
      banned: banned ?? this.banned,
      autoRenewal: autoRenewal ?? this.autoRenewal,
      remindExpire: remindExpire ?? this.remindExpire,
      remindTraffic: remindTraffic ?? this.remindTraffic,
      expiredAt: expiredAt ?? this.expiredAt,
      balance: balance ?? this.balance,
      commissionBalance: commissionBalance ?? this.commissionBalance,
      planId: planId ?? this.planId,
      discount: discount ?? this.discount,
      commissionRate: commissionRate ?? this.commissionRate,
      telegramId: telegramId ?? this.telegramId,
      uuid: uuid ?? this.uuid,
      token: token ?? this.token,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  bool isValid() {
    return base.ModelValidator.isNotEmpty(email) && 
           base.ModelValidator.isValidEmail(email) &&
           userId > 0 &&
           uuid.isNotEmpty;
  }

  @override
  String get displayTitle => email.isNotEmpty ? email : 'User #$userId';

  @override
  String get id => uuid;
  
  /// 用户是否有效期内
  bool get isExpired {
    if (expiredAt == null) return false;
    return DateTime.now().millisecondsSinceEpoch / 1000 > expiredAt!;
  }
  
  /// 获取可读的账户余额
  String get readableBalance => (balance / 100).toStringAsFixed(2);
  
  /// 获取可读的佣金余额
  String get readableCommissionBalance => 
      (commissionBalance / 100).toStringAsFixed(2);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.uuid == uuid;
  }

  @override
  int get hashCode => uuid.hashCode;
}
