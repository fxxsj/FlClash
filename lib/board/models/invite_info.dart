import 'base_model.dart';
import 'package:fl_clash/board/models/invite.dart';

/// 邀请信息汇总模型（用于我的邀请页面显示）
class InviteInfoModel extends BaseModel {
  /// 邀请码列表
  final List<InviteModel> codes;
  
  /// 已注册用户数
  final int registeredCount;
  
  /// 当前余额（佣金）
  final int currentBalance;
  
  /// 确认中的佣金
  final int pendingCommission;
  
  /// 佣金比例 (%)
  final int commissionRate;
  
  /// 累计获得佣金
  final int totalCommission;

  const InviteInfoModel({
    required this.codes,
    required this.registeredCount,
    required this.currentBalance,
    required this.pendingCommission,
    required this.commissionRate,
    required this.totalCommission,
  });

  /// 从API数据创建实例
  factory InviteInfoModel.fromApiData(Map<String, dynamic> data) {
    final codesData = data['codes'] as List? ?? [];
    final codes = codesData.map((code) => InviteModel.fromJson(code)).toList();
    
    final stat = data['stat'] as List? ?? [0, 0, 0, 0, 0];
    
    // 根据API文档，stat数组结构为：
    // stat[0]: 已注册用户数
    // stat[1]: 有效的佣金 (累计获得佣金)
    // stat[2]: 确认中的佣金
    // stat[3]: 佣金比例
    // stat[4]: 可用佣金 (当前剩余佣金)
    
    return InviteInfoModel(
      codes: codes,
      registeredCount: stat.isNotEmpty ? (stat[0] as num).toInt() : 0,
      currentBalance: stat.length > 4 ? (stat[4] as num).toInt() : 0, // 可用佣金
      pendingCommission: stat.length > 2 ? (stat[2] as num).toInt() : 0,
      commissionRate: stat.length > 3 ? (stat[3] as num).toInt() : 0,
      totalCommission: stat.length > 1 ? (stat[1] as num).toInt() : 0, // 有效的佣金
    );
  }

  /// 创建空实例
  factory InviteInfoModel.empty() {
    return const InviteInfoModel(
      codes: [],
      registeredCount: 0,
      currentBalance: 0,
      pendingCommission: 0,
      commissionRate: 0,
      totalCommission: 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'codes': codes.map((code) => code.toJson()).toList(),
      'registered_count': registeredCount,
      'current_balance': currentBalance,
      'pending_commission': pendingCommission,
      'commission_rate': commissionRate,
      'total_commission': totalCommission,
    };
  }

  /// 创建新实例并替换部分属性
  InviteInfoModel copyWith({
    List<InviteModel>? codes,
    int? registeredCount,
    int? currentBalance,
    int? pendingCommission,
    int? commissionRate,
    int? totalCommission,
  }) {
    return InviteInfoModel(
      codes: codes ?? this.codes,
      registeredCount: registeredCount ?? this.registeredCount,
      currentBalance: currentBalance ?? this.currentBalance,
      pendingCommission: pendingCommission ?? this.pendingCommission,
      commissionRate: commissionRate ?? this.commissionRate,
      totalCommission: totalCommission ?? this.totalCommission,
    );
  }

  /// 获取可读的当前余额
  String get readableCurrentBalance => (currentBalance / 100).toStringAsFixed(2);

  /// 获取可读的确认中佣金
  String get readablePendingCommission => (pendingCommission / 100).toStringAsFixed(2);

  /// 获取可读的累计佣金
  String get readableTotalCommission => (totalCommission / 100).toStringAsFixed(2);

  /// 获取第一个未使用的邀请码
  String get firstUnusedCode {
    final unusedCode = codes.where((code) => !code.isUsed).firstOrNull;
    return unusedCode?.code ?? '';
  }
  
  /// 获取所有未使用的邀请码
  List<InviteModel> get unusedCodes {
    return codes.where((code) => !code.isUsed).toList();
  }
  
  /// 是否有未使用的邀请码
  bool get hasUnusedCode => unusedCodes.isNotEmpty;
}