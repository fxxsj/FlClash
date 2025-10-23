import 'dart:io';

import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/views/about.dart';
import 'package:fl_clash/views/access.dart';
import 'package:fl_clash/views/application_setting.dart';
import 'package:fl_clash/views/config/config.dart';
import 'package:fl_clash/views/hotkey.dart';
import 'package:fl_clash/views/connection/connections.dart';
import 'package:fl_clash/views/connection/requests.dart';
import 'package:fl_clash/views/profiles/profiles.dart';
import 'package:fl_clash/views/profiles/add_profile.dart';
import 'package:fl_clash/views/profiles/scripts.dart';
import 'package:fl_clash/views/proxies/proxies.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' show dirname, join;

import 'backup_and_recovery.dart';
import 'developer.dart';
import 'theme.dart';

class ToolsView extends ConsumerStatefulWidget {
  const ToolsView({super.key});

  @override
  ConsumerState<ToolsView> createState() => _ToolboxViewState();
}

class _ToolboxViewState extends ConsumerState<ToolsView> {
  _buildNavigationMenuItem(NavigationItem navigationItem) {
    return ListItem.open(
      leading: navigationItem.icon,
      title: Text(Intl.message(navigationItem.label.name)),
      subtitle: navigationItem.description != null
          ? Text(Intl.message(navigationItem.description!))
          : null,
      delegate: OpenDelegate(
        title: Intl.message(navigationItem.label.name),
        widget: navigationItem.view,
      ),
    );
  }

  Widget _buildNavigationMenu(List<NavigationItem> navigationItems) {
    return Column(
      children: [
        for (final navigationItem in navigationItems) ...[
          _buildNavigationMenuItem(navigationItem),
          navigationItems.last != navigationItem
              ? const Divider(
                  height: 0,
                )
              : Container(),
        ]
      ],
    );
  }

  Widget _getConnectionToolsList() {
    return Column(
      children: generateSection(
        title: appLocalizations.connectionTools,
        items: [
          _ProxiesItem(),
          _ProfilesItem(),
          _ConnectionsItem(),
          _RequestsItem(),
        ],
      ),
    );
  }

  List<Widget> _getOtherList(bool enableDeveloperMode) {
    return generateSection(
      title: appLocalizations.other,
      items: [
        _DisclaimerItem(),
        if (enableDeveloperMode) _DeveloperItem(),
        _InfoItem(),
      ],
    );
  }

  _getSettingList() {
    return generateSection(
      title: appLocalizations.settings,
      items: [
        _LocaleItem(),
        _ThemeItem(),
        _BackupItem(),
        if (system.isDesktop) _HotkeyItem(),
        if (Platform.isWindows) _LoopbackItem(),
        if (Platform.isAndroid) _AccessItem(),
        _ConfigItem(),
        _SettingItem(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm2 = ref.watch(
      appSettingProvider.select(
        (state) => VM2(a: state.locale, b: state.developerMode),
      ),
    );
    final items = [
      Consumer(
        builder: (_, ref, __) {
          final state = ref.watch(moreToolsSelectorStateProvider);
          final otherItems = state.navigationItems.where((item) => 
            item.label != PageLabel.connections && 
            item.label != PageLabel.requests &&
            item.label != PageLabel.profiles
          ).toList();
          if (otherItems.isEmpty) {
            return Container();
          }
          return Column(
            children: [
              ListHeader(title: appLocalizations.more),
              _buildNavigationMenu(otherItems)
            ],
          );
        },
      ),
      _getConnectionToolsList(),
      ..._getSettingList(),
      ..._getOtherList(vm2.b),
    ];
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, index) => items[index],
      padding: const EdgeInsets.only(bottom: 20),
    );
  }
}

class _LocaleItem extends ConsumerWidget {
  const _LocaleItem();

  String _getLocaleString(Locale? locale) {
    if (locale == null) return appLocalizations.defaultText;
    return Intl.message(locale.toString());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale =
        ref.watch(appSettingProvider.select((state) => state.locale));
    final subTitle = locale ?? appLocalizations.defaultText;
    final currentLocale = utils.getLocaleForString(locale);
    return ListItem<Locale?>.options(
      leading: const Icon(Icons.language_outlined),
      title: Text(appLocalizations.language),
      subtitle: Text(Intl.message(subTitle)),
      delegate: OptionsDelegate(
        title: appLocalizations.language,
        options: [null, ...AppLocalizations.delegate.supportedLocales],
        onChanged: (Locale? locale) {
          ref.read(appSettingProvider.notifier).updateState(
                (state) => state.copyWith(locale: locale?.toString()),
              );
        },
        textBuilder: (locale) => _getLocaleString(locale),
        value: currentLocale,
      ),
    );
  }
}

class _ThemeItem extends StatelessWidget {
  const _ThemeItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const Icon(Icons.style),
      title: Text(appLocalizations.theme),
      subtitle: Text(appLocalizations.themeDesc),
      delegate: OpenDelegate(
        title: appLocalizations.theme,
        widget: const ThemeView(),
      ),
    );
  }
}

class _BackupItem extends StatelessWidget {
  const _BackupItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const Icon(Icons.cloud_sync),
      title: Text(appLocalizations.backupAndRecovery),
      subtitle: Text(appLocalizations.backupAndRecoveryDesc),
      delegate: OpenDelegate(
        title: appLocalizations.backupAndRecovery,
        widget: const BackupAndRecovery(),
      ),
    );
  }
}

class _HotkeyItem extends StatelessWidget {
  const _HotkeyItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const Icon(Icons.keyboard),
      title: Text(appLocalizations.hotkeyManagement),
      subtitle: Text(appLocalizations.hotkeyManagementDesc),
      delegate: OpenDelegate(
        title: appLocalizations.hotkeyManagement,
        widget: const HotKeyView(),
      ),
    );
  }
}

class _LoopbackItem extends StatelessWidget {
  const _LoopbackItem();

  @override
  Widget build(BuildContext context) {
    return ListItem(
      leading: const Icon(Icons.lock),
      title: Text(appLocalizations.loopback),
      subtitle: Text(appLocalizations.loopbackDesc),
      onTap: () {
        windows?.runas(
          '"${join(dirname(Platform.resolvedExecutable), "EnableLoopback.exe")}"',
          "",
        );
      },
    );
  }
}

class _AccessItem extends StatelessWidget {
  const _AccessItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const Icon(Icons.view_list),
      title: Text(appLocalizations.accessControl),
      subtitle: Text(appLocalizations.accessControlDesc),
      delegate: OpenDelegate(
        title: appLocalizations.appAccessControl,
        widget: const AccessView(),
      ),
    );
  }
}

class _ConfigItem extends StatelessWidget {
  const _ConfigItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const Icon(Icons.edit),
      title: Text(appLocalizations.basicConfig),
      subtitle: Text(appLocalizations.basicConfigDesc),
      delegate: OpenDelegate(
        title: appLocalizations.override,
        widget: const ConfigView(),
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  const _SettingItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const Icon(Icons.settings),
      title: Text(appLocalizations.application),
      subtitle: Text(appLocalizations.applicationDesc),
      delegate: OpenDelegate(
        title: appLocalizations.application,
        widget: const ApplicationSettingView(),
      ),
    );
  }
}

class _DisclaimerItem extends StatelessWidget {
  const _DisclaimerItem();

  @override
  Widget build(BuildContext context) {
    return ListItem(
      leading: const Icon(Icons.gavel),
      title: Text(appLocalizations.disclaimer),
      onTap: () async {
        final isDisclaimerAccepted =
            await globalState.appController.showDisclaimer();
        if (!isDisclaimerAccepted) {
          globalState.appController.handleExit();
        }
      },
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const Icon(Icons.info),
      title: Text(appLocalizations.about),
      delegate: OpenDelegate(
        title: appLocalizations.about,
        widget: const AboutView(),
      ),
    );
  }
}

class _ProxiesToolWrapper extends ConsumerStatefulWidget {
  const _ProxiesToolWrapper();

  @override
  ConsumerState<_ProxiesToolWrapper> createState() => _ProxiesToolWrapperState();
}

class _ProxiesToolWrapperState extends ConsumerState<_ProxiesToolWrapper> with PageMixin {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initPageState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const ProxiesView();
  }
}

class _ProfilesToolWrapper extends ConsumerStatefulWidget {
  const _ProfilesToolWrapper();

  @override
  ConsumerState<_ProfilesToolWrapper> createState() => _ProfilesToolWrapperState();
}

class _ProfilesToolWrapperState extends ConsumerState<_ProfilesToolWrapper> with PageMixin {
  
  _handleShowAddExtendPage() {
    showExtend(
      context,
      builder: (_, type) {
        return AdaptiveSheetScaffold(
          type: type,
          body: AddProfileView(
            context: context,
          ),
          title: "${appLocalizations.add}${appLocalizations.profile}",
        );
      },
    );
  }

  _updateProfiles() async {
    final profiles = globalState.config.profiles;
    final messages = [];
    final updateProfiles = profiles.map<Future>(
      (profile) async {
        if (profile.type == ProfileType.file) return;
        globalState.appController.setProfile(
          profile.copyWith(isUpdating: true),
        );
        try {
          await globalState.appController.updateProfile(profile);
        } catch (e) {
          messages.add("${profile.label ?? profile.id}: $e \n");
          globalState.appController.setProfile(
            profile.copyWith(
              isUpdating: false,
            ),
          );
        }
      },
    );
    final titleMedium = context.textTheme.titleMedium;
    await Future.wait(updateProfiles);
    if (messages.isNotEmpty) {
      globalState.showMessage(
        title: appLocalizations.tip,
        message: TextSpan(
          children: [
            for (final message in messages)
              TextSpan(text: message, style: titleMedium)
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initPageState();
    });
  }

  @override
  List<Widget> get actions => [
        IconButton(
          onPressed: () {
            _updateProfiles();
          },
          icon: const Icon(Icons.sync),
        ),
        IconButton(
          onPressed: () {
            showExtend(
              context,
              builder: (_, type) {
                return ScriptsView();
              },
            );
          },
          icon: Consumer(
            builder: (context, ref, __) {
              final isScriptMode = ref.watch(
                  scriptStateProvider.select((state) => state.realId != null));
              return Icon(
                Icons.functions,
                color: isScriptMode ? context.colorScheme.primary : null,
              );
            },
          ),
        ),
        IconButton(
          onPressed: () {
            final profiles = globalState.config.profiles;
            showSheet(
              context: context,
              builder: (_, type) {
                return ReorderableProfilesSheet(
                  type: type,
                  profiles: profiles,
                );
              },
            );
          },
          icon: const Icon(Icons.sort),
          iconSize: 26,
        ),
      ];

  @override
  Widget? get floatingActionButton => FloatingActionButton(
        heroTag: null,
        onPressed: _handleShowAddExtendPage,
        child: const Icon(
          Icons.add,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) {
        final profilesSelectorState = ref.watch(profilesSelectorStateProvider);
        if (profilesSelectorState.profiles.isEmpty) {
          return NullStatus(
            label: appLocalizations.nullProfileDesc,
          );
        }
        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 88,
            ),
            child: Grid(
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              crossAxisCount: profilesSelectorState.columns,
              children: [
                for (int i = 0; i < profilesSelectorState.profiles.length; i++)
                  GridItem(
                    child: ProfileItem(
                      key: Key(profilesSelectorState.profiles[i].id),
                      profile: profilesSelectorState.profiles[i],
                      groupValue: profilesSelectorState.currentProfileId,
                      onChanged: (profileId) {
                        ref.read(currentProfileIdProvider.notifier).value =
                            profileId;
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProfilesItem extends StatelessWidget {
  const _ProfilesItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const Icon(Icons.folder),
      title: Text(appLocalizations.profiles),
      delegate: OpenDelegate(
        title: appLocalizations.profiles,
        widget: const _ProfilesToolWrapper(),
      ),
    );
  }
}

class _ConnectionsItem extends StatelessWidget {
  const _ConnectionsItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const Icon(Icons.ballot),
      title: Text(appLocalizations.connections),
      subtitle: Text(appLocalizations.connectionsDesc),
      delegate: OpenDelegate(
        title: appLocalizations.connections,
        widget: const ConnectionsView(),
      ),
    );
  }
}

class _RequestsItem extends StatelessWidget {
  const _RequestsItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const Icon(Icons.view_timeline),
      title: Text(appLocalizations.requests),
      subtitle: Text(appLocalizations.requestsDesc),
      delegate: OpenDelegate(
        title: appLocalizations.requests,
        widget: const RequestsView(),
      ),
    );
  }
}

class _DeveloperItem extends StatelessWidget {
  const _DeveloperItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const Icon(Icons.developer_board),
      title: Text(appLocalizations.developerMode),
      delegate: OpenDelegate(
        title: appLocalizations.developerMode,
        widget: const DeveloperView(),
      ),
    );
  }
}

class _ProxiesItem extends StatelessWidget {
  const _ProxiesItem();

  @override
  Widget build(BuildContext context) {
    return ListItem.open(
      leading: const Icon(Icons.article),
      title: Text(appLocalizations.proxies),
      subtitle: Text(appLocalizations.proxiesSetting),
      delegate: OpenDelegate(
        title: appLocalizations.proxies,
        widget: const _ProxiesToolWrapper(),
      ),
    );
  }
}
