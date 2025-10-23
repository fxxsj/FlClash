import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fl_clash/common/app_localizations.dart';
import 'package:fl_clash/common/common.dart';
import '../config/config_manager.dart';
import 'crypto_utils.dart';

/// API相关常量配置
class ApiConstants {
  // 私有构造函数，防止实例化
  ApiConstants._();

  /// 配置URL（加密）
  static const String _encryptedConfigUrl =
      '4fa61eaaeeb2acbd29b6b3174933a92f4ab92f14317fc50033da05a18ad115d32bb53b773aaa40d77728e42e94f792928c6b752029e3c4ee4eaa0832e3e888e126ee297f7ba05dcd3e79a46be5f69c9f81607e6f39f5c9b2';

  /// 解密后的配置URL
  static String get configUrl => CryptoUtils.decrypt(_encryptedConfigUrl);
  
  /// 验证安全标记
  static bool validateSecurityFlag(String? flag) {
    if (flag == null || flag.isEmpty) return false;
    return _encryptedConfigUrl.contains(flag);
  }
}

/// 应用配置管理类（向后兼容层）
/// 新代码建议直接使用 ConfigManager
class AppConfig {
  AppConfig._();

  /// 向后兼容的静态访问器
  static String get appTitle => configManager.currentConfig.appTitle;
  static String get baseUrl => configManager.currentConfig.baseUrl;
  static String get initialBaseUrl => configManager.currentConfig.baseUrl; // 向后兼容
  static String get apiVersion => configManager.currentConfig.apiVersion;
  static String get securityFlag => configManager.currentConfig.securityFlag;
  static String get appUpdateUrl => configManager.currentConfig.updateUrl;
  static String get appUpdateCheckUrl => configManager.currentConfig.updateCheckUrl;

  /// 更新配置（向后兼容）
  static Future<void> updateConfig(Map<String, dynamic> config) async {
    try {
      await configManager.updateConfig(config);
      
      if (kDebugMode) {
        debugPrint('配置更新完成（通过AppConfig兼容层）');
        debugPrint('当前配置: ${configManager.currentConfig}');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('配置更新失败: $e');
      }
      // 为了向后兼容，不抛出异常
    }
  }

  /// 显示错误对话框
  static Future<void> showConfigErrorDialog(dynamic error) async {
    final context = globalState.navigatorKey.currentContext;
    if (context != null) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(appLocalizations.tip),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(appLocalizations.confirm),
            ),
          ],
        ),
      );
    }
  }

  /// 获取完整的API URL
  static String get fullApiUrl => configManager.currentConfig.fullApiUrl;

  /// 检查配置是否有效
  static bool get isValid => configManager.currentConfig.isValid();

  /// 获取配置调试信息
  static String get debugInfo => configManager.currentConfig.debugInfo;
}
