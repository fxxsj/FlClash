import 'base_model.dart';

/// 套餐计划模型
class PlanModel extends BaseModel {
  /// 套餐ID
  final int id;
  /// 套餐分组ID
  final int groupId;
  /// 可用流量（字节）
  final int transferEnable;
  /// 套餐名称
  final String name;
  /// 设备限制数
  final int? deviceLimit;
  /// 速度限制(Mbps)
  final int? speedLimit;
  /// 是否显示(1:显示,0:隐藏)
  final int show;
  /// 排序
  final int? sort;
  /// 是否可续费(1:可续费,0:不可续费)
  final int renew;
  /// 套餐描述内容
  final String content;
  /// 月付价格(分)
  final int monthPrice;
  /// 季付价格(分)
  final int quarterPrice;
  /// 半年付价格(分)
  final int halfYearPrice;
  /// 年付价格(分)
  final int yearPrice;
  /// 两年付价格(分)
  final int? twoYearPrice;
  /// 三年付价格(分)
  final int? threeYearPrice;
  /// 一次性价格(分)
  final int? onetimePrice;
  /// 重置流量价格(分)
  final int resetPrice;
  /// 重置流量方式
  final String? resetTrafficMethod;
  /// 容量限制
  final int? capacityLimit;
  /// 创建时间
  final int createdAt;
  /// 更新时间
  final int updatedAt;

  const PlanModel({
    required this.id,
    required this.groupId,
    required this.transferEnable,
    required this.name,
    this.deviceLimit,
    this.speedLimit,
    required this.show,
    this.sort,
    required this.renew,
    required this.content,
    required this.monthPrice,
    required this.quarterPrice,
    required this.halfYearPrice,
    required this.yearPrice,
    this.twoYearPrice,
    this.threeYearPrice,
    this.onetimePrice,
    required this.resetPrice,
    this.resetTrafficMethod,
    this.capacityLimit,
    required this.createdAt,
    required this.updatedAt,
  });

  /// 从JSON创建实例
  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['id'] ?? 0,
      groupId: json['group_id'] ?? 0,
      transferEnable: json['transfer_enable'] ?? 0,
      name: json['name'] ?? '',
      deviceLimit: json['device_limit'],
      speedLimit: json['speed_limit'],
      show: json['show'] ?? 1,
      sort: json['sort'],
      renew: json['renew'] ?? 1,
      content: json['content'] ?? '',
      monthPrice: json['month_price'] ?? 0,
      quarterPrice: json['quarter_price'] ?? 0,
      halfYearPrice: json['half_year_price'] ?? 0,
      yearPrice: json['year_price'] ?? 0,
      twoYearPrice: json['two_year_price'],
      threeYearPrice: json['three_year_price'],
      onetimePrice: json['onetime_price'],
      resetPrice: json['reset_price'] ?? 0,
      resetTrafficMethod: json['reset_traffic_method'],
      capacityLimit: json['capacity_limit'],
      createdAt: json['created_at'] ?? 0,
      updatedAt: json['updated_at'] ?? 0,
    );
  }

  /// 创建一个空的套餐实例
  factory PlanModel.empty() {
    return const PlanModel(
      id: 0,
      groupId: 0,
      transferEnable: 0,
      name: '',
      show: 1,
      renew: 1,
      content: '',
      monthPrice: 0,
      quarterPrice: 0,
      halfYearPrice: 0,
      yearPrice: 0,
      resetPrice: 0,
      createdAt: 0,
      updatedAt: 0,
    );
  }

  /// 获取指定周期的价格
  int getPriceByPeriod(String period) {
    switch (period) {
      case 'month_price':
        return monthPrice;
      case 'quarter_price':
        return quarterPrice;
      case 'half_year_price':
        return halfYearPrice;
      case 'year_price':
        return yearPrice;
      case 'two_year_price':
        return twoYearPrice ?? 0;
      case 'three_year_price':
        return threeYearPrice ?? 0;
      case 'onetime_price':
        return onetimePrice ?? 0;
      case 'reset_price':
        return resetPrice;
      default:
        return 0;
    }
  }

  /// 获取流量大小(GB)
  int get transferEnableGB => transferEnable;

  /// 获取最低价格和周期
  String get lowestPriceInfo {
    if (monthPrice > 0) {
      return '¥${(monthPrice / 100).toStringAsFixed(2)}/月';
    }
    if (quarterPrice > 0) {
      return '¥${(quarterPrice / 100).toStringAsFixed(2)}/季';
    }
    if (halfYearPrice > 0) {
      return '¥${(halfYearPrice / 100).toStringAsFixed(2)}/半年';
    }
    if (yearPrice > 0) {
      return '¥${(yearPrice / 100).toStringAsFixed(2)}/年';
    }
    if (twoYearPrice != null && twoYearPrice! > 0) {
      return '¥${(twoYearPrice! / 100).toStringAsFixed(2)}/两年';
    }
    if (threeYearPrice != null && threeYearPrice! > 0) {
      return '¥${(threeYearPrice! / 100).toStringAsFixed(2)}/三年';
    }
    if (onetimePrice != null && onetimePrice! > 0) {
      return '¥${(onetimePrice! / 100).toStringAsFixed(2)}/一次性';
    }
    return '';
  }
  
  /// 获取最低价格
  int get lowestPrice {
    final prices = [
      monthPrice, 
      quarterPrice, 
      halfYearPrice, 
      yearPrice,
      twoYearPrice ?? 0,
      threeYearPrice ?? 0,
      onetimePrice ?? 0
    ].where((price) => price > 0).toList();
    
    return prices.isEmpty ? 0 : prices.reduce((a, b) => a < b ? a : b);
  }

  /// 获取可读的最低价格
  String get readableLowestPrice => (lowestPrice / 100).toStringAsFixed(2);
  
  /// 是否有效套餐
  bool get isValid => id > 0 && transferEnable > 0;

  @override
  String toString() {
    return 'PlanModel{id: $id, name: $name}';
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': groupId,
      'name': name,
      'transfer_enable': transferEnable,
      'device_limit': deviceLimit,
      'speed_limit': speedLimit,
      'show': show,
      'sort': sort,
      'renew': renew,
      'content': content,
      'month_price': monthPrice,
      'quarter_price': quarterPrice,
      'half_year_price': halfYearPrice,
      'year_price': yearPrice,
      'two_year_price': twoYearPrice,
      'three_year_price': threeYearPrice,
      'onetime_price': onetimePrice,
      'reset_price': resetPrice,
      'reset_traffic_method': resetTrafficMethod,
      'capacity_limit': capacityLimit,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  /// 创建一个新的实例，并可选地替换部分属性
  PlanModel copyWith({
    int? id,
    int? groupId,
    int? transferEnable,
    String? name,
    int? deviceLimit,
    int? speedLimit,
    int? show,
    int? sort,
    int? renew,
    String? content,
    int? monthPrice,
    int? quarterPrice,
    int? halfYearPrice,
    int? yearPrice,
    int? twoYearPrice,
    int? threeYearPrice,
    int? onetimePrice,
    int? resetPrice,
    String? resetTrafficMethod,
    int? capacityLimit,
    int? createdAt,
    int? updatedAt,
  }) {
    return PlanModel(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      transferEnable: transferEnable ?? this.transferEnable,
      name: name ?? this.name,
      deviceLimit: deviceLimit ?? this.deviceLimit,
      speedLimit: speedLimit ?? this.speedLimit,
      show: show ?? this.show,
      sort: sort ?? this.sort,
      renew: renew ?? this.renew,
      content: content ?? this.content,
      monthPrice: monthPrice ?? this.monthPrice,
      quarterPrice: quarterPrice ?? this.quarterPrice,
      halfYearPrice: halfYearPrice ?? this.halfYearPrice,
      yearPrice: yearPrice ?? this.yearPrice,
      twoYearPrice: twoYearPrice ?? this.twoYearPrice,
      threeYearPrice: threeYearPrice ?? this.threeYearPrice,
      onetimePrice: onetimePrice ?? this.onetimePrice,
      resetPrice: resetPrice ?? this.resetPrice,
      resetTrafficMethod: resetTrafficMethod ?? this.resetTrafficMethod,
      capacityLimit: capacityLimit ?? this.capacityLimit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
