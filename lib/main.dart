import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:fl_clash/board/riverpod_setup.dart';
import 'package:fl_clash/plugins/app.dart';
import 'package:fl_clash/plugins/tile.dart';
import 'package:fl_clash/plugins/vpn.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/managers/startup_manager.dart';
import 'package:fl_clash/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'application.dart';
import 'clash/core.dart';
import 'clash/lib.dart';
import 'common/common.dart';
import 'models/models.dart';

Future<void> main() async {
  globalState.isService = false;
  WidgetsFlutterBinding.ensureInitialized();
  
  // 启动优化的应用
  runApp(const OptimizedFlClashApp());
}

/// 优化的FlClash应用
class OptimizedFlClashApp extends StatefulWidget {
  const OptimizedFlClashApp({super.key});

  @override
  State<OptimizedFlClashApp> createState() => _OptimizedFlClashAppState();
}

class _OptimizedFlClashAppState extends State<OptimizedFlClashApp> {
  bool _isInitialized = false;
  ProviderContainer? _container;
  
  @override
  void initState() {
    super.initState();
    _performStartup();
  }

  Future<void> _performStartup() async {
    try {
      await startupManager.performOptimizedStartup();
      
      if (mounted) {
        setState(() {
          _container = startupManager.container;
          _isInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('启动失败: $e');
      // 即使启动失败也要显示应用，创建一个基础容器
      try {
        final fallbackContainer = await _createFallbackContainer();
        if (mounted) {
          setState(() {
            _container = fallbackContainer;
            _isInitialized = true;
          });
        }
      } catch (fallbackError) {
        debugPrint('创建备用容器失败: $fallbackError');
        // 最后的降级方案：创建一个空容器
        if (mounted) {
          setState(() {
            _container = ProviderContainer();
            _isInitialized = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized || _container == null) {
      // 启动阶段：显示启动页面（不需要Riverpod）
      return MaterialApp(
        title: 'FlClash',
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
          onInitializationComplete: () {
            // 启动页面完成回调，但实际切换由状态控制
          },
        ),
      );
    }

    // 启动完成：显示主应用（包装在ProviderScope中）
    return UncontrolledProviderScope(
      container: _container!,
      child: MaterialApp(
        title: 'FlClash',
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: const Application(),
      ),
    );
  }

  Future<ProviderContainer> _createFallbackContainer() async {
    try {
      return await setupRiverpod();
    } catch (e) {
      debugPrint('创建备用容器失败: $e');
      // 返回一个基础容器
      return ProviderContainer();
    }
  }
}

@pragma('vm:entry-point')
Future<void> _service(List<String> flags) async {
  globalState.isService = true;
  WidgetsFlutterBinding.ensureInitialized();
  final quickStart = flags.contains("quick");
  final clashLibHandler = ClashLibHandler();
  await globalState.init();

  tile?.addListener(
    _TileListenerWithService(
      onStop: () async {
        await app?.tip(appLocalizations.stopVpn);
        clashLibHandler.stopListener();
        await vpn?.stop();
        exit(0);
      },
    ),
  );

  vpn?.handleGetStartForegroundParams = () {
    final traffic = clashLibHandler.getTraffic();
    return json.encode({
      "title": clashLibHandler.getCurrentProfileName(),
      "content": "$traffic"
    });
  };

  vpn?.addListener(
    _VpnListenerWithService(
      onDnsChanged: (String dns) {
        print("handle dns $dns");
        clashLibHandler.updateDns(dns);
      },
    ),
  );
  if (!quickStart) {
    _handleMainIpc(clashLibHandler);
  } else {
    commonPrint.log("quick start");
    await ClashCore.initGeo();
    app?.tip(appLocalizations.startVpn);
    final homeDirPath = await appPath.homeDirPath;
    final version = await system.version;
    final clashConfig = globalState.config.patchClashConfig.copyWith.tun(
      enable: false,
    );
    Future(() async {
      final profileId = globalState.config.currentProfileId;
      if (profileId == null) {
        return;
      }
      final params = await globalState.getSetupParams(
        pathConfig: clashConfig,
      );
      final res = await clashLibHandler.quickStart(
        InitParams(
          homeDir: homeDirPath,
          version: version,
        ),
        params,
        globalState.getCoreState(),
      );
      debugPrint(res);
      if (res.isNotEmpty) {
        await vpn?.stop();
        exit(0);
      }
      await vpn?.start(
        clashLibHandler.getAndroidVpnOptions(),
      );
      clashLibHandler.startListener();
    });
  }
}

_handleMainIpc(ClashLibHandler clashLibHandler) {
  final sendPort = IsolateNameServer.lookupPortByName(mainIsolate);
  if (sendPort == null) {
    return;
  }
  final serviceReceiverPort = ReceivePort();
  serviceReceiverPort.listen((message) async {
    final res = await clashLibHandler.invokeAction(message);
    sendPort.send(res);
  });
  sendPort.send(serviceReceiverPort.sendPort);
  final messageReceiverPort = ReceivePort();
  clashLibHandler.attachMessagePort(
    messageReceiverPort.sendPort.nativePort,
  );
  messageReceiverPort.listen((message) {
    sendPort.send(message);
  });
}

@immutable
class _TileListenerWithService with TileListener {
  final Function() _onStop;

  const _TileListenerWithService({
    required Function() onStop,
  }) : _onStop = onStop;

  @override
  void onStop() {
    _onStop();
  }
}

@immutable
class _VpnListenerWithService with VpnListener {
  final Function(String dns) _onDnsChanged;

  const _VpnListenerWithService({
    required Function(String dns) onDnsChanged,
  }) : _onDnsChanged = onDnsChanged;

  @override
  void onDnsChanged(String dns) {
    super.onDnsChanged(dns);
    _onDnsChanged(dns);
  }
}
