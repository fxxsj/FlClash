import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/models/invite_info.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/common/app_localizations.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/board/views/invite/withdraw_page.dart';

// 桌面端提现弹窗包装器
class WithdrawSheetWidget extends StatelessWidget {
  final InviteInfoModel inviteInfo;

  const WithdrawSheetWidget({
    super.key,
    required this.inviteInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: 900,
        height: 700,
        constraints: const BoxConstraints(
          minWidth: 800,
          maxWidth: 1000,
          minHeight: 600,
          maxHeight: 800,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withValues(alpha: 0.15),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            // 标题栏
            Container(
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.12),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.account_balance_wallet,
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          appLocalizations.applyWithdrawal,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // 关闭对话框按钮
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.outline,
                        size: 20,
                      ),
                      tooltip: appLocalizations.cancel,
                    ),
                  ),
                ],
              ),
            ),
            // 内容区域 - 直接嵌入原有页面的内容，移除AppBar
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                child: WithdrawPageContent(inviteInfo: inviteInfo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 将原有页面的内容逻辑提取为独立组件
class WithdrawPageContent extends ConsumerStatefulWidget {
  final InviteInfoModel inviteInfo;

  const WithdrawPageContent({
    super.key,
    required this.inviteInfo,
  });

  @override
  ConsumerState<WithdrawPageContent> createState() => _WithdrawPageContentState();
}

class _WithdrawPageContentState extends ConsumerState<WithdrawPageContent> {
  final _formKey = GlobalKey<FormState>();
  final _accountController = TextEditingController();
  String? _selectedMethod;
  bool _isLoading = false;
  bool _isLoadingConfig = true;
  List<String> _withdrawMethods = [];
  bool _withdrawClose = false;
  String? _configError;

  @override
  void initState() {
    super.initState();
    _loadUserConfig();
  }

  @override
  void dispose() {
    _accountController.dispose();
    super.dispose();
  }

  Future<void> _loadUserConfig() async {
    try {
      setState(() {
        _isLoadingConfig = true;
        _configError = null;
      });

      final api = ref.read(v2boardApiProvider);
      final config = await api.getUserConfig();
      
      final withdrawMethods = (config['withdraw_methods'] as List?)
          ?.map((e) => e.toString())
          .toList() ?? [appLocalizations.alipay, 'USDT', 'Paypal'];
      
      final withdrawClose = config['withdraw_close'] == 1;

      if (mounted) {
        setState(() {
          _withdrawMethods = withdrawMethods;
          _withdrawClose = withdrawClose;
          _isLoadingConfig = false;
          // 默认选中第一个提现方式
          if (_withdrawMethods.isNotEmpty) {
            _selectedMethod = _withdrawMethods.first;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingConfig = false;
          _configError = '${appLocalizations.loadFailedMsg}: $e';
        });
      }
    }
  }

  String? _validateMethod(String? value) {
    if (value == null || value.isEmpty) {
      return appLocalizations.pleaseSelectWithdrawalMethod;
    }
    return null;
  }

  String? _validateAccount(String? value) {
    if (value == null || value.isEmpty) {
      return appLocalizations.pleaseEnterWithdrawalAccount;
    }
    return null;
  }

  String _getAccountHint() {
    if (_selectedMethod == appLocalizations.alipay) {
      return appLocalizations.pleaseEnterAlipayAccount;
    } else if (_selectedMethod == 'USDT') {
      return appLocalizations.pleaseEnterUsdtWalletAddress;
    } else if (_selectedMethod == 'Paypal') {
      return appLocalizations.pleaseEnterPaypalAccount;
    } else {
      return appLocalizations.pleaseEnterWithdrawalAccount;
    }
  }

  String _getAccountLabel() {
    if (_selectedMethod == appLocalizations.alipay) {
      return appLocalizations.alipay;
    } else if (_selectedMethod == 'USDT') {
      return appLocalizations.usdtWalletAddress;
    } else if (_selectedMethod == 'Paypal') {
      return appLocalizations.paypalAccount;
    } else {
      return appLocalizations.withdrawalAccountLabel;
    }
  }

  Future<void> _handleWithdraw() async {
    if (!_formKey.currentState!.validate()) return;

    // 检查提现功能是否关闭
    if (_withdrawClose) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(appLocalizations.withdrawalFunctionClosed)),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final api = ref.read(v2boardApiProvider);
      await api.withdrawCommission(
        withdrawMethod: _selectedMethod!,
        withdrawAccount: _accountController.text,
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(appLocalizations.withdrawalApplicationSubmitted),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true); // 返回成功状态
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${appLocalizations.applicationFailed}: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Expanded(
            child: _buildBody(theme, colorScheme),
          ),
          // 底部按钮 - 只有在非加载状态且无错误时显示
          if (!_isLoadingConfig && _configError == null && !_withdrawClose)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Theme.of(context).dividerColor),
                ),
              ),
              child: FilledButton(
                onPressed: _isLoading ? null : _handleWithdraw,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        appLocalizations.submitBtnText,
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBody(ThemeData theme, ColorScheme colorScheme) {
    if (_isLoadingConfig) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(appLocalizations.loadingConfig),
          ],
        ),
      );
    }

    if (_configError != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              appLocalizations.loadFailedMsg,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              _configError!,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.outline,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadUserConfig,
              child: Text(appLocalizations.retryBtnText),
            ),
          ],
        ),
      );
    }

    if (_withdrawClose) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.block,
              size: 64,
              color: colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              appLocalizations.withdrawalFunctionDisabled,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              appLocalizations.withdrawalSystemTemporarilyClosed,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.outline,
              ),
            ),
          ],
        ),
      );
    }

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 可提现金额显示
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.availableWithdrawalAmount,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.inviteInfo.readableCurrentBalance,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
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
                    appLocalizations.allCommissionBalanceWillBeApplied,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),

            // 提现方式选择
            Text(
              appLocalizations.withdrawalMethodLabel,
              style: theme.textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedMethod,
              validator: _validateMethod,
              decoration: InputDecoration(
                hintText: appLocalizations.pleaseSelectWithdrawalMethod,
                filled: true,
                fillColor: colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabled: !_isLoading,
              ),
              items: _withdrawMethods.map((method) {
                return DropdownMenuItem<String>(
                  value: method,
                  child: Row(
                    children: [
                      _getMethodIcon(method),
                      const SizedBox(width: 12),
                      Text(method),
                    ],
                  ),
                );
              }).toList(),
              onChanged: _isLoading ? null : (value) {
                setState(() {
                  _selectedMethod = value;
                  _accountController.clear(); // 清空之前输入的账号
                });
              },
            ),
            
            const SizedBox(height: 24),

            // 提现账号输入
            Text(
              _getAccountLabel(),
              style: theme.textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _accountController,
              validator: _validateAccount,
              decoration: InputDecoration(
                hintText: _getAccountHint(),
                filled: true,
                fillColor: colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabled: !_isLoading,
              ),
            ),

            const SizedBox(height: 24),

            // 重要提醒
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blue.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.blue,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appLocalizations.withdrawalInstructions,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          appLocalizations.withdrawalInstructionsText,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.blue.shade700,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getMethodIcon(String method) {
    if (method == appLocalizations.alipay) {
      return Icon(
        Icons.payment,
        color: Theme.of(context).colorScheme.primary,
        size: 20,
      );
    } else if (method == 'USDT') {
      return Icon(
        Icons.currency_bitcoin,
        color: Theme.of(context).colorScheme.primary,
        size: 20,
      );
    } else if (method == 'Paypal') {
      return Icon(
        Icons.account_balance_wallet,
        color: Theme.of(context).colorScheme.primary,
        size: 20,
      );
    } else {
      return Icon(
        Icons.account_balance,
        color: Theme.of(context).colorScheme.primary,
        size: 20,
      );
    }
  }
}