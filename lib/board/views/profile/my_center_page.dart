import 'package:fl_clash/common/app_localizations.dart';
import 'package:fl_clash/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/board/views/account/profile/user_info.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/board/views/orders/order_list_page.dart';
import 'package:fl_clash/board/views/support/components/ticket_sheet.dart';
import 'package:fl_clash/board/views/settings/settings_page.dart';
import 'package:fl_clash/views/tools.dart';
import 'package:fl_clash/board/constants/app_config.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:fl_clash/board/utils/silent_update_manager.dart';
import 'package:fl_clash/board/views/account/profile/change_password_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fl_clash/board/views/invite/invite_page.dart';

class MyCenterPage extends ConsumerStatefulWidget {
  const MyCenterPage({super.key});

  @override
  ConsumerState<MyCenterPage> createState() => _MyCenterPageState();
}

class _MyCenterPageState extends ConsumerState<MyCenterPage>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {

  // 工具入口显示控制
  bool _showToolsEntry = false;
  int _settingsClickCount = 0;
  DateTime? _lastSettingsClickTime;
  Timer? _settingsNavigationTimer;
  static const int _requiredClicks = 5; // 需要连续点击5次
  static const Duration _clickTimeWindow = Duration(seconds: 2); // 2秒内的点击才算连续
  static const Duration _navigationDelay = Duration(milliseconds: 500); // 导航延迟

  @override
  bool get wantKeepAlive => true; // 保持页面状态

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // 页面初始化时触发静默更新
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (kDebugMode) {
        debugPrint('MyCenterPage initState - 触发静默更新检查');
      }
      SilentUpdateManager.triggerSilentUpdateIfNeeded(ref, pageName: "我的页面-初始化");
    });
  }

  @override
  void dispose() {
    _settingsNavigationTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 每次页面依赖变化时都检查是否需要静默更新
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (kDebugMode) {
        debugPrint('MyCenterPage didChangeDependencies - 触发静默更新检查');
      }
      SilentUpdateManager.triggerSilentUpdateIfNeeded(ref, pageName: "我的页面-依赖变化");
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // 当应用从后台回到前台时，也检查更新
    if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (kDebugMode) {
          debugPrint('MyCenterPage 应用回到前台 - 触发静默更新检查');
        }
        SilentUpdateManager.triggerSilentUpdateIfNeeded(ref, pageName: "我的页面-应用前台");
      });
    }
  }

  /// 手动触发更新检查 - 可以被外部调用
  void triggerUpdateCheck() {
    if (kDebugMode) {
      debugPrint('MyCenterPage 手动触发更新检查');
    }
    SilentUpdateManager.triggerSilentUpdateIfNeeded(ref, pageName: "我的页面-手动");
  }

  /// 处理设置按钮的连续点击
  void _handleSettingsClick() {
    final now = DateTime.now();

    // 取消之前的导航定时器
    _settingsNavigationTimer?.cancel();

    // 如果距离上次点击超过时间窗口，重置计数
    if (_lastSettingsClickTime == null ||
        now.difference(_lastSettingsClickTime!) > _clickTimeWindow) {
      _settingsClickCount = 1;
    } else {
      _settingsClickCount++;
    }

    _lastSettingsClickTime = now;

    if (kDebugMode) {
      debugPrint('设置按钮点击计数: $_settingsClickCount/$_requiredClicks');
    }

    // 达到要求的点击次数时切换工具入口显示状态
    if (_settingsClickCount >= _requiredClicks) {
      setState(() {
        _showToolsEntry = !_showToolsEntry;
      });

      _settingsClickCount = 0; // 重置计数

      if (kDebugMode) {
        debugPrint('工具入口状态切换: ${_showToolsEntry ? "显示" : "隐藏"}');
      }

      // 给用户反馈
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_showToolsEntry ? appLocalizations.toolsEntryShown : appLocalizations.toolsEntryHidden),
          duration: const Duration(seconds: 1),
        ),
      );

      // 工具入口切换完成，不需要导航到设置页面
      return;
    }

    // 如果没有达到连续点击次数，设置延迟导航到设置页面
    // 这样给用户时间进行后续点击（如果他们想显示工具入口）
    _settingsNavigationTimer = Timer(_navigationDelay, () {
      if (mounted) {
        _handleSettings(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // 必须调用以支持 AutomaticKeepAliveClientMixin
    final authState = ref.watch(authStateProvider);

    // 每次build时也检查是否需要更新（这样可以确保在页面显示时触发）
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (kDebugMode) {
        debugPrint('MyCenterPage build - 触发静默更新检查');
      }
      SilentUpdateManager.triggerSilentUpdateIfNeeded(ref, pageName: "我的页面-构建");
    });

    if (!authState.isAuthenticated) {
      // If not authenticated, show login message
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person_outline,
                size: 64,
                color: Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(height: 16),
              Text(
                appLocalizations.pleaseLogin2,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                appLocalizations.loginToViewPersonalInfo,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final viewMode = globalState.appController.viewMode;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // User Info Section - replaces "我的账号" and "我的订阅" from reference
            const UserInfo(),

            const SizedBox(height: 16),

            // Menu Items Section
            Card(
              child: Column(
                children: [
                  if (viewMode == ViewMode.mobile)
                    _buildMenuItem(
                      context,
                      icon: Icons.shopping_bag,
                      title: appLocalizations.myOrders2,
                      onTap: () => _handleMyOrders(context),
                    ),
                  if (viewMode == ViewMode.mobile) const Divider(height: 1),
                  if (viewMode == ViewMode.mobile)
                    _buildMenuItem(
                      context,
                      icon: Icons.card_giftcard,
                      title: appLocalizations.inviteFriends2,
                      onTap: () => _handleInviteRewards(context),
                    ),
                  if (viewMode == ViewMode.mobile) const Divider(height: 1),
                  if (viewMode == ViewMode.mobile)
                    _buildMenuItem(
                      context,
                      icon: Icons.support,
                      title: appLocalizations.customerSupport2,
                      onTap: () => _handleCustomerSupport(context),
                    ),
                  if (viewMode == ViewMode.mobile) const Divider(height: 1),
                  // Telegram Group moved here
                  Consumer(
                    builder: (context, ref, child) {
                      final userConfigState = ref.watch(userConfigProvider);
                      return userConfigState.when(
                        data: (config) {
                          final telegramLink = config['telegram_discuss_link'] as String?;
                          if (telegramLink != null && telegramLink.isNotEmpty) {
                            return Column(
                              children: [
                                _buildMenuItem(
                                  context,
                                  icon: Icons.telegram,
                                  title: appLocalizations.telegramGroup,
                                  onTap: () => _handleTelegramGroup(telegramLink),
                                ),
                                const Divider(height: 1),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.settings,
                    title: appLocalizations.otherSettings,
                    onTap: () => _handleSettingsClick(),
                  ),
                  if (_showToolsEntry) ...[
                    const Divider(height: 1),
                    _buildMenuItem(
                      context,
                      icon: Icons.construction,
                      title: appLocalizations.tools2,
                      onTap: () => _handleTools(context),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Personalization and Other Settings
            Card(
              child: Column(
                children: [
                  _buildMenuItem(
                    context,
                    icon: Icons.lock_outline,
                    title: appLocalizations.modifyPassword,
                    onTap: () => _handleChangePassword(),
                  ),
                  const Divider(height: 1),
                  Consumer(
                    builder: (context, ref, child) {
                      final userState = ref.watch(userStateProvider);
                      final remindExpire = userState.user?.remindExpire ?? false;
                      return _buildSwitchTile(
                        context,
                        icon: Icons.email_outlined,
                        title: appLocalizations.expiryEmailReminder,
                        value: remindExpire,
                        onChanged: (value) async {
                          try {
                            await ref.read(userStateProvider.notifier).updateUserInfo(
                              remindExpire: value,
                            );
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(value ? appLocalizations.expiryEmailReminderEnabled : appLocalizations.expiryEmailReminderDisabled)),
                              );
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${appLocalizations.settingsFailed}: $e')),
                              );
                            }
                          }
                        },
                      );
                    },
                  ),
                  const Divider(height: 1),
                  Consumer(
                    builder: (context, ref, child) {
                      final userState = ref.watch(userStateProvider);
                      final remindTraffic = userState.user?.remindTraffic ?? false;
                      return _buildSwitchTile(
                        context,
                        icon: Icons.traffic_outlined,
                        title: appLocalizations.trafficEmailReminder,
                        value: remindTraffic,
                        onChanged: (value) async {
                          try {
                            await ref.read(userStateProvider.notifier).updateUserInfo(
                              remindTraffic: value,
                            );
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(value ? appLocalizations.trafficEmailReminderEnabled : appLocalizations.trafficEmailReminderDisabled)),
                              );
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${appLocalizations.settingsFailed}: $e')),
                              );
                            }
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Logout Section
            Card(
              child: _buildMenuItem(
                context,
                icon: Icons.logout,
                title: appLocalizations.logoutUser,
                textColor: Theme.of(context).colorScheme.error,
                onTap: () => _handleLogout(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: textColor ?? Theme.of(context).colorScheme.onSurface,
      ),
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      trailing: textColor == null
          ? Icon(
              Icons.chevron_right,
              color: Theme.of(context).colorScheme.outline,
            )
          : null,
      onTap: onTap,
    );
  }

  

  Widget _buildSwitchTile(
    BuildContext context, { // Add context parameter
    required IconData icon, // Add icon parameter
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon), // Use the icon here
      title: Text(title),
      value: value,
      onChanged: onChanged,
      dense: false,
    );
  }

  void _handleChangePassword() {
    final viewMode = globalState.appController.viewMode;
    
    if (viewMode == ViewMode.mobile) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ChangePasswordPage(),
        ),
      );
    } else {
      // 桌面模式使用弹窗，与订单详情和工单详情保持一致
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: const ChangePasswordSheetWidget(),
          );
        },
      );
    }
  }

  void _handleTelegramGroup(String telegramLink) async {
    try {
      final uri = Uri.parse(telegramLink);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(appLocalizations.cannotOpenTelegramLink)),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(appLocalizations.openLinkFailed(e.toString()))),
        );
      }
    }
  }

  void _handleMyOrders(BuildContext context) {
    final viewMode = globalState.appController.viewMode;
    if (viewMode == ViewMode.mobile) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommonScaffold.open(
            title: appLocalizations.myOrders,
            actions: const [],
            body: const OrderListPage(),
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
    } else {
      showExtend(
        context,
        builder: (context, type) {
          return AdaptiveSheetScaffold(
            type: type,
            body: const OrderListPage(),
            title: appLocalizations.myOrders,
            actions: const [],
          );
        },
      );
    }
  }

  void _handleInviteRewards(BuildContext context) {
    final viewMode = globalState.appController.viewMode;
    if (viewMode == ViewMode.mobile) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommonScaffold.open(
            title: appLocalizations.inviteFriends,
            actions: const [],
            body: const InvitePage(),
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
    } else {
      showExtend(
        context,
        builder: (context, type) {
          return AdaptiveSheetScaffold(
            type: type,
            body: const InvitePage(),
            title: appLocalizations.inviteFriends,
            actions: const [],
          );
        },
      );
    }
  }

  void _handleCustomerSupport(BuildContext context) {
    final viewMode = globalState.appController.viewMode;
    if (viewMode == ViewMode.mobile) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommonScaffold.open(
            title: appLocalizations.customerSupport,
            actions: const [],
            body: const TicketSheet(),
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
    } else {
      showExtend(
        context,
        builder: (context, type) {
          return AdaptiveSheetScaffold(
            type: type,
            body: const TicketSheet(),
            title: appLocalizations.customerSupport,
            actions: const [],
          );
        },
      );
    }
  }

  void _handleSettings(BuildContext context) {
    final viewMode = globalState.appController.viewMode;
    if (viewMode == ViewMode.mobile) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommonScaffold.open(
            title: appLocalizations.otherSettings,
            actions: const [],
            body: const SettingsPage(),
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
    } else {
      showExtend(
        context,
        builder: (context, type) {
          return AdaptiveSheetScaffold(
            type: type,
            body: const SettingsPage(),
            title: appLocalizations.otherSettings,
            actions: const [],
          );
        },
      );
    }
  }

  void _handleTools(BuildContext context) {
    final viewMode = globalState.appController.viewMode;
    if (viewMode == ViewMode.mobile) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CommonScaffold.open(
            title: appLocalizations.tools,
            actions: const [],
            body: const ToolsView(),
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
    } else {
      showExtend(
        context,
        builder: (context, type) {
          return AdaptiveSheetScaffold(
            type: type,
            body: const ToolsView(),
            title: appLocalizations.tools,
            actions: const [],
          );
        },
      );
    }
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(appLocalizations.confirmLogout),
        content: Text(appLocalizations.confirmLogoutMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(appLocalizations.cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Close dialog first

              // 首先退出登录
              await ref.read(authStateProvider.notifier).logout();

              // 确保清除用户状态和认证状态
              ref.invalidate(authStateProvider);
              ref.invalidate(userStateProvider);

              // 尝试关闭所有可能的扩展页面（订单详情等）
              if (context.mounted && Navigator.canPop(context)) {
                Navigator.popUntil(context, (route) {
                  // 返回到主页面，保留根路由
                  return route.isFirst;
                });
              }

              if (context.mounted) {
                // 隐藏当前显示的SnackBar
                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${appLocalizations.logout}${appLocalizations.loginSuccess.substring(2)}")),
                );
              }
            },
            child: Text(appLocalizations.logoutButton),
          ),
        ],
      ),
    );
  }
}