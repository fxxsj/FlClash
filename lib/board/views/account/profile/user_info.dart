import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/models/models.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fl_clash/board/constants/app_config.dart';
import 'package:flutter/foundation.dart';

class UserInfo extends ConsumerWidget {
  const UserInfo({super.key});

  /// 智能更新订阅配置
  /// 优先尝试更新现有包含token的配置，失败时才进行完全重新订阅
  /// 返回true表示使用现有配置更新，false表示进行了完全重新订阅
  static Future<bool> _smartUpdateSubscription(String token, String subscribeUrl) async {
    final profiles = globalState.config.profiles;
    
    if (kDebugMode) {
      debugPrint('手动智能更新：开始检查现有配置');
      debugPrint('  当前配置数量: ${profiles.length}');
      debugPrint('  目标token: $token');
      debugPrint('  目标URL: $subscribeUrl');
    }
    
    // 查找包含当前token的配置
    List<Profile> tokenProfiles = [];
    for (final profile in profiles) {
      if (profile.url.contains(token)) {
        tokenProfiles.add(profile);
        if (kDebugMode) {
          debugPrint('  找到匹配配置: ${profile.label ?? profile.id} (${profile.id})');
        }
      }
    }
    
    bool updateSuccess = false;
    
    if (tokenProfiles.isNotEmpty) {
      if (kDebugMode) {
        debugPrint('手动智能更新：尝试更新现有配置 (${tokenProfiles.length}个)');
      }
      
      // 尝试更新现有包含token的配置
      for (final profile in tokenProfiles) {
        try {
          if (kDebugMode) {
            debugPrint('  正在更新配置: ${profile.label ?? profile.id}');
          }
          
          // 如果URL已经是最新的，直接更新配置内容
          if (profile.url == subscribeUrl) {
            await globalState.appController.updateProfile(profile);
          } else {
            // 如果URL需要更新，先更新Profile对象的URL再进行更新
            final updatedProfile = profile.copyWith(url: subscribeUrl);
            await globalState.appController.updateProfile(updatedProfile);
          }
          
          updateSuccess = true;
          if (kDebugMode) {
            debugPrint('  ✅ 配置更新成功: ${profile.label ?? profile.id}');
          }
        } catch (e) {
          if (kDebugMode) {
            debugPrint('  ❌ 配置更新失败: ${profile.label ?? profile.id} - $e');
          }
        }
      }
    }
    
    // 如果现有配置更新失败或不存在匹配配置，则进行完全重新订阅
    if (!updateSuccess) {
      if (kDebugMode) {
        debugPrint('手动智能更新：现有配置更新失败，进行完全重新订阅');
      }
      
      // 删除所有现有配置
      for (final profile in profiles) {
        await globalState.appController.deleteProfile(profile.id);
        if (kDebugMode) {
          debugPrint('  删除配置: ${profile.label ?? profile.id}');
        }
      }
      
      // 创建新配置
      final profile = await Profile.normal(url: subscribeUrl).update();
      await globalState.appController.addProfile(profile);
      
      if (kDebugMode) {
        debugPrint('  ✅ 新配置创建成功: ${profile.label ?? profile.id}');
      }
    }
    
    if (kDebugMode) {
      debugPrint('手动智能更新：订阅更新完成 (策略: ${updateSuccess ? "现有配置更新" : "完全重新订阅"})');
    }
    
    return updateSuccess;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userStateProvider);
    
    // 处理加载状态
    if (userState.isLoading) {
      return CommonCard(
        info: Info(
          label: appLocalizations.userInfo,
          iconData: Icons.person,
        ),
        onPressed: () {},
        child: const SizedBox(
          height: 180,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    final user = userState.user;
    final subscribe = userState.subscribe;

    // 处理无数据状态
    if (user == null || subscribe == null) {
      return CommonCard(
        info: Info(
          label: appLocalizations.userInfo,
          iconData: Icons.person,
        ),
        onPressed: () {},
        child: SizedBox(
          height: 180,
          child: Center(
            child: Text(appLocalizations.noInfo),
          ),
        ),
      );
    }
    // 计算流量数据
    final usedTraffic =
        ((subscribe['u'] as num?) ?? 0) + ((subscribe['d'] as num?) ?? 0);
    final totalTraffic = (subscribe['transfer_enable'] as num?) ?? 0;
    final deviceLimit = subscribe['device_limit']?.toString() ?? '∞';
    final aliveIp = (subscribe['alive_ip'] as num?) ?? 0;
    final resetDay = (subscribe['reset_day'] as num?) ?? 0;

    // 转换时间戳为DateTime
    final expiredAt = user.expiredAt != null
        ? DateTime.fromMillisecondsSinceEpoch(user.expiredAt! * 1000)
        : null;

    final daysLeft = expiredAt?.difference(DateTime.now()).inDays ?? 0;

    // 格式量显示
    String formatTraffic(double traffic) {
      if (traffic < 1024) return '${traffic.toStringAsFixed(2)} B';
      if (traffic < 1024 * 1024)
        return '${(traffic / 1024).toStringAsFixed(2)} KB';
      if (traffic < 1024 * 1024 * 1024)
        return '${(traffic / 1024 / 1024).toStringAsFixed(2)} MB';
      return '${(traffic / 1024 / 1024 / 1024).toStringAsFixed(2)} GB';
    }

    return CommonCard(
      info: Info(
        label: user.email,
        iconData: Icons.person,
      ),
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    subscribe['plan']?['name']?.toString() ??
                        appLocalizations.noPlans,
                    style: context.textTheme.titleLarge?.toSoftBold,
                  ),
                ),
                IconButton(
                  onPressed: () => _handleMyAccount(context, ref),
                  icon: const Icon(Icons.account_circle),
                  tooltip: appLocalizations.myAccount,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            if (subscribe['plan'] != null) ...[
              const SizedBox(height: 12),
              Text(
                expiredAt != null
                    ? appLocalizations.expirationInfo(
                          '${expiredAt.year}/${expiredAt.month}/${expiredAt.day}',
                          daysLeft.toString(),
                        ) +
                        (resetDay > 0
                            ? appLocalizations
                                .resetInfo(resetDay.toString())
                            : "")
                    : expiredAt != null && daysLeft < 0
                        ? appLocalizations.expired
                        : appLocalizations.permanentSubscription +
                            (resetDay > 0
                                ? appLocalizations
                                    .resetInfo(resetDay.toString())
                                : ""),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: totalTraffic > 0 ? usedTraffic / totalTraffic : 0,
                backgroundColor: Theme.of(context).dividerColor,
                valueColor: AlwaysStoppedAnimation(
                  usedTraffic / totalTraffic > 0.8
                      ? Colors.red
                      : usedTraffic / totalTraffic > 0.5
                          ? Colors.orange
                          : Colors.green,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                appLocalizations.trafficStats(
                      formatTraffic(usedTraffic.toDouble()),
                      formatTraffic(totalTraffic.toDouble()),
                    ) +
                    (deviceLimit != '∞'
                        ? appLocalizations.onlineStatus(
                            aliveIp.toString(),
                            deviceLimit.toString(),
                          )
                        : ""),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Consumer(
                builder: (context, ref, _) {
                  final profiles = ref.watch(profilesProvider);
                  final userState = ref.watch(userStateProvider);
                  
                  // 查找包含token的配置
                  Profile? tokenProfile;
                  if (userState.user != null && userState.subscribe != null) {
                    final String? token = userState.subscribe!['token'] as String?;
                    if (token != null) {
                      for (final profile in profiles) {
                        if (profile.url.contains(token)) {
                          tokenProfile = profile;
                          break;
                        }
                      }
                    }
                  }
                  
                  // 如果找到了包含token的配置，显示其更新时间
                  if (tokenProfile != null && tokenProfile.lastUpdateDate != null) {
                    final updateTime = tokenProfile.lastUpdateDate!;
                    return Text(
                      "${updateTime.lastUpdateTimeDesc} ${appLocalizations.update}",
                      style: context.textTheme.bodyMedium,
                    );
                  }
                  
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      globalState.appController.toPage(PageLabel.purchase);
                    },
                    icon: const Icon(Icons.shopping_cart),
                    label: Text(appLocalizations.purchase),
                  ),
                  if (subscribe['plan'] != null)
                    OutlinedButton.icon(
                      onPressed: () async {
                        // 显示加载状态
                        globalState.homeScaffoldKey.currentState
                            ?.loadingRun(() async {
                          try {
                            final userStateNotifier = ref.read(userStateProvider.notifier);
                            final subscribeInfo =
                                await userStateNotifier.getSubscribeInfo();

                            if (subscribeInfo == null) {
                              throw Exception(appLocalizations.noInfo);
                            }

                            // 获取token并构建订阅URL
                            final String? token = subscribeInfo['token'] as String?;
                            
                            // 从 subscribe_url 中提取 api/v1/ 后面的部分，然后与 fullApiUrl 组合
                            String? subscribeUrl;
                            if (token != null) {
                              final String? originalUrl = subscribeInfo['url'] as String?;
                              if (originalUrl != null) {
                                // 查找 api/v1/ 的位置
                                final int apiIndex = originalUrl.indexOf('api/v1/');
                                if (apiIndex != -1) {
                                  // 提取 api/v1/ 后面的部分
                                  final String pathAfterApi = originalUrl.substring(apiIndex + 'api/v1/'.length);
                                  subscribeUrl = '${AppConfig.fullApiUrl}/$pathAfterApi';
                                } else {
                                  // 如果没有找到 api/v1/，回退到原来的逻辑
                                  subscribeUrl = '${AppConfig.fullApiUrl}/client/subscribe?token=$token';
                                }
                              } else {
                                // 如果没有原始URL，使用默认逻辑
                                subscribeUrl = '${AppConfig.fullApiUrl}/client/subscribe?token=$token';
                              }
                            }
                            
                            if (token == null || subscribeUrl == null) {
                              throw Exception(appLocalizations.noInfo);
                            }
                            
                            // 智能更新策略：优先使用现有配置更新，避免中断连接
                            final updateResult = await _smartUpdateSubscription(token, subscribeUrl);
                            
                            // 刷新用户状态
                            await userStateNotifier.refresh();
                            
                            // 成功提示
                            if (context.mounted) {
                              globalState.showMessage(
                                title: appLocalizations.tip,
                                message: TextSpan(text: appLocalizations.importSuccess),
                              );
                            }

                          } catch (e) {
                            // 失败提示
                            globalState.showMessage(
                              title: appLocalizations.tip,
                              message: TextSpan(text: e.toString()),
                            );
                          }
                        });
                      },
                      icon: const Icon(Icons.download),
                      label: Text(appLocalizations.sync),
                    ),
                ],
              ),
            ] else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      globalState.appController.toPage(PageLabel.purchase);
                    },
                    icon: const Icon(Icons.shopping_cart),
                    label: Text(appLocalizations.purchase),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// Handler function for "我的账户" navigation
void _handleMyAccount(BuildContext context, WidgetRef ref) async {
  try {
    final api = ref.read(v2boardApiProvider);
    final url = await api.getQuickLoginUrl();
    if (url != null) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    }
  } catch (e) {
    print('获取快速登录链接失败: $e');
  }
}
