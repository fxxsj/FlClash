// 导出board相关模块
export 'api/api.dart'; 
export 'models/models.dart';
export 'constants/constants.dart';
export 'states/auth_state.dart';
export 'states/user_state.dart';
export 'providers/providers.dart'; // Riverpod Providers
export 'riverpod_setup.dart'; // Riverpod 设置
export 'utils/utils.dart';
export 'views/index.dart'; // 导出views模块 

// 导出新的配置模块
export 'config/config_manager.dart';
export 'config/app_configuration.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/config_manager.dart';

/// 初始化 Board 模块（简化版）
Future<void> initializeBoard(ProviderContainer container) async {
  if (kDebugMode) {
    debugPrint('Board模块开始初始化...');
  }
  
  try {
    // 使用新的配置管理器
    await configManager.initialize();
    
    // 更新Riverpod状态
    await configManager.updateRiverpodState(container);
    
    if (kDebugMode) {
      debugPrint('Board模块初始化完成');
      debugPrint('当前配置: ${configManager.currentConfig}');
    }
  } catch (e) {
    if (kDebugMode) {
      debugPrint('Board模块初始化失败: $e');
    }
    
    // 即使配置初始化失败，也要确保基本功能可用
    // 配置管理器会自动使用安全的降级配置
  }
}
