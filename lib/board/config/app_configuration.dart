/// 应用配置数据结构
class AppConfiguration {
  final String appTitle;
  final String baseUrl;
  final String apiVersion;
  final String updateUrl;
  final String updateCheckUrl;
  final String securityFlag;
  final int version;
  final DateTime lastUpdated;

  const AppConfiguration({
    required this.appTitle,
    required this.baseUrl,
    required this.apiVersion,
    required this.updateUrl,
    required this.updateCheckUrl,
    this.securityFlag = '',
    this.version = 1,
    required this.lastUpdated,
  });

  /// 从默认值创建配置
  factory AppConfiguration.defaults() {
    return AppConfiguration(
      appTitle: 'FlClash',
      baseUrl: '',
      apiVersion: '/api/v1',
      updateUrl: 'https://cloud.ziu.ooo/FxClash/',
      updateCheckUrl: 'https://f005.backblazeb2.com/file/fx2025/app_latest_version.json',
      securityFlag: '',
      version: 1,
      lastUpdated: DateTime.now(),
    );
  }

  /// 从JSON创建配置
  factory AppConfiguration.fromJson(Map<String, dynamic> json) {
    return AppConfiguration(
      appTitle: json['appTitle'] ?? 'FlClash',
      baseUrl: _parseBaseUrl(json['baseUrl']),
      apiVersion: json['apiVersion'] ?? '/api/v1',
      updateUrl: json['appUpdateUrl'] ?? 'https://cloud.ziu.ooo/FxClash/',
      updateCheckUrl: json['appUpdateCheckUrl'] ?? 'https://f005.backblazeb2.com/file/fx2025/app_latest_version.json',
      securityFlag: json['securityFlag'] ?? '',
      version: json['version'] ?? 1,
      lastUpdated: json['lastUpdated'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(json['lastUpdated'])
          : DateTime.now(),
    );
  }

  /// 解析baseUrl，处理数组和字符串两种情况
  static String _parseBaseUrl(dynamic baseUrl) {
    if (baseUrl is List && baseUrl.isNotEmpty) {
      return baseUrl.first.toString();
    } else if (baseUrl is String) {
      return baseUrl;
    }
    return '';
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'appTitle': appTitle,
      'baseUrl': baseUrl,
      'apiVersion': apiVersion,
      'appUpdateUrl': updateUrl,
      'appUpdateCheckUrl': updateCheckUrl,
      'securityFlag': securityFlag,
      'version': version,
      'lastUpdated': lastUpdated.millisecondsSinceEpoch,
    };
  }

  /// 配置验证
  bool isValid() {
    return appTitle.isNotEmpty && 
           baseUrl.isNotEmpty && 
           apiVersion.isNotEmpty && 
           _isValidUrl(baseUrl) &&
           _isValidUrl(updateUrl) &&
           _isValidUrl(updateCheckUrl);
  }

  /// URL验证
  bool _isValidUrl(String url) {
    if (url.isEmpty) return false;
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  /// 获取验证错误列表
  List<String> validate() {
    final errors = <String>[];
    
    if (appTitle.isEmpty) {
      errors.add('应用标题不能为空');
    }
    
    if (baseUrl.isEmpty) {
      errors.add('基础URL不能为空');
    } else if (!_isValidUrl(baseUrl)) {
      errors.add('基础URL格式无效');
    }
    
    if (apiVersion.isEmpty) {
      errors.add('API版本不能为空');
    }
    
    if (!_isValidUrl(updateUrl)) {
      errors.add('更新URL格式无效');
    }
    
    if (!_isValidUrl(updateCheckUrl)) {
      errors.add('更新检查URL格式无效');
    }
    
    return errors;
  }

  /// 配置合并（优先使用非空的新值）
  AppConfiguration merge(AppConfiguration other) {
    return AppConfiguration(
      appTitle: other.appTitle.isNotEmpty ? other.appTitle : appTitle,
      baseUrl: other.baseUrl.isNotEmpty ? other.baseUrl : baseUrl,
      apiVersion: other.apiVersion.isNotEmpty ? other.apiVersion : apiVersion,
      updateUrl: other.updateUrl.isNotEmpty ? other.updateUrl : updateUrl,
      updateCheckUrl: other.updateCheckUrl.isNotEmpty ? other.updateCheckUrl : updateCheckUrl,
      securityFlag: other.securityFlag.isNotEmpty ? other.securityFlag : securityFlag,
      version: other.version > version ? other.version : version,
      lastUpdated: other.lastUpdated.isAfter(lastUpdated) ? other.lastUpdated : lastUpdated,
    );
  }

  /// 创建副本
  AppConfiguration copyWith({
    String? appTitle,
    String? baseUrl,
    String? apiVersion,
    String? updateUrl,
    String? updateCheckUrl,
    String? securityFlag,
    int? version,
    DateTime? lastUpdated,
  }) {
    return AppConfiguration(
      appTitle: appTitle ?? this.appTitle,
      baseUrl: baseUrl ?? this.baseUrl,
      apiVersion: apiVersion ?? this.apiVersion,
      updateUrl: updateUrl ?? this.updateUrl,
      updateCheckUrl: updateCheckUrl ?? this.updateCheckUrl,
      securityFlag: securityFlag ?? this.securityFlag,
      version: version ?? this.version,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  /// 获取完整的API URL
  String get fullApiUrl {
    String url = baseUrl.trim();
    if (url.isEmpty) return '';
    
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    
    return url + apiVersion;
  }

  /// 调试信息
  String get debugInfo {
    return '''
AppConfiguration Debug Info:
  appTitle: $appTitle
  baseUrl: $baseUrl
  apiVersion: $apiVersion
  fullApiUrl: $fullApiUrl
  updateUrl: $updateUrl
  updateCheckUrl: $updateCheckUrl
  securityFlag: $securityFlag
  version: $version
  lastUpdated: $lastUpdated
  isValid: ${isValid()}
''';
  }

  @override
  String toString() {
    return 'AppConfiguration(appTitle: $appTitle, baseUrl: $baseUrl, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppConfiguration &&
        other.appTitle == appTitle &&
        other.baseUrl == baseUrl &&
        other.apiVersion == apiVersion &&
        other.updateUrl == updateUrl &&
        other.updateCheckUrl == updateCheckUrl &&
        other.securityFlag == securityFlag &&
        other.version == version;
  }

  @override
  int get hashCode {
    return Object.hash(
      appTitle,
      baseUrl,
      apiVersion,
      updateUrl,
      updateCheckUrl,
      securityFlag,
      version,
    );
  }
}