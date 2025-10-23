import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_client.dart';
import '../api/v2board_api.dart';
import '../constants/app_config.dart';
import '../states/auth_state.dart';
import '../states/user_state.dart';
import '../states/user_center_state.dart';
import '../utils/storage.dart';
import '../models/config.dart';

// Base URL provider
final baseUrlProvider = StateProvider<String>((ref) => AppConfig.baseUrl);

// 存储提供者
final sharedPreferencesProvider = Provider<SharedPreferences>((_) {
  throw UnimplementedError('需要在使用前初始化 SharedPreferences');
});

// 认证存储提供者
final authStorageProvider = Provider<AuthStorage>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return AuthStorage(prefs);
});

// Api 客户端提供者
final apiClientProvider = Provider<ApiClient>((ref) {
  final storage = ref.watch(authStorageProvider);
  final baseUrl = ref.watch(baseUrlProvider);
  return ApiClient(storage, baseUrl);
});

// V2Board API 提供者
final v2boardApiProvider = Provider<V2BoardApi>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return V2BoardApi(apiClient);
});

// 认证状态提供者
final authStateProvider = StateNotifierProvider<AuthState, AuthStateData>((ref) {
  final api = ref.watch(v2boardApiProvider);
  final storage = ref.watch(authStorageProvider);
  return AuthState(api, storage)..init();
});

// 用户状态提供者
final userStateProvider = StateNotifierProvider<UserState, UserStateData>((ref) {
  final api = ref.watch(v2boardApiProvider);
  final authState = ref.watch(authStateProvider);
  
  final userState = UserState(api);
  if (authState.isAuthenticated) {
    userState.init();
  } else {
    userState.logout();
  }
  
  return userState;
});

// 用户中心状态提供者
final userCenterStateProvider = StateNotifierProvider<UserCenterNotifier, UserCenterStateData>((ref) {
  return UserCenterNotifier();
});

// 系统配置提供者
final systemConfigProvider = FutureProvider<ConfigModel>((ref) async {
  final api = ref.watch(v2boardApiProvider);
  return await api.getConfig();
});

// 初始化 Riverpod 提供者
Future<void> initializeProviders(ProviderContainer container) async {
  final prefs = await SharedPreferences.getInstance();
  container.updateOverrides([
    sharedPreferencesProvider.overrideWithValue(prefs),
  ]);
}