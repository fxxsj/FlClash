import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/views/access.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fl_clash/models/config.dart';
import 'package:fl_clash/views/theme.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _appVersion = packageInfo.version;
      });
    } catch (e) {
      setState(() {
        _appVersion = '2.0.0';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            // 网络部分
            _buildSectionTitle(appLocalizations.networkSection),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  _buildListTile(
                    title: appLocalizations.stackMode,
                    trailing: Consumer(
                      builder: (context, ref, child) {
                        final stack = ref.watch(patchClashConfigProvider.select((state) => state.tun.stack));
                        return Text(
                          stack.name,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        );
                      },
                    ),
                    onTap: () => _handleTunStackMode(),
                  ),
                  if (system.isDesktop) ...[
                    const Divider(height: 1),
                    Consumer(
                      builder: (context, ref, child) {
                        final tunEnable = ref.watch(patchClashConfigProvider.select((state) => state.tun.enable));
                        return _buildSwitchTile(
                          title: appLocalizations.tun,
                          value: tunEnable,
                          onChanged: (value) {
                            ref.read(patchClashConfigProvider.notifier).updateState(
                              (state) => state.copyWith.tun(enable: value),
                            );
                          },
                        );
                      },
                    ),
                  ],
                  if (Platform.isMacOS) ...[
                    const Divider(height: 1),
                    Consumer(
                      builder: (context, ref, child) {
                        final autoSetSystemDns = ref.watch(networkSettingProvider.select((state) => state.autoSetSystemDns));
                        return _buildSwitchTile(
                          title: appLocalizations.autoSetSystemDns,
                          value: autoSetSystemDns,
                          onChanged: (value) {
                            ref.read(networkSettingProvider.notifier).updateState(
                              (state) => state.copyWith(autoSetSystemDns: value),
                            );
                          },
                        );
                      },
                    ),
                  ],
                  const Divider(height: 1),
                  Consumer(
                    builder: (context, ref, child) {
                      final systemProxy = ref.watch(networkSettingProvider.select((state) => state.systemProxy));
                      return _buildSwitchTile(
                        title: appLocalizations.systemProxy,
                        value: systemProxy,
                        onChanged: (value) {
                          ref.read(networkSettingProvider.notifier).updateState(
                            (state) => state.copyWith(systemProxy: value),
                          );
                        },
                      );
                    },
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final systemProxy = ref.watch(networkSettingProvider.select((state) => state.systemProxy));
                      if (systemProxy) {
                        return Column(
                          children: [
                            const Divider(height: 1),
                            _buildListTile(
                              title: appLocalizations.bypassDomain,
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () => _handleBypassDomain(),
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  if (Platform.isAndroid) ...[
                    const Divider(height: 1),
                    _buildListTile(
                      title: appLocalizations.accessControl,
                      trailing: Consumer(
                        builder: (context, ref, child) {
                          final accessControl = ref.watch(vpnSettingProvider.select((state) => state.accessControl));
                          String modeText = appLocalizations.accessControlAllowDesc;
                          if (accessControl.mode == AccessControlMode.acceptSelected) {
                            modeText = appLocalizations.whitelistMode;
                          } else {
                            modeText = appLocalizations.blacklistMode;
                          }
                          return Text(
                            modeText,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          );
                        },
                      ),
                      onTap: () => _handleAccessControlMode(),
                    ),
                  ],
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 应用部分
            _buildSectionTitle(appLocalizations.applicationSection),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  _buildListTile(
                    title: appLocalizations.language,
                    trailing: Consumer(
                      builder: (context, ref, child) {
                        final locale = ref.watch(appSettingProvider.select((state) => state.locale));
                        final subTitle = locale ?? appLocalizations.defaultText;
                        return Text(
                          Intl.message(subTitle),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        );
                      },
                    ),
                    onTap: () => _handleLanguageSettings(),
                  ),
                  const Divider(height: 1),
                  _buildListTile(
                    title: appLocalizations.theme,
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _handleThemeSettings(),
                  ),
                  const Divider(height: 1),
                  _buildListTile(
                    title: appLocalizations.currentVersion,
                    trailing: Text(
                      _appVersion,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    onTap: () => _handleVersionInfo(),
                  ),
                  const Divider(height: 1),
                  Consumer(
                    builder: (context, ref, child) {
                      final configState = ref.watch(systemConfigProvider);
                      
                      return configState.when(
                        data: (config) {
                          // 只有当 tosUrl 不为 null 且不为空时才显示用户协议
                          if (config.tosUrl != null && config.tosUrl!.isNotEmpty) {
                            return _buildListTile(
                              title: appLocalizations.userAgreement,
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () => _handleUserAgreement(config.tosUrl!),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }

  

  Widget _buildListTile({
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      title: Text(title),
      trailing: trailing,
      onTap: onTap,
      dense: false,
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      dense: false,
    );
  }

  void _handleTunStackMode() {
    final currentStack = ref.read(patchClashConfigProvider.select((state) => state.tun.stack));
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(appLocalizations.stackMode),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: TunStack.values.map((stack) {
            return ListTile(
              title: Text(stack.name),
              leading: Radio<TunStack>(
                value: stack,
                groupValue: currentStack,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(patchClashConfigProvider.notifier).updateState(
                      (state) => state.copyWith.tun(stack: value),
                    );
                    Navigator.of(context).pop();
                  }
                },
              ),
              onTap: () {
                ref.read(patchClashConfigProvider.notifier).updateState(
                  (state) => state.copyWith.tun(stack: stack),
                );
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(appLocalizations.cancel),
          ),
        ],
      ),
    );
  }

  void _handleBypassDomain() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Consumer(
        builder: (_, ref, __) {
          final bypassDomain = ref.watch(
              networkSettingProvider.select((state) => state.bypassDomain));
          return DraggableScrollableSheet(
            initialChildSize: 0.8,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            expand: false,
            builder: (context, scrollController) => Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).dividerColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            appLocalizations.bypassDomain,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            final res = await globalState.showMessage(
                              title: appLocalizations.reset,
                              message: TextSpan(
                                text: appLocalizations.resetTip,
                              ),
                            );
                            if (res != true) {
                              return;
                            }
                            ref.read(networkSettingProvider.notifier).updateState(
                                  (state) => state.copyWith(
                                    bypassDomain: defaultBypassDomain,
                                  ),
                                );
                          },
                          tooltip: appLocalizations.reset,
                          icon: const Icon(Icons.replay),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListInputPage(
                      title: appLocalizations.bypassDomain,
                      items: bypassDomain,
                      titleBuilder: (item) => Text(item),
                      onChange: (items) {
                        ref.read(networkSettingProvider.notifier).updateState(
                              (state) => state.copyWith(
                                bypassDomain: List.from(items),
                              ),
                            );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleAccessControlMode() {
    // 直接跳转到访问控制页面，与工具中的实现保持一致
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(appLocalizations.appAccessControl),
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 0,
          ),
          body: const AccessView(),
        ),
      ),
    );
  }

  String _getLocaleString(Locale? locale) {
    if (locale == null) return appLocalizations.defaultText;
    return Intl.message(locale.toString());
  }

  void _handleLanguageSettings() {
    final locale = ref.read(appSettingProvider.select((state) => state.locale));
    final currentLocale = utils.getLocaleForString(locale);
    final supportedLocales = AppLocalizations.delegate.supportedLocales;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(appLocalizations.language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final option in [null, ...supportedLocales])
              ListTile(
                title: Text(_getLocaleString(option)),
                leading: Radio<Locale?>(
                  value: option,
                  groupValue: currentLocale,
                  onChanged: (value) {
                    ref.read(appSettingProvider.notifier).updateState(
                      (state) => state.copyWith(locale: value?.toString()),
                    );
                    Navigator.of(context).pop();
                  },
                ),
                onTap: () {
                  ref.read(appSettingProvider.notifier).updateState(
                    (state) => state.copyWith(locale: option?.toString()),
                  );
                  Navigator.of(context).pop();
                },
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(appLocalizations.cancel),
          ),
        ],
      ),
    );
  }

  void _handleVersionInfo() async {
    final commonScaffoldState = context.commonScaffoldState;
    if (commonScaffoldState?.mounted != true) return;
    final data = await commonScaffoldState?.loadingRun<Map<String, dynamic>?>(
      request.checkForUpdate,
      title: appLocalizations.checkUpdate,
    );
    globalState.appController.checkUpdateResultHandle(
      data: data,
      handleError: true,
    );
  }

  void _handleUserAgreement(String tosUrl) async {
    try {
      final uri = Uri.parse(tosUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(appLocalizations.openLinkFailed(tosUrl))),
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

  void _handleThemeSettings() {
    final viewMode = globalState.appController.viewMode;
    if (viewMode == ViewMode.mobile) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(appLocalizations.theme),
              backgroundColor: Theme.of(context).colorScheme.surface,
              elevation: 0,
            ),
            body: const ThemeView(),
          ),
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          appLocalizations.theme,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: ThemeView(),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}