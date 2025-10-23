import 'package:fl_clash/common/app_localizations.dart';
import 'package:fl_clash/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fl_clash/board/models/payment_method.dart';

class PaymentMethodSheet extends ConsumerStatefulWidget {
  final String tradeNo;
  final ScrollController? scrollController;

  const PaymentMethodSheet({
    super.key,
    required this.tradeNo,
    this.scrollController,
  });

  @override
  ConsumerState<PaymentMethodSheet> createState() => _PaymentMethodSheetState();
}

class _PaymentMethodSheetState extends ConsumerState<PaymentMethodSheet> {
  List<PaymentMethodModel>? _methods;
  bool _isLoading = true;
  String? _error;
  PaymentMethodModel? _selectedMethod;

  @override
  void initState() {
    super.initState();
    _loadPaymentMethods();
  }

  Future<void> _loadPaymentMethods() async {
    try {
      final api = ref.read(v2boardApiProvider);
      final methods = await api.getPaymentMethods();
      if (mounted) {
        setState(() {
          _methods = methods;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (_error != null)
                  Center(
                    child: Column(
                      children: [
                        Text(_error!),
                        TextButton(
                          onPressed: _loadPaymentMethods,
                          child: Text(appLocalizations.retry),
                        ),
                      ],
                    ),
                  )
                else if (_methods?.isEmpty ?? true)
                  Center(child: Text(appLocalizations.noData))
                else
                  Column(
                    children: _methods!
                        .map(
                          (method) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedMethod =
                                      _selectedMethod == method ? null : method;
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: _selectedMethod == method
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .surfaceVariant,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      method.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: _selectedMethod == method
                                            ? Colors.white
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.color,
                                      ),
                                    ),
                                    if (method.handlingFeePercent > 0)
                                      Text(
                                        '${appLocalizations.orderDiscount}: ${method.handlingFeePercent}%',
                                        style: TextStyle(
                                          color: _selectedMethod == method
                                              ? Colors.white70
                                              : Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: FilledButton(
            onPressed: _selectedMethod != null
                ? () => _handlePayment(context, _selectedMethod!)
                : null,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
            child: Text(appLocalizations.confirmPayment),
          ),
        ),
      ],
    );
  }

  Future<void> _handlePayment(
      BuildContext context, PaymentMethodModel method) async {
    try {
      final api = ref.read(v2boardApiProvider);
      final paymentUrl =
          await api.getPaymentUrl(widget.tradeNo, methodId: method.id);

      if (context.mounted) {
        if (paymentUrl['type'] == 1 && paymentUrl['data'] is String) {
          final url = Uri.parse(paymentUrl['data']);
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
            Navigator.pop(context, true); // 返回 true 表示需要刷新订单列表
          }
        } else {
          throw Exception('Invalid payment URL format');
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(appLocalizations.paymentFailed(e.toString()))),
        );
      }
    }
  }
}
