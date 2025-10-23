class InviteDetailModel {
  final int createdAt;
  final double getAmount;

  InviteDetailModel({
    required this.createdAt,
    required this.getAmount,
  });

  factory InviteDetailModel.fromJson(Map<String, dynamic> json) {
    return InviteDetailModel(
      createdAt: json['created_at'] ?? 0,
      getAmount: (json['get_amount'] ?? 0).toDouble() / 100, // 转换为元
    );
  }

  /// 获取格式化的时间字符串
  String get formattedTime {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(createdAt * 1000);
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// 获取格式化的金额字符串
  String get formattedAmount {
    return '¥${getAmount.toStringAsFixed(2)}';
  }
}