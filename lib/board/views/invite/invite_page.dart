import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/app_localizations.dart';
import 'package:fl_clash/board/models/invite_info.dart';
import 'package:fl_clash/board/api/api_exception.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/board/views/invite/components/commission_transfer_dialog.dart';
import 'package:fl_clash/board/views/invite/commission_transfer_page.dart';
import 'package:fl_clash/board/views/invite/components/withdraw_dialog.dart';
import 'package:fl_clash/board/views/invite/withdraw_page.dart';
import 'package:fl_clash/board/views/invite/invite_details_page.dart';
import 'package:fl_clash/board/views/invite/components/invite_details_dialog.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/state.dart';

/// 邀请好友页面状态
final inviteInfoProvider = StateNotifierProvider<InviteInfoNotifier, AsyncValue<InviteInfoModel>>((ref) {
  return InviteInfoNotifier(ref);
});

/// 用户配置状态
final userConfigProvider = StateNotifierProvider<UserConfigNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return UserConfigNotifier(ref);
});

class UserConfigNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final Ref ref;

  UserConfigNotifier(this.ref) : super(const AsyncValue.loading()) {
    loadUserConfig();
  }

  Future<void> loadUserConfig() async {
    try {
      state = const AsyncValue.loading();
      final api = ref.read(v2boardApiProvider);
      final config = await api.getUserConfig();
      state = AsyncValue.data(config);
    } on ApiException catch (e) {
      state = AsyncValue.error(e.message, StackTrace.current);
    } catch (e) {
      state = AsyncValue.error('加载用户配置失败: $e', StackTrace.current);
    }
  }
}

class InviteInfoNotifier extends StateNotifier<AsyncValue<InviteInfoModel>> {
  final Ref ref;

  InviteInfoNotifier(this.ref) : super(const AsyncValue.loading()) {
    loadInviteInfo();
  }

  /// 加载邀请信息
  Future<void> loadInviteInfo() async {
    try {
      state = const AsyncValue.loading();
      final api = ref.read(v2boardApiProvider);
      final data = await api.getInviteInfo();
      final inviteInfo = InviteInfoModel.fromApiData(data);
      state = AsyncValue.data(inviteInfo);
    } on ApiException catch (e) {
      state = AsyncValue.error(e.message, StackTrace.current);
    } catch (e) {
      state = AsyncValue.error('加载邀请信息失败: $e', StackTrace.current);
    }
  }

  /// 生成新的邀请码
  Future<bool> generateInviteCode() async {
    try {
      final api = ref.read(v2boardApiProvider);
      await api.generateInviteCode();
      // 重新加载数据
      await loadInviteInfo();
      return true;
    } on ApiException catch (e) {
      state = AsyncValue.error(e.message, StackTrace.current);
      return false;
    } catch (e) {
      state = AsyncValue.error('生成邀请码失败: $e', StackTrace.current);
      return false;
    }
  }
}

/// 邀请好友Sheet页面
class InvitePage extends ConsumerWidget {
  const InvitePage({super.key = const GlobalObjectKey(PageLabel.inviteFriends)});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inviteInfoState = ref.watch(inviteInfoProvider);

    return inviteInfoState.when(
      data: (inviteInfo) => _buildContent(context, inviteInfo, ref),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => _buildErrorWidget(context, error.toString(), ref),
    );
  }

  Widget _buildContent(BuildContext context, InviteInfoModel inviteInfo, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: RefreshIndicator(
        onRefresh: () => ref.read(inviteInfoProvider.notifier).loadInviteInfo(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 余额信息
              _buildBalanceSection(context, inviteInfo),
              
              const SizedBox(height: 24),
              
              // 操作按钮
              _buildActionButtons(context, inviteInfo, ref),
              
              const SizedBox(height: 24),
              
              // 佣金信息
              _buildCommissionSection(context, inviteInfo),
              
              const SizedBox(height: 24),
              
              // 邀请码管理
              _buildInviteCodesSection(context, inviteInfo, ref),
            ],
          ),
        ),
      ),
    );
  }

  /// 余额信息部分
  Widget _buildBalanceSection(BuildContext context, InviteInfoModel inviteInfo) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.myInvite,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.outline,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                inviteInfo.readableCurrentBalance,
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'CNY',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.outline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            appLocalizations.currentRemainingCommission,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  /// 操作按钮部分
  Widget _buildActionButtons(BuildContext context, InviteInfoModel inviteInfo, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _handleTransfer(context, inviteInfo, ref),
            icon: const Icon(Icons.swap_horiz),
            label: Text(appLocalizations.transfer),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _handlePromoteWithdraw(context, inviteInfo, ref),
            icon: const Icon(Icons.account_balance_wallet),
            label: Text(appLocalizations.commissionWithdrawal),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  /// 佣金信息部分
  Widget _buildCommissionSection(BuildContext context, InviteInfoModel inviteInfo) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // 标题和按钮
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appLocalizations.myCommission,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () => _handleCommissionHistory(context),
                  child: Text(appLocalizations.distributionRecord),
                ),
              ],
            ),
          ),
          
          // 佣金信息列表
          _buildCommissionItem(
            appLocalizations.registeredUsersCount,
            '${inviteInfo.registeredCount}人'
          ),
          _buildCommissionItem(
            appLocalizations.commissionRate,
            '${inviteInfo.commissionRate}%'
          ),
          _buildCommissionItem(
            appLocalizations.pendingCommission,
            '¥ ${inviteInfo.readablePendingCommission}'
          ),
          _buildCommissionItem(
            appLocalizations.totalCommissionEarned,
            '¥ ${inviteInfo.readableTotalCommission}'
          ),
        ],
      ),
    );
  }

  Widget _buildCommissionItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  /// 邀请码管理部分
  Widget _buildInviteCodesSection(BuildContext context, InviteInfoModel inviteInfo, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // 标题和生成按钮
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appLocalizations.inviteCodeManagement,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () => _handleGenerateInviteCode(context, ref),
                  child: Text(appLocalizations.generateInviteCodeButton),
                ),
              ],
            ),
          ),
          
          // 邀请码列表
          if (inviteInfo.codes.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(
                    Icons.code,
                    size: 48,
                    color: colorScheme.outline,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    appLocalizations.noInviteCode,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.outline,
                    ),
                  ),
                ],
              ),
            )
          else
            ...inviteInfo.codes.map((code) => _buildInviteCodeItem(context, code, ref)),
        ],
      ),
    );
  }

  Widget _buildInviteCodeItem(BuildContext context, dynamic code, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // 确保 code 有正确的属性
    final codeString = code.code?.toString() ?? '';
    final createTime = code.createdAt != null 
        ? DateTime.fromMillisecondsSinceEpoch(code.createdAt * 1000).toString().substring(0, 16)
        : '';

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      codeString,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      createTime,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => _handleCopyInviteLink(context, codeString, ref),
            child: Text(appLocalizations.copyLinkButton),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String error, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              appLocalizations.loadFailed,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(inviteInfoProvider.notifier).loadInviteInfo(),
              child: Text(appLocalizations.retryButton),
            ),
          ],
        ),
      ),
    );
  }

  // 事件处理方法
  Future<void> _handleTransfer(BuildContext context, InviteInfoModel inviteInfo, WidgetRef ref) async {
    if (inviteInfo.currentBalance <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(appLocalizations.zeroCommissionBalanceTransfer)),
      );
      return;
    }

    final viewMode = globalState.appController.viewMode;
    
    if (viewMode == ViewMode.mobile) {
      final result = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (context) => CommissionTransferPage(inviteInfo: inviteInfo),
        ),
      );

      if (result == true) {
        // 刷新邀请信息
        ref.read(inviteInfoProvider.notifier).loadInviteInfo();
      }
    } else {
      // 桌面模式使用弹窗，与订单详情和工单详情保持一致
      final result = await showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: CommissionTransferSheetWidget(inviteInfo: inviteInfo),
          );
        },
      );

      if (result == true) {
        // 刷新邀请信息
        ref.read(inviteInfoProvider.notifier).loadInviteInfo();
      }
    }
  }

  Future<void> _handlePromoteWithdraw(BuildContext context, InviteInfoModel inviteInfo, WidgetRef ref) async {
    if (inviteInfo.currentBalance <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(appLocalizations.zeroCommissionBalanceWithdraw)),
      );
      return;
    }

    final viewMode = globalState.appController.viewMode;
    
    if (viewMode == ViewMode.mobile) {
      // 直接跳转到提现页面，让页面自己处理配置加载
      final result = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (context) => WithdrawPage(inviteInfo: inviteInfo),
        ),
      );

      if (result == true) {
        // 刷新邀请信息
        ref.read(inviteInfoProvider.notifier).loadInviteInfo();
      }
    } else {
      // 桌面模式使用弹窗，与订单详情和工单详情保持一致
      final result = await showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: WithdrawSheetWidget(inviteInfo: inviteInfo),
          );
        },
      );

      if (result == true) {
        // 刷新邀请信息
        ref.read(inviteInfoProvider.notifier).loadInviteInfo();
      }
    }
  }

  void _handleCommissionHistory(BuildContext context) {
    final viewMode = globalState.appController.viewMode;
    
    if (viewMode == ViewMode.mobile) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const InviteDetailsPage(),
        ),
      );
    } else {
      // 桌面模式使用弹窗，与其他弹窗保持一致
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return const Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: InviteDetailsSheetWidget(),
          );
        },
      );
    }
  }

  Future<void> _handleGenerateInviteCode(BuildContext context, WidgetRef ref) async {
    try {
      final api = ref.read(v2boardApiProvider);
      await api.generateInviteCode();
      // 重新加载数据
      await ref.read(inviteInfoProvider.notifier).loadInviteInfo();
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(appLocalizations.inviteCodeGenerateSuccess)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('生成邀请码失败: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  Future<void> _handleCopyInviteLink(BuildContext context, String code, WidgetRef ref) async {
    if (code.isEmpty) return;
    
    try {
      final authState = ref.read(authStateProvider);
      final appUrl = authState.appUrl;
      
      if (appUrl == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(appLocalizations.appUrlNotConfigured)),
        );
        return;
      }
      
      // 构建邀请链接
      final inviteLink = '$appUrl/#/register?code=$code';
      
      await Clipboard.setData(ClipboardData(text: inviteLink));
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(appLocalizations.inviteLinkCopiedToClipboard)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('复制失败: $e')),
        );
      }
    }
  }
}