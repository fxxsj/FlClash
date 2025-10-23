import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_clash/board/config/config.dart';

/// 配置系统测试
void main() {
  group('新配置系统测试', () {
    setUp(() async {
      // 设置测试环境
      SharedPreferences.setMockInitialValues({});
    });

    test('AppConfiguration 默认配置测试', () {
      final config = AppConfiguration.defaults();
      
      expect(config.appTitle, 'FlClash');
      expect(config.apiVersion, '/api/v1');
      expect(config.updateUrl, 'https://cloud.ziu.ooo/FxClash/');
      expect(config.updateCheckUrl, 'https://f005.backblazeb2.com/file/fx2025/app_latest_version.json');
      expect(config.version, 1);
    });

    test('AppConfiguration JSON 序列化测试', () {
      final config = AppConfiguration.defaults().copyWith(
        appTitle: 'Test App',
        baseUrl: 'https://example.com',
      );
      
      final json = config.toJson();
      final restored = AppConfiguration.fromJson(json);
      
      expect(restored.appTitle, config.appTitle);
      expect(restored.baseUrl, config.baseUrl);
      expect(restored.apiVersion, config.apiVersion);
    });

    test('AppConfiguration 验证测试', () {
      // 有效配置
      final validConfig = AppConfiguration(
        appTitle: 'Test',
        baseUrl: 'https://example.com',
        apiVersion: '/api/v1',
        updateUrl: 'https://update.com',
        updateCheckUrl: 'https://check.com',
        lastUpdated: DateTime.now(),
      );
      
      expect(validConfig.isValid(), true);
      expect(validConfig.validate(), isEmpty);
      
      // 无效配置
      final invalidConfig = AppConfiguration(
        appTitle: '',
        baseUrl: '',
        apiVersion: '',
        updateUrl: 'invalid-url',
        updateCheckUrl: 'invalid-url',
        lastUpdated: DateTime.now(),
      );
      
      expect(invalidConfig.isValid(), false);
      expect(invalidConfig.validate(), isNotEmpty);
    });

    test('AppConfiguration 合并测试', () {
      final config1 = AppConfiguration.defaults();
      final config2 = AppConfiguration(
        appTitle: 'New Title',
        baseUrl: 'https://new.com',
        apiVersion: '/api/v2',
        updateUrl: 'https://new-update.com',
        updateCheckUrl: 'https://new-check.com',
        version: 2,
        lastUpdated: DateTime.now(),
      );
      
      final merged = config1.merge(config2);
      
      expect(merged.appTitle, config2.appTitle);
      expect(merged.baseUrl, config2.baseUrl);
      expect(merged.apiVersion, config2.apiVersion);
      expect(merged.version, config2.version);
    });

    test('ConfigCache 缓存测试', () async {
      final config = AppConfiguration.defaults().copyWith(
        appTitle: 'Cached App',
        baseUrl: 'https://cached.com',
      );
      
      // 测试缓存
      await ConfigCache.cacheConfig(config);
      
      // 测试获取缓存
      final cached = await ConfigCache.getCachedConfig();
      expect(cached, isNotNull);
      expect(cached!.appTitle, config.appTitle);
      expect(cached.baseUrl, config.baseUrl);
      
      // 测试缓存信息
      final cacheInfo = await ConfigCache.getCacheInfo();
      expect(cacheInfo, isNotNull);
      expect(cacheInfo!['version'], config.version);
      
      // 测试清除缓存
      await ConfigCache.clearCache();
      final clearedCache = await ConfigCache.getCachedConfig();
      expect(clearedCache, isNull);
    });

    test('ConfigErrorHandler 错误处理测试', () async {
      final fallbackConfig = AppConfiguration.defaults();
      
      // 测试网络错误处理
      final networkError = Exception('网络连接失败');
      final recoveredConfig = await ConfigErrorHandler.handleConfigError(
        networkError, 
        fallbackConfig,
      );
      
      expect(recoveredConfig, isNotNull);
      expect(recoveredConfig.isValid(), true);
      
      // 测试健康检查
      final health = await ConfigErrorHandler.checkConfigHealth();
      expect(health, isNotNull);
      expect(health['timestamp'], isNotNull);
      expect(health['cache'], isNotNull);
    });

    test('ConfigManager 初始化测试', () async {
      final configManager = ConfigManager.instance;
      
      // 测试初始化
      await configManager.initialize();
      
      expect(configManager.currentConfig, isNotNull);
      expect(configManager.currentConfig.isValid(), true);
      expect(configManager.isLoading, false);
      
      // 测试配置更新
      final newConfigData = {
        'appTitle': 'Updated Title',
        'baseUrl': 'https://updated.com',
        'apiVersion': '/api/v2',
      };
      
      await configManager.updateConfig(newConfigData);
      
      expect(configManager.currentConfig.appTitle, 'Updated Title');
      expect(configManager.currentConfig.baseUrl, 'https://updated.com');
      expect(configManager.currentConfig.apiVersion, '/api/v2');
      
      // 测试健康状态
      final health = await configManager.getHealthStatus();
      expect(health, isNotNull);
      expect(health['current_config'], isNotNull);
      expect(health['manager_status'], isNotNull);
    });

    test('ConfigManager 监听器测试', () async {
      final configManager = ConfigManager.instance;
      
      AppConfiguration? receivedConfig;
      void listener(AppConfiguration config) {
        receivedConfig = config;
      }
      
      configManager.addListener(listener);
      
      await configManager.initialize();
      
      expect(receivedConfig, isNotNull);
      expect(receivedConfig!.appTitle, configManager.currentConfig.appTitle);
      
      configManager.removeListener(listener);
    });
  });
}

/// 配置系统性能测试
void performanceTests() {
  group('配置系统性能测试', () {
    test('配置加载性能测试', () async {
      final stopwatch = Stopwatch()..start();
      
      await ConfigManager.instance.initialize();
      
      stopwatch.stop();
      
      // 配置加载应该在合理时间内完成（例如3秒）
      expect(stopwatch.elapsedMilliseconds, lessThan(3000));
      
      print('配置加载耗时: ${stopwatch.elapsedMilliseconds}ms');
    });

    test('配置缓存性能测试', () async {
      final config = AppConfiguration.defaults();
      final stopwatch = Stopwatch()..start();
      
      // 测试100次缓存操作
      for (int i = 0; i < 100; i++) {
        await ConfigCache.cacheConfig(config);
        await ConfigCache.getCachedConfig();
      }
      
      stopwatch.stop();
      
      // 100次操作应该在合理时间内完成
      expect(stopwatch.elapsedMilliseconds, lessThan(5000));
      
      print('100次缓存操作耗时: ${stopwatch.elapsedMilliseconds}ms');
    });
  });
}

/// 配置系统集成测试
void integrationTests() {
  group('配置系统集成测试', () {
    test('完整配置流程测试', () async {
      // 1. 初始化配置管理器
      final configManager = ConfigManager.instance;
      await configManager.initialize();
      
      // 2. 验证默认配置
      expect(configManager.currentConfig.isValid(), true);
      
      // 3. 模拟远程配置更新
      final remoteConfig = {
        'appTitle': 'Remote App',
        'baseUrl': 'https://remote.com',
        'version': 2,
      };
      
      await configManager.updateConfig(remoteConfig);
      
      // 4. 验证配置更新
      expect(configManager.currentConfig.appTitle, 'Remote App');
      expect(configManager.currentConfig.baseUrl, 'https://remote.com');
      expect(configManager.currentConfig.version, 2);
      
      // 5. 验证缓存
      final cached = await ConfigCache.getCachedConfig();
      expect(cached, isNotNull);
      expect(cached!.appTitle, 'Remote App');
      
      // 6. 重新初始化，验证从缓存恢复
      await configManager.reload();
      expect(configManager.currentConfig.appTitle, 'Remote App');
      
      // 7. 健康检查
      final health = await configManager.getHealthStatus();
      expect(health['current_config']['isValid'], true);
    });
  });
}