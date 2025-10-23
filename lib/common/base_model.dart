
/// 基础模型类，提供通用的序列化功能
/// 所有业务模型都应该继承这个类来减少重复代码
abstract class BaseModel {
  const BaseModel();

  /// 将模型转换为 JSON Map
  Map<String, dynamic> toJson();

  /// 从 JSON Map 创建模型实例
  /// 子类需要实现这个静态方法
  // static T fromJson<T extends BaseModel>(Map<String, dynamic> json);

  /// 创建空实例
  /// 子类需要实现这个静态方法
  // static T empty<T extends BaseModel>();

  /// 通用的 copyWith 方法基础
  /// 子类可以扩展这个方法
  BaseModel copyWith();

  /// 模型验证
  /// 子类可以重写这个方法来添加特定的验证逻辑
  bool isValid() => true;

  /// 获取模型的显示标题
  /// 子类可以重写这个方法
  String get displayTitle => toString();

  /// 获取模型的唯一标识
  /// 子类应该重写这个方法
  String get id => hashCode.toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other.runtimeType == runtimeType;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

/// 带有时间戳的基础模型
abstract class TimestampedModel extends BaseModel {
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TimestampedModel({
    this.createdAt,
    this.updatedAt,
  });

  /// 更新时间戳
  TimestampedModel withTimestamp({
    DateTime? createdAt,
    DateTime? updatedAt,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

/// 分页模型基础类
class PaginatedResponse<T> extends BaseModel {
  final List<T> data;
  final int total;
  final int page;
  final int pageSize;
  final bool hasMore;

  const PaginatedResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.hasMore,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final dataList = (json['data'] as List?)
        ?.map((item) => fromJsonT(item as Map<String, dynamic>))
        .toList() ?? [];
    
    return PaginatedResponse<T>(
      data: dataList,
      total: json['total'] as int? ?? 0,
      page: json['page'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 10,
      hasMore: json['hasMore'] as bool? ?? false,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) {
        if (item is BaseModel) {
          return (item as BaseModel).toJson();
        }
        return item;
      }).toList(),
      'total': total,
      'page': page,
      'pageSize': pageSize,
      'hasMore': hasMore,
    };
  }

  @override
  BaseModel copyWith() {
    return PaginatedResponse<T>(
      data: data,
      total: total,
      page: page,
      pageSize: pageSize,
      hasMore: hasMore,
    );
  }

  /// 是否为空页面
  bool get isEmpty => data.isEmpty;

  /// 是否为第一页
  bool get isFirstPage => page <= 1;

  /// 获取下一页页码
  int get nextPage => page + 1;
}

/// API 响应基础类
class ApiResponse<T> extends BaseModel {
  final bool success;
  final String? message;
  final T? data;
  final int? code;
  final String? error;

  const ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.code,
    this.error,
  });

  factory ApiResponse.success(T data, {String? message}) {
    return ApiResponse<T>(
      success: true,
      data: data,
      message: message,
      code: 200,
    );
  }

  factory ApiResponse.error(String error, {int? code}) {
    return ApiResponse<T>(
      success: false,
      error: error,
      code: code ?? 500,
    );
  }

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>)? fromJsonT,
  ) {
    final success = json['success'] as bool? ?? 
                   (json['code'] as int? ?? 0) == 200;
    
    T? data;
    if (fromJsonT != null && json['data'] != null) {
      if (json['data'] is Map<String, dynamic>) {
        data = fromJsonT(json['data'] as Map<String, dynamic>);
      } else {
        data = json['data'] as T?;
      }
    } else {
      data = json['data'] as T?;
    }

    return ApiResponse<T>(
      success: success,
      message: json['message'] as String?,
      data: data,
      code: json['code'] as int?,
      error: json['error'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data is BaseModel ? (data as BaseModel).toJson() : data,
      'code': code,
      'error': error,
    };
  }

  @override
  BaseModel copyWith() {
    return ApiResponse<T>(
      success: success,
      message: message,
      data: data,
      code: code,
      error: error,
    );
  }

  @override
  bool isValid() => success && error == null;
}

/// 常用的模型验证规则
class ModelValidator {
  /// 验证邮箱格式
  static bool isValidEmail(String? email) {
    if (email == null || email.isEmpty) return false;
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }

  /// 验证手机号格式
  static bool isValidPhone(String? phone) {
    if (phone == null || phone.isEmpty) return false;
    return RegExp(r'^1[3-9]\d{9}$').hasMatch(phone);
  }

  /// 验证密码强度
  static bool isValidPassword(String? password) {
    if (password == null || password.length < 6) return false;
    return true; // 可以根据需要添加更复杂的验证
  }

  /// 验证 URL 格式
  static bool isValidUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.isScheme('http') || uri.isScheme('https'));
    } catch (_) {
      return false;
    }
  }

  /// 验证非空字符串
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
}

/// 模型转换工具类
class ModelConverter {
  /// 安全的字符串转换
  static String getString(dynamic value, [String defaultValue = '']) {
    if (value == null) return defaultValue;
    return value.toString();
  }

  /// 安全的整数转换
  static int getInt(dynamic value, [int defaultValue = 0]) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  /// 安全的双精度浮点数转换
  static double getDouble(dynamic value, [double defaultValue = 0.0]) {
    if (value == null) return defaultValue;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  /// 安全的布尔值转换
  static bool getBool(dynamic value, [bool defaultValue = false]) {
    if (value == null) return defaultValue;
    if (value is bool) return value;
    if (value is int) return value != 0;
    if (value is String) {
      final lower = value.toLowerCase();
      return lower == 'true' || lower == '1' || lower == 'yes';
    }
    return defaultValue;
  }

  /// 安全的日期时间转换
  static DateTime? getDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    return null;
  }

  /// 安全的列表转换
  static List<T> getList<T>(
    dynamic value,
    T Function(dynamic) converter, [
    List<T>? defaultValue,
  ]) {
    if (value == null) return defaultValue ?? <T>[];
    if (value is! List) return defaultValue ?? <T>[];
    
    try {
      return value.map((item) => converter(item)).toList();
    } catch (_) {
      return defaultValue ?? <T>[];
    }
  }
}