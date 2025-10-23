import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/models/invite_info.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/board/constants/app_config.dart';
import 'package:fl_clash/common/app_localizations.dart';
import 'package:fl_clash/widgets/widgets.dart';

class CommissionTransferPage extends ConsumerStatefulWidget {
  final InviteInfoModel inviteInfo;

  const CommissionTransferPage({
    super.key,
    required this.inviteInfo,
  });

  @override
  ConsumerState<CommissionTransferPage> createState() => _CommissionTransferPageState();
}

class _CommissionTransferPageState extends ConsumerState<CommissionTransferPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _handleTransfer() async {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.parse(_amountController.text);
    
    setState(() {
      _isLoading = true;
    });

    try {
      final api = ref.read(v2boardApiProvider);
      await api.transferCommission(amount);
      
      if (context.mounted) {
        Navigator.of(context).pop(true); // 返回 true 表示成功
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(appLocalizations.commissionTransferSuccess),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(appLocalizations.commissionTransferFailed(e.toString())),
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

    return CommonScaffold(
      title: appLocalizations.transferCommissionToBalance,
      centerTitle: true,
      leading: IconButton(
        icon: const BackButtonIcon(),
        onPressed: () => Navigator.pop(context),
      ),
      automaticallyImplyLeading: false,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 警告提示
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.orange.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.orange,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        appLocalizations.transferredBalanceOnlyForAppConsumption(
                          AppConfig.appTitle,
                        ),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.orange.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 当前推广佣金余额
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      appLocalizations.currentCommissionBalance,
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text(
                      widget.inviteInfo.readableCurrentBalance,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 划转金额输入
              Text(
                appLocalizations.transferAmount,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                decoration: InputDecoration(
                  hintText: appLocalizations.pleaseEnterTransferAmount,
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceVariant,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  suffixText: 'CNY',
                  enabled: !_isLoading,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return appLocalizations.pleaseEnterTransferAmount;
                  }
                  
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return appLocalizations.pleaseEnterValidAmount;
                  }
                  
                  if (amount > widget.inviteInfo.currentBalance / 100) {
                    return appLocalizations.transferAmountCannotExceedCommissionBalance;
                  }
                  
                  return null;
                },
              ),
              
              if (_isLoading) ...[
                const SizedBox(height: 24),
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : _handleTransfer,
          child: Text(
            appLocalizations.confirm,
            style: TextStyle(
              color: _isLoading 
                ? colorScheme.outline 
                : colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}