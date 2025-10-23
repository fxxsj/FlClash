import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/views/user_center/notices/notice_list.dart';
import 'package:fl_clash/board/views/user_center/components/connection_status.dart';

// 固定的用户中心组件列表
const List<UserCenterWidgetType> fixedUserCenterWidgets = [
  UserCenterWidgetType.noticeList,
  UserCenterWidgetType.connectionStatus,
];

/// 用户中心状态数据
class UserCenterStateData {
  final List<UserCenterWidgetType> userCenterWidgets;
  final double viewWidth;

  const UserCenterStateData({
    required this.userCenterWidgets,
    this.viewWidth = 0,
  });
}

/// 用户中心状态管理器
class UserCenterNotifier extends StateNotifier<UserCenterStateData> {
  UserCenterNotifier() : super(const UserCenterStateData(
    userCenterWidgets: fixedUserCenterWidgets,
  ));

  // 更新视图宽度
  void updateViewWidth(double width) {
    state = UserCenterStateData(
      userCenterWidgets: state.userCenterWidgets,
      viewWidth: width,
    );
  }
}

// 用户中心组件映射
GridItem getUserCenterWidget(UserCenterWidgetType type) {
  switch (type) {
    case UserCenterWidgetType.noticeList:
      return GridItem(
        crossAxisCellCount: 8,
        child: NoticeList(),
      );
    case UserCenterWidgetType.connectionStatus:
      return GridItem(
        crossAxisCellCount: 8,
        mainAxisCellCount: 3, // 给连接组件分配3个主轴单元格，让它占用更多垂直空间
        child: ConnectionStatus(),
      );
  }
} 