import 'package:dio/dio.dart';
import '../models/models.dart';
import 'api_client.dart';
import 'api_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:fl_clash/common/error_handler.dart';

class V2BoardApi {
  final ApiClient _client;

  V2BoardApi(this._client);

  ApiClient get client => _client;

  // 通用响应处理方法
  T _handleResponse<T>(
      Response response, String errorMessage, T Function(dynamic) fromJson) {
    if (response.data is Map) {
      final data = response.data as Map<String, dynamic>;
      if (data['data'] != null) {
        return fromJson(data['data']);
      }
      throw ApiException(message: data['message'] ?? errorMessage);
    }
    throw ApiException(message: '响应格式错误');
  }

  // 处理列表响应
  List<T> _handleListResponse<T>(Response response, String errorMessage,
      T Function(Map<String, dynamic>) fromJson) {
    if (response.data is Map) {
      final data = response.data as Map<String, dynamic>;
      if (data['data'] != null) {
        if (data['data'] is List) {
          final list = data['data'] as List;
          return list
              .whereType<Map<String, dynamic>>()
              .map((item) => fromJson(item))
              .toList();
        }
      }
      throw ApiException(message: data['message'] ?? errorMessage);
    }
    throw ApiException(message: '响应格式错误');
  }

  // 处理空响应
  void _handleEmptyResponse(Response response, String errorMessage) {
    if (response.data is Map) {
      final data = response.data as Map<String, dynamic>;
      if (data['data'] == true) {
        return;
      }
      throw ApiException(message: data['message'] ?? errorMessage);
    }
    throw ApiException(message: '响应格式错误');
  }

  // Passport 模块
  Future<ConfigModel> getConfig() async {
    try {
      if (kDebugMode) {
        debugPrint('[FlClash] 开始执行 getConfig 请求');
      }

      final response = await _client.safeGet('/guest/comm/config');

      if (kDebugMode) {
        debugPrint('[FlClash] 得到响应：${response.statusCode}');
        debugPrint('[FlClash] 响应数据类型: ${response.data.runtimeType}');
      }

      if (response.data is Map) {
        final responseMap = response.data as Map<String, dynamic>;
        if (responseMap['data'] != null && responseMap['data'] is Map) {
          final configData = responseMap['data'] as Map<String, dynamic>;

          // 预处理 email_whitelist_suffix 字段，确保正确的类型
          final emailWhitelist = configData['email_whitelist_suffix'];
          List<String>? emailWhitelistSuffix;

          // 处理可能的类型情况
          if (emailWhitelist is List) {
            emailWhitelistSuffix = List<String>.from(
              emailWhitelist.map((e) => e.toString())
            );
          } else if (emailWhitelist is int && emailWhitelist == 0) {
            emailWhitelistSuffix = [];
          }

          final configModel = ConfigModel(
            tosUrl: configData['tos_url']?.toString(),
            isEmailVerify: configData['is_email_verify'] == 1,
            isInviteForce: configData['is_invite_force'] == 1,
            emailWhitelistSuffix: emailWhitelistSuffix,
            isRecaptcha: configData['is_recaptcha'] == 1,
            recaptchaSiteKey: configData['recaptcha_site_key']?.toString(),
            appDescription: configData['app_description']?.toString(),
            appUrl: configData['app_url']?.toString(),
            logo: configData['logo']?.toString(),
          );

          return configModel;
        }
        throw ApiException(message: '无效的配置数据结构');
      }
      throw ApiException(message: '无效的响应数据格式');
    } catch (error) {
      if (kDebugMode) {
        debugPrint('[FlClash] getConfig 错误: $error');
      }
      if (error is Exception) {
        throw AppError.fromException(error);
      }
      throw AppError(
        type: AppErrorType.unknown,
        severity: ErrorSeverity.medium,
        code: 'CONFIG_ERROR',
        originalMessage: error.toString(),
        userMessage: '获取配置信息失败，请稍后重试',
      );
    }
  }

  Future<Map<String, dynamic>> login(
      String email, String password, String? recaptchaData) async {
    try {
      final Map<String, dynamic> data = {
        'email': email,
        'password': password,
      };

      if (recaptchaData != null) {
        data['recaptcha_data'] = recaptchaData;
      }

      final response = await _client.safePost(
        '/passport/auth/login', 
        data: data,
      );

      if (response.data is Map) {
        final data = response.data as Map<String, dynamic>;
        
        if (data.containsKey('message') && response.statusCode != 200) {
          throw ApiException(message: data['message'] as String);
        }
        
        if (data['data'] != null && data['data'] is Map) {
          return data['data'] as Map<String, dynamic>;
        }
        throw ApiException(message: data['message'] ?? '登录失败');
      }
      throw ApiException(message: '响应格式错误');
    } catch (e) {
      if (kDebugMode) {
        debugPrint('登录错误详情: $e');
        debugPrint('错误类型: ${e.runtimeType}');
      }
      
      // 直接抛出原始错误，保持错误信息
      if (e is DioException) {
        // 如果是DioException，包装成ApiException
        throw ApiException.fromDioException(e);
      } else if (e is ApiException) {
        rethrow;
      } else {
        throw ApiException(message: '登录失败: $e');
      }
    }
  }

  Future<void> register(String email, String password, String? emailCode,
      String? inviteCode, String? recaptchaData) async {
    try {
      final Map<String, dynamic> data = {
        'email': email,
        'password': password,
      };

      if (emailCode != null) {
        data['email_code'] = emailCode;
      }

      if (inviteCode != null) {
        data['invite_code'] = inviteCode;
      }

      if (recaptchaData != null) {
        data['recaptcha_data'] = recaptchaData;
      }

      final response = await _client.safePost(
        '/passport/auth/register', 
        data: data
      );

      _handleEmptyResponse(response, '注册失败');
    } on DioException catch (e) {
      throw AppError.fromException(ApiException.fromDioException(e));
    } catch (e) {
      if (e is ApiException) {
        throw AppError.fromException(e);
      }
      throw AppError(
        type: AppErrorType.auth,
        severity: ErrorSeverity.high,
        code: 'AUTH_REGISTER_ERROR',
        originalMessage: e.toString(),
        userMessage: '注册失败，请检查输入信息',
      );
    }
  }

  Future<void> resetPassword(
      String email, String emailCode, String password) async {
    try {
      final response = await _client.safePost(
        '/passport/auth/forget', 
        data: {
          'email': email,
          'email_code': emailCode,
          'password': password,
        }
      );

      _handleEmptyResponse(response, '重置密码失败');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '重置密码失败: $e');
    }
  }

  Future<void> sendEmailVerify(String email) async {
    try {
      final response = await _client.safePost(
        '/passport/comm/sendEmailVerify',
        data: {'email': email}
      );

      _handleEmptyResponse(response, '发送验证码失败');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '发送验证码失败: $e');
    }
  }

  Future<bool> checkAuth() async {
    try {
      final response = await _client.safeGet('/passport/auth/check');

      if (response.data is Map) {
        final data = response.data as Map<String, dynamic>;
        return data['data'] == true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // User 模块
  Future<UserModel> getUserInfo() async {
    try {
      final response = await _client.safeGet('/user/info');
      return _handleResponse(response, '获取用户信息失败', (data) => UserModel.fromJson(data));
    } on DioException catch (e) {
      throw AppError.fromException(ApiException.fromDioException(e));
    } catch (e) {
      if (e is ApiException) {
        throw AppError.fromException(e);
      }
      throw AppError(
        type: AppErrorType.network,
        severity: ErrorSeverity.medium,
        code: 'USER_INFO_ERROR',
        originalMessage: e.toString(),
        userMessage: '获取用户信息失败，请刷新重试',
      );
    }
  }

  // 更新用户信息
  Future<void> updateUserInfo({
    bool? remindExpire,
    bool? remindTraffic,
  }) async {
    try {
      final Map<String, dynamic> data = {};
      
      if (remindExpire != null) {
        data['remind_expire'] = remindExpire ? 1 : 0;
      }
      
      if (remindTraffic != null) {
        data['remind_traffic'] = remindTraffic ? 1 : 0;
      }

      final response = await _client.safePost('/user/update', data: data);
      _handleEmptyResponse(response, '更新用户信息失败');
    } on DioException catch (e) {
      throw AppError.fromException(ApiException.fromDioException(e));
    } catch (e) {
      if (e is ApiException) {
        throw AppError.fromException(e);
      }
      throw AppError(
        type: AppErrorType.network,
        severity: ErrorSeverity.medium,
        code: 'USER_UPDATE_ERROR',
        originalMessage: e.toString(),
        userMessage: '更新用户信息失败，请稍后重试',
      );
    }
  }

  // 修改密码
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'old_password': oldPassword,
        'new_password': newPassword,
      };

      final response = await _client.safePost('/user/changePassword', data: data);
      _handleEmptyResponse(response, '修改密码失败');
    } on DioException catch (e) {
      throw AppError.fromException(ApiException.fromDioException(e));
    } catch (e) {
      if (e is ApiException) {
        throw AppError.fromException(e);
      }
      throw AppError(
        type: AppErrorType.network,
        severity: ErrorSeverity.medium,
        code: 'PASSWORD_CHANGE_ERROR',
        originalMessage: e.toString(),
        userMessage: '修改密码失败，请稍后重试',
      );
    }
  }

  Future<Map<String, dynamic>> getSubscribe() async {
    try {
      final response = await _client.safeGet('/user/getSubscribe');

      if (response.data is Map) {
        final data = response.data as Map<String, dynamic>;
        if (data['data'] != null) {
          return data['data'] as Map<String, dynamic>;
        }
        throw ApiException(message: data['message'] ?? '获取订阅信息失败');
      }
      throw ApiException(message: '响应格式错误');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '获取订阅信息失败: $e');
    }
  }

  // 统计信息
  Future<Map<String, dynamic>> getStatistics() async {
    try {
      final response = await _client.safeGet('/user/getStat');

      if (response.data is Map) {
        final data = response.data as Map<String, dynamic>;
        if (data['data'] != null) {
          return data['data'] as Map<String, dynamic>;
        }
        throw ApiException(message: data['message'] ?? '获取统计信息失败');
      }
      throw ApiException(message: '响应格式错误');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '获取统计信息失败: $e');
    }
  }

  // Plan 模块
  Future<List<PlanModel>> getPlans() async {
    try {
      final response = await _client.safeGet('/user/plan/fetch');
      return _handleListResponse(response, '获取订阅计划失败', (data) => PlanModel.fromJson(data));
    } on DioException catch (e) {
      throw AppError.fromException(ApiException.fromDioException(e));
    } catch (e) {
      if (e is ApiException) {
        throw AppError.fromException(e);
      }
      throw AppError(
        type: AppErrorType.subscription,
        severity: ErrorSeverity.medium,
        code: 'PLANS_FETCH_ERROR',
        originalMessage: e.toString(),
        userMessage: '获取订阅计划失败，请刷新重试',
      );
    }
  }

  // Order 模块
  Future<List<OrderModel>> getOrders({int? status}) async {
    try {
      final response = await _client.safeGet('/user/order/fetch',
          queryParameters: status != null ? {'status': status} : null);
      return _handleListResponse(response, '获取订单列表失败', (data) => OrderModel.fromJson(data));
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '获取订单列表失败: $e');
    }
  }

  Future<List<OrderModel>> getUnpaidOrders() async {
    try {
      final response = await _client.safeGet('/user/order/fetch', queryParameters: {'status': 0});
      return _handleListResponse(response, '获取未支付订单失败', (data) => OrderModel.fromJson(data));
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '获取未支付订单失败: $e');
    }
  }

  Future<OrderModel> getOrderDetail(String tradeNo) async {
    try {
      final response = await _client.safeGet('/user/order/detail', queryParameters: {'trade_no': tradeNo});
      return _handleResponse(response, '获取订单详情失败', (data) => OrderModel.fromJson(data));
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '获取订单详情失败: $e');
    }
  }

  Future<String> createOrder(int planId, String period,
      {String? couponCode, int? depositAmount}) async {
    try {
      final Map<String, dynamic> data = {
        'plan_id': planId,
        'period': period,
      };

      if (couponCode != null && couponCode.isNotEmpty) {
        data['coupon_code'] = couponCode;
      }

      if (planId == 0 && depositAmount != null) {
        data['deposit_amount'] = depositAmount;
      }

      final response = await _client.safePost('/user/order/save', data: data);

      if (response.data is Map) {
        final data = response.data as Map<String, dynamic>;
        if (data['data'] != null) {
          return data['data'].toString();
        }
        throw ApiException(message: data['message'] ?? '创建订单失败');
      }
      throw ApiException(message: '响应格式错误');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '创建订单失败: $e');
    }
  }

  Future<void> cancelOrder(String tradeNo) async {
    try {
      final response = await _client.safePost('/user/order/cancel', data: {
        'trade_no': tradeNo,
      });

      _handleEmptyResponse(response, '取消订单失败');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '取消订单失败: $e');
    }
  }

  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    try {
      final response = await _client.safeGet('/user/order/getPaymentMethod');
      return _handleListResponse(response, '获取支付方式失败', (data) => PaymentMethodModel.fromJson(data));
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '获取支付方式失败: $e');
    }
  }

  Future<Map<String, dynamic>> getPaymentUrl(String tradeNo,
      {required int methodId, String? stripeToken}) async {
    try {
      final Map<String, dynamic> data = {
        'trade_no': tradeNo,
        'method': methodId,
      };

      if (stripeToken != null) {
        data['token'] = stripeToken;
      }

      final response = await _client.safePost('/user/order/checkout', data: data);

      if (response.data is Map) {
        final data = response.data as Map<String, dynamic>;
        if (data['type'] != null && data['data'] != null) {
          return {'type': data['type'], 'data': data['data']};
        }
        throw ApiException(message: data['message'] ?? '获取支付链接失败');
      }
      throw ApiException(message: '响应格式错误');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '获取支付链接失败: $e');
    }
  }

  Future<int> checkOrderStatus(String tradeNo) async {
    try {
      final response = await _client.safeGet('/user/order/check', queryParameters: {'trade_no': tradeNo});
      return _handleResponse(response, '检查订单状态失败', (data) => data as int);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '检查订单状态失败: $e');
    }
  }

  // Notice 模块
  Future<List<NoticeModel>> getNotices({int current = 1}) async {
    try {
      final response = await _client.safeGet('/user/notice/fetch', queryParameters: {'current': current});
      return _handleListResponse(response, '获取公告列表失败', (data) => NoticeModel.fromJson(data));
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '获取公告列表失败: $e');
    }
  }

  // Coupon 模块
  Future<Map<String, dynamic>> checkCoupon(int planId, String code) async {
    try {
      final response = await _client.safePost('/user/coupon/check', data: {
        'plan_id': planId,
        'code': code,
      });

      return _handleResponse(response, '优惠券无效', (data) => data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '验证优惠券失败: $e');
    }
  }

  // Quick Login 模块
  Future<String?> getQuickLoginUrl() async {
    try {
      final response = await _client.safePost('/passport/auth/getQuickLoginUrl');

      if (response.data is Map) {
        return response.data['data'] as String?;
      } else if (response.data is String) {
        return response.data;
      }

      throw ApiException(message: '获取快速登录链接失败: 响应格式错误');
    } catch (e) {
      throw ApiException(message: '获取快速登录链接失败: ${e.toString()}');
    }
  }

  // Invite 模块
  Future<Map<String, dynamic>> getInviteInfo() async {
    try {
      final response = await _client.safeGet('/user/invite/fetch');

      if (response.data is Map) {
        final data = response.data as Map<String, dynamic>;
        if (data['data'] != null) {
          return data['data'];
        }
        throw ApiException(message: data['message'] ?? '获取邀请信息失败');
      }
      throw ApiException(message: '响应格式错误');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '获取邀请信息失败: $e');
    }
  }

  Future<void> generateInviteCode() async {
    try {
      final response = await _client.safeGet('/user/invite/save');

      if (response.data is Map) {
        final data = response.data as Map<String, dynamic>;
        if (data['data'] == true) {
          return;
        }
        throw ApiException(message: data['message'] ?? '生成邀请码失败');
      }
      throw ApiException(message: '响应格式错误');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '生成邀请码失败: $e');
    }
  }

  Future<List<InviteDetailModel>> getInviteDetails() async {
    try {
      final response = await _client.safeGet('/user/invite/details');
      return _handleListResponse(response, '获取邀请详情记录失败', (data) => InviteDetailModel.fromJson(data));
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '获取邀请详情记录失败: $e');
    }
  }

  // Commission 模块
  Future<void> transferCommission(double amount) async {
    try {
      // 将元转换为分（乘以100并转换为整数）
      final amountInCents = (amount * 100).round();
      
      final response = await _client.safePost('/user/transfer', data: {
        'transfer_amount': amountInCents,
      });

      if (response.data is Map) {
        final data = response.data as Map<String, dynamic>;
        // 成功时后端返回 {data: true}
        if (data['data'] == true || data['data'] == null) {
          return; // 成功
        }
        throw ApiException(message: data['message'] ?? '佣金划转失败');
      }
      throw ApiException(message: '响应格式错误');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '佣金划转失败: $e');
    }
  }

  Future<void> withdrawCommission({
    required String withdrawMethod,
    required String withdrawAccount,
  }) async {
    try {
      final response = await _client.safePost('/user/ticket/withdraw', data: {
        'withdraw_method': withdrawMethod,
        'withdraw_account': withdrawAccount,
      });

      if (response.data is Map) {
        final data = response.data as Map<String, dynamic>;
        if (data['data'] == null) {
          return; // 成功
        }
        throw ApiException(message: data['message'] ?? '申请提现失败');
      }
      throw ApiException(message: '响应格式错误');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '申请提现失败: $e');
    }
  }

  Future<Map<String, dynamic>> getUserConfig() async {
    try {
      final response = await _client.safeGet('/user/comm/config');

      if (response.data is Map) {
        final data = response.data as Map<String, dynamic>;
        if (data['data'] != null) {
          return data['data'];
        }
        throw ApiException(message: data['message'] ?? '获取用户配置失败');
      }
      throw ApiException(message: '响应格式错误');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '获取用户配置失败: $e');
    }
  }

  // Ticket 模块
  Future<List<TicketModel>> getTickets() async {
    try {
      final response = await _client.safeGet('/user/ticket/fetch');
      return _handleListResponse(response, '获取工单列表失败', (data) => TicketModel.fromJson(data));
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '获取工单列表失败: $e');
    }
  }

  Future<TicketModel> getTicketDetail(int ticketId) async {
    try {
      final response = await _client.dio
          .get('/user/ticket/fetch', queryParameters: {'id': ticketId});
      
      // 添加调试日志
      debugPrint('工单详情原始数据: ${response.data}');
      if (response.data is Map) {
        final data = response.data as Map<String, dynamic>;
        if (data['data'] != null) {
          debugPrint('工单数据: ${data['data']}');
        }
      }
      
      return _handleResponse(response, '获取工单详情失败', (data) => TicketModel.fromJson(data));
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '获取工单详情失败: $e');
    }
  }

  Future<void> replyTicket(int ticketId, String message) async {
    try {
      await _client.safePost('/user/ticket/reply', data: {
        'id': ticketId,
        'message': message,
      });
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '回复工单失败: $e');
    }
  }

  Future<void> closeTicket(int ticketId) async {
    try {
      await _client.safePost('/user/ticket/close', data: {
        'id': ticketId,
      });
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '关闭工单失败: $e');
    }
  }

  Future<void> createTicket(String subject, int level, String message) async {
    try {
      final response = await _client.safePost('/user/ticket/save', data: {
        'subject': subject,
        'level': level,
        'message': message,
      });

      if (response.data is Map) {
        final data = response.data as Map<String, dynamic>;
        if (data['data'] == true) {
          return;
        }
        throw ApiException(message: data['message'] ?? '创建工单失败');
      }
      throw ApiException(message: '响应格式错误');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: '创建工单失败: $e');
    }
  }
}