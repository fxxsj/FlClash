import 'base_model.dart';

/// 系统配置模型
class ConfigModel extends BaseModel {
  /// 服务条款URL
  final String? tosUrl;
  /// 是否启用邮箱验证
  final bool isEmailVerify;
  /// 是否强制邀请码
  final bool isInviteForce;
  /// 邮箱白名单后缀列表
  final List<String>? emailWhitelistSuffix;
  /// 是否启用reCAPTCHA
  final bool isRecaptcha;
  /// reCAPTCHA站点密钥
  final String? recaptchaSiteKey;
  /// 应用描述
  final String? appDescription;
  /// 应用URL
  final String? appUrl;
  /// 站点Logo
  final String? logo;

  const ConfigModel({
    this.tosUrl,
    required this.isEmailVerify,
    required this.isInviteForce,
    this.emailWhitelistSuffix,
    required this.isRecaptcha,
    this.recaptchaSiteKey,
    this.appDescription,
    this.appUrl,
    this.logo,
  });

  /// 从JSON创建实例
  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    // 安全处理邮箱白名单后缀
    final emailWhitelist = json['email_whitelist_suffix'];
    List<String>? emailWhitelistSuffix;
    
    if (emailWhitelist is List) {
      emailWhitelistSuffix = List<String>.from(
        emailWhitelist.map((e) => e.toString())
      );
    } else if (emailWhitelist is int && emailWhitelist == 0) {
      emailWhitelistSuffix = null; // 使用 null 表示白名单禁用
    }
    
    return ConfigModel(
      tosUrl: json['tos_url']?.toString(),
      isEmailVerify: json['is_email_verify'] == 1,
      isInviteForce: json['is_invite_force'] == 1,
      emailWhitelistSuffix: emailWhitelistSuffix,
      isRecaptcha: json['is_recaptcha'] == 1,
      recaptchaSiteKey: json['recaptcha_site_key']?.toString(),
      appDescription: json['app_description']?.toString(),
      appUrl: json['app_url']?.toString(),
      logo: json['logo']?.toString(),
    );
  }

  /// 创建默认配置实例
  factory ConfigModel.defaults() {
    return const ConfigModel(
      isEmailVerify: false,
      isInviteForce: false,
      isRecaptcha: false,
    );
  }

  /// 转换为JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'tos_url': tosUrl,
      'is_email_verify': isEmailVerify ? 1 : 0,
      'is_invite_force': isInviteForce ? 1 : 0,
      'email_whitelist_suffix': emailWhitelistSuffix ?? 0,
      'is_recaptcha': isRecaptcha ? 1 : 0,
      'recaptcha_site_key': recaptchaSiteKey,
      'app_description': appDescription,
      'app_url': appUrl,
      'logo': logo,
    };
  }

  /// 创建一个新的实例，并可选地替换部分属性
  ConfigModel copyWith({
    String? tosUrl,
    bool? isEmailVerify,
    bool? isInviteForce,
    List<String>? emailWhitelistSuffix,
    bool? isRecaptcha,
    String? recaptchaSiteKey,
    String? appDescription,
    String? appUrl,
    String? logo,
  }) {
    return ConfigModel(
      tosUrl: tosUrl ?? this.tosUrl,
      isEmailVerify: isEmailVerify ?? this.isEmailVerify,
      isInviteForce: isInviteForce ?? this.isInviteForce,
      emailWhitelistSuffix: emailWhitelistSuffix ?? this.emailWhitelistSuffix,
      isRecaptcha: isRecaptcha ?? this.isRecaptcha,
      recaptchaSiteKey: recaptchaSiteKey ?? this.recaptchaSiteKey,
      appDescription: appDescription ?? this.appDescription,
      appUrl: appUrl ?? this.appUrl,
      logo: logo ?? this.logo,
    );
  }
}
