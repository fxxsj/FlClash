import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/v2board_api.dart';
import '../api/api_exception.dart';
import '../utils/storage.dart';
import '../models/user.dart';

// 定义 AuthState 的状态数据类
class AuthStateData {
  final UserModel? user;
  final String? appDescription;
  final String? appUrl;
  final bool isLoading;
  final bool isSendingCode;
  final String? error;
  final bool isEmailVerifyEnabled;
  final bool isInviteForce;
  final List<String> emailWhitelist;

  AuthStateData({
    this.user,
    this.appDescription,
    this.appUrl,
    this.isLoading = false,
    this.isSendingCode = false,
    this.error,
    this.isEmailVerifyEnabled = false,
    this.isInviteForce = false,
    this.emailWhitelist = const [],
  });

  bool get isAuthenticated => user != null;

  // 创建一个新的状态实例
  AuthStateData copyWith({
    UserModel? user,
    String? appDescription,
    String? appUrl,
    bool? isLoading,
    bool? isSendingCode,
    String? error,
    bool? isEmailVerifyEnabled,
    bool? isInviteForce,
    List<String>? emailWhitelist,
    bool clearError = false, // 新增参数用于明确清除错误
  }) {
    return AuthStateData(
      user: user ?? this.user,
      appDescription: appDescription ?? this.appDescription,
      appUrl: appUrl ?? this.appUrl,
      isLoading: isLoading ?? this.isLoading,
      isSendingCode: isSendingCode ?? this.isSendingCode,
      error: clearError ? null : (error ?? this.error),
      isEmailVerifyEnabled: isEmailVerifyEnabled ?? this.isEmailVerifyEnabled,
      isInviteForce: isInviteForce ?? this.isInviteForce,
      emailWhitelist: emailWhitelist ?? this.emailWhitelist,
    );
  }
}

class AuthState extends StateNotifier<AuthStateData> {
  final V2BoardApi _api;
  final AuthStorage _storage;

  V2BoardApi get api => _api;

  AuthState(this._api, this._storage)
      : super(AuthStateData());

  /// 提取用户友好的错误信息
  String _extractErrorMessage(dynamic error) {
    if (error is ApiException) {
      return error.message;
    } else if (error is Exception) {
      return ApiException.getUserFriendlyMessage(error);
    } else {
      return error.toString();
    }
  }

  /// 清除错误信息
  void clearError() {
    if (state.error != null) {
      state = state.copyWith(clearError: true);
    }
  }

  Future<void> init() async {
    state = state.copyWith(isLoading: true);

    try {
      if (state.appDescription == null) {
        await _loadConfig();
      }

      if (_storage.token != null) {
        await _fetchUserInfo();
      }
    } catch (e) {
      if (kDebugMode) debugPrint('Init Error: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> login(String email, String password, {String? recaptchaData}) async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    try {
      final loginResponse = await _api.login(email, password, recaptchaData);
      
      // V2Board API返回两种令牌：
      // 1. auth_data: JWT格式令牌，这是我们应该优先使用的
      // 2. token: 简单令牌，作为备选
      String token;
      if (loginResponse['auth_data'] != null && loginResponse['auth_data'].toString().trim().isNotEmpty) {
        token = loginResponse['auth_data'].toString().trim();
        if (kDebugMode) {
          debugPrint('使用JWT令牌(auth_data)进行认证');
        }
      } else if (loginResponse['token'] != null && loginResponse['token'].toString().trim().isNotEmpty) {
        token = loginResponse['token'].toString().trim();
        if (kDebugMode) {
          debugPrint('使用简单令牌(token)进行认证');
        }
      } else {
        throw Exception('服务器未返回有效的认证令牌');
      }
      
      // 保存令牌，不需要添加Bearer前缀，因为ApiClient会处理
      await _storage.saveAuth(token, email);
      
      if (kDebugMode) {
        debugPrint('登录成功，令牌已保存');
        // 不打印完整令牌，避免安全问题
        debugPrint('令牌前30字符: ${token.substring(0, token.length > 30 ? 30 : token.length)}...');
      }
      
      // 获取用户信息，确保使用相同的域名
      final user = await _api.getUserInfo();
      state = state.copyWith(user: user, isLoading: false, clearError: true);
    } catch (e) {
      state = state.copyWith(error: _extractErrorMessage(e), isLoading: false);
      rethrow;
    }
  }

  Future<void> register(
    String email,
    String password, {
    String? inviteCode,
    String? emailCode,
    String? recaptchaData,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _api.register(
        email,
        password,
        emailCode,
        inviteCode,
        recaptchaData,
      );

      // 注册成功后登录
      await login(email, password, recaptchaData: recaptchaData);
    } catch (e) {
      state = state.copyWith(error: _extractErrorMessage(e));
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> sendEmailVerify(String email) async {
    state = state.copyWith(isSendingCode: true, clearError: true);

    try {
      await _api.sendEmailVerify(email);
    } catch (e) {
      state = state.copyWith(error: _extractErrorMessage(e));
      rethrow;
    } finally {
      state = state.copyWith(isSendingCode: false);
    }
  }

  Future<void> resetPassword(
      String email, String emailCode, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _api.resetPassword(email, emailCode, password);
      await logout();
    } catch (e) {
      state = state.copyWith(error: _extractErrorMessage(e));
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);

    try {
      await _storage.clearAuth();
      state = state.copyWith(user: null, clearError: true);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _fetchUserInfo() async {
    try {
      final user = await _api.getUserInfo();
      state = state.copyWith(user: user);
    } catch (e) {
      await _storage.clearAuth();
      state = state.copyWith(user: null);
    }
  }

  Future<void> _loadConfig() async {
    try {
      final config = await _api.getConfig();
      state = state.copyWith(
        appDescription: config.appDescription,
        appUrl: config.appUrl,
        isEmailVerifyEnabled: config.isEmailVerify,
        isInviteForce: config.isInviteForce,
        emailWhitelist: config.emailWhitelistSuffix ?? [],
      );
    } catch (e) {
      if (kDebugMode) debugPrint('Load config error: $e');
    }
  }

  /// 直接更新配置数据
  Future<void> updateConfig(Map<String, dynamic> configData) async {
    try {
      if (kDebugMode) {
        debugPrint('直接更新 AuthState 配置');
        debugPrint('配置数据: $configData');
      }
      
      // 安全处理邮箱白名单后缀
      List<String>? emailWhitelist;
      final rawWhitelist = configData['email_whitelist_suffix'];
      
      if (rawWhitelist is List) {
        emailWhitelist = List<String>.from(
          rawWhitelist.map((e) => e.toString())
        );
      } else if (rawWhitelist is int && rawWhitelist == 0) {
        emailWhitelist = [];
      }
      
      state = state.copyWith(
        appDescription: configData['app_description']?.toString(),
        appUrl: configData['app_url']?.toString(),
        isEmailVerifyEnabled: configData['is_email_verify'] == 1,
        isInviteForce: configData['is_invite_force'] == 1,
        emailWhitelist: emailWhitelist ?? [],
      );
      
      if (kDebugMode) debugPrint('AuthState 配置更新完成');
    } catch (e) {
      if (kDebugMode) debugPrint('更新 AuthState 配置失败: $e');
    }
  }
  
  /// 直接更新用户信息，不影响加载状态
  void updateUser(UserModel user) {
    state = state.copyWith(user: user, clearError: true);
    if (kDebugMode) debugPrint('用户信息已更新');
  }
}