import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fl_clash/clash/clash.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/manager/hotkey_manager.dart';
import 'package:fl_clash/manager/manager.dart';
import 'package:fl_clash/plugins/app.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/board/views/account/auth/index.dart';

import 'controller.dart';
import 'pages/pages.dart';

class Application extends ConsumerStatefulWidget {
  const Application({
    super.key,
  });

  @override
  ConsumerState<Application> createState() => ApplicationState();
}

class ApplicationState extends ConsumerState<Application> {
  Timer? _autoUpdateGroupTaskTimer;
  Timer? _autoUpdateProfilesTaskTimer;

  final _pageTransitionsTheme = const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CommonPageTransitionsBuilder(),
      TargetPlatform.windows: CommonPageTransitionsBuilder(),
      TargetPlatform.linux: CommonPageTransitionsBuilder(),
      TargetPlatform.macOS: CommonPageTransitionsBuilder(),
    },
  );

  ColorScheme _getAppColorScheme({
    required Brightness brightness,
    int? primaryColor,
  }) {
    return ref.read(genColorSchemeProvider(brightness));
  }

  @override
  void initState() {
    super.initState();
    _autoUpdateGroupTask();
    _autoUpdateProfilesTask();
    globalState.appController = AppController(context, ref);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final currentContext = globalState.navigatorKey.currentContext;
      if (currentContext != null) {
        globalState.appController = AppController(currentContext, ref);
      }
      await globalState.appController.init();
      globalState.appController.initLink();
      app?.initShortcuts();
      
    });
  }

  _autoUpdateGroupTask() {
    // 延迟30秒开始，避免启动时阻塞
    _autoUpdateGroupTaskTimer = Timer(const Duration(seconds: 30), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        globalState.appController.updateGroupsDebounce();
        // 后续每20秒执行一次
        _autoUpdateGroupTaskTimer = Timer.periodic(const Duration(seconds: 20), (_) {
          globalState.appController.updateGroupsDebounce();
        });
      });
    });
  }

  _autoUpdateProfilesTask() {
    // 延迟5分钟开始配置文件自动更新
    _autoUpdateProfilesTaskTimer = Timer(const Duration(minutes: 5), () async {
      await globalState.appController.autoUpdateProfiles();
      // 后续每20分钟执行一次
      _autoUpdateProfilesTaskTimer = Timer.periodic(const Duration(minutes: 20), (_) async {
        await globalState.appController.autoUpdateProfiles();
      });
    });
  }

  _buildPlatformState(Widget child) {
    if (system.isDesktop) {
      return WindowManager(
        child: TrayManager(
          child: HotKeyManager(
            child: ProxyManager(
              child: child,
            ),
          ),
        ),
      );
    }
    return AndroidManager(
      child: TileManager(
        child: child,
      ),
    );
  }

  _buildState(Widget child) {
    return AppStateManager(
      child: ClashManager(
        child: ConnectivityManager(
          onConnectivityChanged: (results) async {
            if (!results.contains(ConnectivityResult.vpn)) {
              await clashCore.closeConnections();
            }
            globalState.appController.updateLocalIp();
            globalState.appController.addCheckIpNumDebounce();
          },
          child: child,
        ),
      ),
    );
  }

  _buildPlatformApp(Widget child) {
    if (system.isDesktop) {
      return WindowHeaderContainer(
        child: child,
      );
    }
    return VpnManager(
      child: child,
    );
  }

  _buildApp(Widget child) {
    return MessageManager(
      child: ThemeManager(
        child: child,
      ),
    );
  }

  @override
  Widget build(context) {
    return _buildPlatformState(
      _buildState(
        Consumer(
          builder: (_, ref, child) {
            final locale =
                ref.watch(appSettingProvider.select((state) => state.locale));
            final themeProps = ref.watch(themeSettingProvider);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: globalState.navigatorKey,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              builder: (_, child) {
                return AppEnvManager(
                  child: _buildPlatformApp(
                    _buildApp(child!),
                  ),
                );
              },
              scrollBehavior: BaseScrollBehavior(),
              title: appName,
              locale: utils.getLocaleForString(locale),
              supportedLocales: AppLocalizations.delegate.supportedLocales,
              themeMode: themeProps.themeMode,
              theme: ThemeData(
                useMaterial3: true,
                pageTransitionsTheme: _pageTransitionsTheme,
                colorScheme: _getAppColorScheme(
                  brightness: Brightness.light,
                  primaryColor: themeProps.primaryColor,
                ),
              ),
              darkTheme: ThemeData(
                useMaterial3: true,
                pageTransitionsTheme: _pageTransitionsTheme,
                colorScheme: _getAppColorScheme(
                  brightness: Brightness.dark,
                  primaryColor: themeProps.primaryColor,
                ).toPureBlack(themeProps.pureBlack),
              ),
              home: Consumer(
                builder: (context, ref, _) {
                  final authState = ref.watch(authStateProvider);
                  
                  // 如果未认证，显示全屏登录界面
                  if (!authState.isAuthenticated) {
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      localizationsDelegates: const [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate
                      ],
                      routes: {
                        '/login': (context) => const LoginPage(),
                        '/register': (context) => const RegisterPage(),
                        '/reset_password': (context) => const ResetPasswordPage(),
                      },
                      locale: utils.getLocaleForString(locale),
                      supportedLocales: AppLocalizations.delegate.supportedLocales,
                      themeMode: themeProps.themeMode,
                      theme: ThemeData(
                        useMaterial3: true,
                        pageTransitionsTheme: _pageTransitionsTheme,
                        colorScheme: _getAppColorScheme(
                          brightness: Brightness.light,
                          primaryColor: themeProps.primaryColor,
                        ),
                      ),
                      darkTheme: ThemeData(
                        useMaterial3: true,
                        pageTransitionsTheme: _pageTransitionsTheme,
                        colorScheme: _getAppColorScheme(
                          brightness: Brightness.dark,
                          primaryColor: themeProps.primaryColor,
                        ).toPureBlack(themeProps.pureBlack),
                      ),
                      home: const LoginPage(),
                    );
                  }
                  
                  // 已认证，显示主应用
                  return const HomePage();
                },
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Future<void> dispose() async {
    linkManager.destroy();
    _autoUpdateGroupTaskTimer?.cancel();
    _autoUpdateProfilesTaskTimer?.cancel();
    await clashCore.destroy();
    await globalState.appController.savePreferences();
    await globalState.appController.handleExit();
    super.dispose();
  }
}
