import 'base_model.dart';
import 'package:flutter/foundation.dart';

/// 工单级别
enum TicketLevel {
  /// 低级别
  low,
  /// 中级别
  medium,
  /// 高级别
  high,
  /// 紧急
  urgent,
}

/// 工单状态
enum TicketStatus {
  /// 待回复
  pending,
  /// 已回复
  replied,
  /// 已关闭
  closed,
}

/// 工单模型
class TicketModel extends BaseModel {
  /// 工单ID
  final int id;
  /// 工单主题
  final String subject;
  /// 工单级别
  final int level;
  /// 工单状态
  final int status;
  /// 工单最后回复时间
  final int? lastReplyAt;
  /// 工单创建时间
  final int createdAt;
  /// 工单更新时间
  final int updatedAt;
  /// 工单消息列表
  final List<TicketMessageModel>? messages;

  const TicketModel({
    required this.id,
    required this.subject,
    required this.level,
    required this.status,
    this.lastReplyAt,
    required this.createdAt,
    required this.updatedAt,
    this.messages,
  });

  /// 从JSON创建实例
  factory TicketModel.fromJson(Map<String, dynamic> json) {
    List<TicketMessageModel>? messagesList;

    // 适配message字段的不同格式
    if (json['message'] != null) {
      if (json['message'] is List) {
        // 如果message字段是一个列表，直接转换为TicketMessageModel列表
        messagesList = (json['message'] as List)
            .map((message) {
              if (message is Map<String, dynamic>) {
                return TicketMessageModel.fromJson(message);
              } else {
                debugPrint('工单消息格式异常: $message');
                return null;
              }
            })
            .whereType<TicketMessageModel>()
            .toList();
      } else if (json['message'] is Map) {
        // 如果message是一个Map，可能需要特殊处理
        debugPrint('工单消息是Map类型: ${json['message']}');
        // 这里可以根据实际情况处理
      } else {
        debugPrint('工单消息格式未知: ${json['message']}');
      }
    } else if (json['messages'] != null) {
      // 兼容messages字段
      if (json['messages'] is List) {
        messagesList = (json['messages'] as List)
            .map((message) {
              if (message is Map<String, dynamic>) {
                return TicketMessageModel.fromJson(message);
              } else {
                debugPrint('工单消息格式异常: $message');
                return null;
              }
            })
            .whereType<TicketMessageModel>()
            .toList();
      }
    }

    return TicketModel(
      id: json['id'] ?? 0,
      subject: json['subject'] ?? '',
      level: json['level'] ?? 0,
      status: json['status'] ?? 0,
      lastReplyAt: json['last_reply_at'],
      createdAt: json['created_at'] ?? 0,
      updatedAt: json['updated_at'] ?? 0,
      messages: messagesList,
    );
  }

  /// 创建一个空的工单实例
  factory TicketModel.empty() {
    return const TicketModel(
      id: 0,
      subject: '',
      level: 0,
      status: 0,
      createdAt: 0,
      updatedAt: 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'level': level,
      'status': status,
      'last_reply_at': lastReplyAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'messages': messages?.map((message) => message.toJson()).toList(),
    };
  }

  /// 创建一个新的实例，并可选地替换部分属性
  TicketModel copyWith({
    int? id,
    String? subject,
    int? level,
    int? status,
    int? lastReplyAt,
    int? createdAt,
    int? updatedAt,
    List<TicketMessageModel>? messages,
  }) {
    return TicketModel(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      level: level ?? this.level,
      status: status ?? this.status,
      lastReplyAt: lastReplyAt ?? this.lastReplyAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      messages: messages ?? this.messages,
    );
  }

  /// 获取工单级别名称
  String get levelName {
    switch (level) {
      case 1:
        return '低';
      case 2:
        return '中';
      case 3:
        return '高';
      case 4:
        return '紧急';
      default:
        return '未知';
    }
  }

  /// 获取工单状态名称
  String get statusName {
    if (status == 1) {
      return '已关闭';
    }
    
    // status == 0 表示未关闭，需要根据消息判断是已回复还是待回复
    return _getReplyStatus();
  }

  /// 根据消息记录判断回复状态
  String _getReplyStatus() {
    if (messages == null || messages!.isEmpty) {
      return '待回复';
    }
    
    // 获取最后一条消息
    final lastMessage = messages!.last;
    
    // 如果最后一条消息来自管理员（is_me为false），则表示已回复
    if (!lastMessage.isMe) {
      return '已回复';
    }
    
    // 如果最后一条消息来自用户（is_me为true），则表示待回复
    return '待回复';
  }

  /// 工单是否已关闭
  bool get isClosed => status == 1;
  
  /// 工单是否待回复（未关闭且最后一条消息来自用户）
  bool get isPending {
    if (status == 1) return false; // 已关闭的工单不算待回复
    if (messages == null || messages!.isEmpty) return true; // 没有消息则为待回复
    return messages!.last.isMe; // 最后一条消息来自用户则为待回复
  }
  
  /// 工单是否已回复（未关闭且最后一条消息来自管理员）
  bool get isReplied {
    if (status == 1) return false; // 已关闭的工单不算已回复
    if (messages == null || messages!.isEmpty) return false; // 没有消息则不是已回复
    return !messages!.last.isMe; // 最后一条消息来自管理员则为已回复
  }
}

/// 工单详情模型，包含完整的消息列表
class TicketDetailModel extends TicketModel {
  const TicketDetailModel({
    required super.id,
    required super.subject,
    required super.level,
    required super.status,
    super.lastReplyAt,
    required super.createdAt,
    required super.updatedAt,
    required List<TicketMessageModel> super.messages,
  });

  /// 从JSON创建实例
  factory TicketDetailModel.fromJson(Map<String, dynamic> json) {
    List<TicketMessageModel> messagesList = [];

    // 处理消息列表
    if (json['message'] != null && json['message'] is List) {
      messagesList = (json['message'] as List)
          .map((message) {
            if (message is Map<String, dynamic>) {
              return TicketMessageModel.fromJson(message);
            } else {
              debugPrint('工单消息格式异常: $message');
              return null;
            }
          })
          .whereType<TicketMessageModel>()
          .toList();
    } else if (json['messages'] != null && json['messages'] is List) {
      messagesList = (json['messages'] as List)
          .map((message) {
            if (message is Map<String, dynamic>) {
              return TicketMessageModel.fromJson(message);
            } else {
              debugPrint('工单消息格式异常: $message');
              return null;
            }
          })
          .whereType<TicketMessageModel>()
          .toList();
    }

    return TicketDetailModel(
      id: json['id'] ?? 0,
      subject: json['subject'] ?? '',
      level: json['level'] ?? 0,
      status: json['status'] ?? 0,
      lastReplyAt: json['last_reply_at'],
      createdAt: json['created_at'] ?? 0,
      updatedAt: json['updated_at'] ?? 0,
      messages: messagesList,
    );
  }

  /// 创建一个空的工单详情实例
  factory TicketDetailModel.empty() {
    return TicketDetailModel(
      id: 0,
      subject: '',
      level: 0,
      status: 0,
      createdAt: 0,
      updatedAt: 0,
      messages: [],
    );
  }
}

/// 工单消息模型
class TicketMessageModel extends BaseModel {
  /// 消息ID
  final int id;
  /// 工单ID
  final int ticketId;
  /// 用户ID
  final int? userId;
  /// 管理员ID
  final int? adminId;
  /// 消息内容
  final String message;
  /// 消息创建时间
  final int createdAt;
  /// 消息更新时间
  final int updatedAt;
  /// 是否是自己发送的消息
  final bool isMe;

  const TicketMessageModel({
    required this.id,
    required this.ticketId,
    this.userId,
    this.adminId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.isMe,
  });

  /// 从JSON创建实例
  factory TicketMessageModel.fromJson(Map<String, dynamic> json) {
    // 处理is_me字段，如果有就直接使用，没有则根据user_id和admin_id判断
    bool isMe = json['is_me'] == true;
    if (!json.containsKey('is_me')) {
      // 如果有user_id且没有admin_id，则认为是用户发送的消息
      isMe = json['user_id'] != null && json['admin_id'] == null;
    }
    
    return TicketMessageModel(
      id: json['id'] ?? 0,
      ticketId: json['ticket_id'] ?? 0,
      userId: json['user_id'],
      adminId: json['admin_id'],
      message: json['message'] ?? '',
      createdAt: json['created_at'] ?? 0,
      updatedAt: json['updated_at'] ?? 0,
      isMe: isMe,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ticket_id': ticketId,
      'user_id': userId,
      'admin_id': adminId,
      'message': message,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_me': isMe,
    };
  }

  /// 创建一个新的实例，并可选地替换部分属性
  TicketMessageModel copyWith({
    int? id,
    int? ticketId,
    int? userId,
    int? adminId,
    String? message,
    int? createdAt,
    int? updatedAt,
    bool? isMe,
  }) {
    return TicketMessageModel(
      id: id ?? this.id,
      ticketId: ticketId ?? this.ticketId,
      userId: userId ?? this.userId,
      adminId: adminId ?? this.adminId,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isMe: isMe ?? this.isMe,
    );
  }

  /// 消息是否来自管理员
  bool get isFromAdmin => adminId != null;
} 