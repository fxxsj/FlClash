import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/v2board_api.dart';
import '../models/notice.dart';
import '../models/user.dart';
import '../models/order.dart';
import 'package:fl_clash/state.dart';

// 用户状态数据类
class UserStateData {
  final UserModel? user;
  final Map<String, dynamic>? subscribe;
  final bool isLoading;
  final String? error;
  final bool isRefreshing;
  final List<NoticeModel> notices;
  final bool isRefreshingNotices;
  final List<OrderModel> unpaidOrders;

  UserStateData({
    this.user,
    this.subscribe,
    this.isLoading = false,
    this.error,
    this.isRefreshing = false,
    this.notices = const [],
    this.isRefreshingNotices = false,
    this.unpaidOrders = const [],
  });

  bool get isLoggedIn => user != null;

  // 创建状态的新实例
  UserStateData copyWith({
    UserModel? user,
    Map<String, dynamic>? subscribe,
    bool? isLoading,
    String? error,
    bool? isRefreshing,
    List<NoticeModel>? notices,
    bool? isRefreshingNotices,
    List<OrderModel>? unpaidOrders,
  }) {
    return UserStateData(
      user: user ?? this.user,
      subscribe: subscribe ?? this.subscribe,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      notices: notices ?? this.notices,
      isRefreshingNotices: isRefreshingNotices ?? this.isRefreshingNotices,
      unpaidOrders: unpaidOrders ?? this.unpaidOrders,
    );
  }
}

class UserState extends StateNotifier<UserStateData> {
  final V2BoardApi _api;

  UserState(this._api) : super(UserStateData());

  Future<void> init() async {
    state = state.copyWith(
      user: null,
      subscribe: null,
      error: null,
      isLoading: true,
    );

    try {
      await _refreshUserInfo();
      await _refreshSubscribe();
      await fetchNotices();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _refreshUserInfo() async {
    try {
      final user = await _api.getUserInfo();
      state = state.copyWith(user: user);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> _refreshSubscribe() async {
    try {
      final response = await _api.getSubscribe();
      state = state.copyWith(subscribe: response);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);

    try {
      // 清除所有状态
      state = state.copyWith(
        user: null,
        subscribe: null,
        error: null,
        unpaidOrders: const [], // 确保清除未支付订单列表
        notices: const [], // 同时清除通知列表
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> refresh() async {
    if (state.isRefreshing) return;

    try {
      state = state.copyWith(isRefreshing: true);
      await _refreshUserInfo();
      await _refreshSubscribe();
    } finally {
      state = state.copyWith(isRefreshing: false);
    }
  }

  Future<Map<String, dynamic>?> getSubscribeInfo() async {
    try {
      final response = await _api.getSubscribe();
      return {
        'url': response['subscribe_url'],
        'token': response['token'],
        ...response, // 保留其他信息以备用
      };
    } catch (e) {
      return null;
    }
  }

  Future<void> fetchNotices() async {
    if (state.isRefreshingNotices) return;

    try {
      state = state.copyWith(isRefreshingNotices: true);

      final response = await _api.getNotices();
      state = state.copyWith(notices: response);

      // 检查是否有需要弹窗显示的通知
      for (final notice in response) {
        final tags = notice.tags;
        if (tags != null && tags.contains('弹窗')) {
          globalState.showMessage(
            title: notice.title,
            message: TextSpan(text: notice.content ?? ''),
          );
        }
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isRefreshingNotices: false);
    }
  }

  Future<void> checkUnpaidOrders() async {
    try {
      final orders = await _api.getUnpaidOrders();
      state = state.copyWith(unpaidOrders: orders);
    } catch (e) {
      final errorMsg = '获取未支付订单失败: ${e.toString()}';
      state = state.copyWith(error: errorMsg);
      debugPrint(errorMsg);
    }
  }

  // 更新用户信息
  Future<void> updateUserInfo({
    bool? remindExpire,
    bool? remindTraffic,
  }) async {
    try {
      await _api.updateUserInfo(
        remindExpire: remindExpire,
        remindTraffic: remindTraffic,
      );
      
      // 更新成功后刷新用户信息
      await _refreshUserInfo();
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow; // 重新抛出异常以便UI层处理
    }
  }

  // 修改密码
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await _api.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow; // 重新抛出异常以便UI层处理
    }
  }
}
