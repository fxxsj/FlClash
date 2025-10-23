import 'package:fl_clash/common/app_localizations.dart';
import 'package:fl_clash/common/common.dart';
import 'package:flutter/material.dart';
import 'package:fl_clash/board/models/order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/board/models/payment_method.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

// 桌面模式的订单详情包装器
class OrderDetailSheetWidget extends ConsumerStatefulWidget {
  final OrderModel order;
  final VoidCallback? onOrderUpdated;

  const OrderDetailSheetWidget({
    super.key,
    required this.order,
    this.onOrderUpdated,
  });

  @override
  ConsumerState<OrderDetailSheetWidget> createState() => _OrderDetailSheetWidgetState();
}

class _OrderDetailSheetWidgetState extends ConsumerState<OrderDetailSheetWidget> {
  String _getStatusText(int status) {
    switch (status) {
      case 0:
        return appLocalizations.orderStatusUnpaid;
      case 1:
        return appLocalizations.orderStatusProcessing;
      case 2:
        return appLocalizations.orderStatusCancelled;
      case 3:
        return appLocalizations.orderStatusCompleted;
      case 4:
        return appLocalizations.orderStatusDeducted;
      default:
        return status.toString();
    }
  }

  Color _getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.orange;
      case 1:
        return Colors.green;
      case 2:
        return Colors.amber;
      case 3:
        return Colors.green;
      case 4:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

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
                      Icons.receipt_long_rounded,
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
                          widget.order.getProductName((key) {
                            switch (key) {
                              case 'deposit':
                                return appLocalizations.deposit;
                              case 'unknown':
                                return appLocalizations.unknown;
                              default:
                                return key;
                            }
                          }),
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
            // 内容区域
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                child: OrderDetailSheet(
                  order: widget.order,
                  onOrderUpdated: widget.onOrderUpdated,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderDetailSheet extends ConsumerStatefulWidget {
  final OrderModel order;
  final ScrollController? scrollController;
  final VoidCallback? onOrderUpdated;

  const OrderDetailSheet({
    super.key,
    required this.order,
    this.scrollController,
    this.onOrderUpdated,
  });

  @override
  ConsumerState<OrderDetailSheet> createState() => _OrderDetailSheetState();
}

class _OrderDetailSheetState extends ConsumerState<OrderDetailSheet> {
  bool _cancelling = false;
  Timer? _pollingTimer;
  
  // 支付方式相关状态
  List<PaymentMethodModel>? _paymentMethods;
  bool _loadingPaymentMethods = false;
  String? _paymentMethodsError;
  PaymentMethodModel? _selectedPaymentMethod;
  bool _processing = false;

  @override
  void initState() {
    super.initState();
    if (widget.order.status == 0 || widget.order.status == 1) {
      _startPolling();
    }
    // 如果是未支付订单，加载支付方式
    if (widget.order.status == 0) {
      _loadPaymentMethods();
    }
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  void _startPolling() {
    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      _checkOrderStatus();
    });
  }

  Future<void> _loadPaymentMethods() async {
    setState(() {
      _loadingPaymentMethods = true;
      _paymentMethodsError = null;
    });

    try {
      final api = ref.read(v2boardApiProvider);
      final methods = await api.getPaymentMethods();
      if (mounted) {
        setState(() {
          _paymentMethods = methods;
          _loadingPaymentMethods = false;
          // 默认选择第一个支付方式
          if (methods.isNotEmpty) {
            _selectedPaymentMethod = methods.first;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _paymentMethodsError = e.toString();
          _loadingPaymentMethods = false;
        });
      }
    }
  }

  Future<void> _checkOrderStatus() async {
    try {
      // 首先检查用户是否已认证
      final authState = ref.read(authStateProvider);
      if (!authState.isAuthenticated) {
        // 用户未认证，取消轮询并返回
        _pollingTimer?.cancel();
        _pollingTimer = null;
        return;
      }

      final api = ref.read(v2boardApiProvider);
      final order = await api.getOrderDetail(widget.order.tradeNo);

      if (order.status != widget.order.status) {
        widget.onOrderUpdated?.call();
        // ignore: use_build_context_synchronously
        Navigator.pop(context, true);
      }
    } catch (e) {
      // 忽略查询错误
    }
  }

  DateTime _timestampToDateTime(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  String _formatDateTime(int timestamp) {
    final dateTime = _timestampToDateTime(timestamp);
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: widget.scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 状态指示器（只有已取消状态才显示）
                if (widget.order.status == 2 || widget.order.status == 3) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          widget.order.status == 3 ? Icons.check_circle : Icons.warning_amber,
                          size: 48,
                          color: _getStatusColor(widget.order.status),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getStatusText(widget.order.status),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.order.status == 3 ? appLocalizations.orderCompletedTip : appLocalizations.orderCancelledDueToTimeout,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                
                // 商品信息区域
                _buildProductInfo(),
                const SizedBox(height: 24),
                
                // 订单信息区域
                _buildOrderInfo(),
                
                // 支付方式区域（只有未支付订单才显示）
                if (widget.order.status == 0) ...[
                  const SizedBox(height: 24),
                  _buildPaymentMethods(),
                ],
                
                // 订单总额区域（只有未支付订单才显示）
                if (widget.order.status == 0) ...[
                  const SizedBox(height: 24),
                  _buildOrderTotal(),
                ],
              ],
            ),
          ),
        ),
        // 底部按钮区域
        if (widget.order.status == 0) _buildBottomButton(),
      ],
    );
  }

  String _getPeriodText(String? period) {
    if (period == null) return '';
    switch (period) {
      case 'month_price':
        return appLocalizations.monthlyPlan;
      case 'quarter_price':
        return appLocalizations.quarterlyPlan;
      case 'half_year_price':
        return appLocalizations.halfYearlyPlan;
      case 'year_price':
        return appLocalizations.yearlyPlan;
      case 'two_year_price':
        return appLocalizations.twoYearlyPlan;
      case 'three_year_price':
        return appLocalizations.threeYearlyPlan;
      case 'onetime_price':
        return appLocalizations.onetimePlan;
      case 'reset_price':
        return appLocalizations.resetTraffic;
      default:
        return period;
    }
  }

  Color _getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.orange;
      case 1:
        return Colors.green;
      case 2:
        return Colors.amber;
      case 3:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(int status) {
    switch (status) {
      case 0:
        return appLocalizations.orderStatusUnpaid;
      case 1:
        return appLocalizations.orderStatusProcessing;
      case 2:
        return appLocalizations.orderStatusCancelled;
      case 3:
        return appLocalizations.orderStatusCompleted;
      case 4:
        return appLocalizations.orderStatusDeducted;
      default:
        return status.toString();
    }
  }

  // 构建商品信息区域
  Widget _buildProductInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.productInfo,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildInfoRow('${appLocalizations.productName}：', widget.order.getProductName((key) {
            switch (key) {
              case 'deposit':
                return appLocalizations.deposit;
              case 'unknown':
                return appLocalizations.unknown;
              default:
                return key;
            }
          })),
          const SizedBox(height: 8),
          _buildInfoRow('${appLocalizations.typePeriod}：', widget.order.planId == 0 ? appLocalizations.deposit : _getPeriodText(widget.order.period)),
          const SizedBox(height: 8),
          if (widget.order.planId != 0) // 只有非充值订单才显示流量
            _buildInfoRow('${appLocalizations.productTraffic}：', '${widget.order.plan?.transferEnable ?? 0} GB'),
        ],
      ),
    );
  }

  // 构建订单信息区域
  Widget _buildOrderInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appLocalizations.orderInfo,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (widget.order.status == 0)
                OutlinedButton(
                  onPressed: _cancelling ? null : () => _handleCancel(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                  child: _cancelling
                      ? const SizedBox(
                          width: 12,
                          height: 12,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(appLocalizations.closeOrder),
                ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoRow('${appLocalizations.orderNumber}：', widget.order.tradeNo),
          // 如果有优惠金额，显示优惠信息
          if (widget.order.discountAmount != null && widget.order.discountAmount! > 0) ...[
            const SizedBox(height: 8),
            _buildInfoRow('${appLocalizations.discountAmount}：', '¥${(widget.order.discountAmount! / 100).toStringAsFixed(2)}'),
          ],
          const SizedBox(height: 8),
          _buildInfoRow('${appLocalizations.createdAt}：', _formatDateTime(widget.order.createdAt)),
        ],
      ),
    );
  }

  // 构建支付方式区域
  Widget _buildPaymentMethods() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.paymentMethod,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          if (_loadingPaymentMethods)
            const Center(child: CircularProgressIndicator())
          else if (_paymentMethodsError != null)
            Center(
              child: Column(
                children: [
                  Text(_paymentMethodsError!),
                  TextButton(
                    onPressed: _loadPaymentMethods,
                    child: Text(appLocalizations.retry),
                  ),
                ],
              ),
            )
          else if (_paymentMethods?.isEmpty ?? true)
            Center(child: Text(appLocalizations.noPaymentMethods))
          else
            Column(
              children: _paymentMethods!.map((method) {
                final isSelected = _selectedPaymentMethod == method;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = method;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).dividerColor,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            method.name,
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : null,
                              fontWeight: isSelected ? FontWeight.bold : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  // 构建订单总额区域
  Widget _buildOrderTotal() {
    final hasDiscount = widget.order.discountAmount != null && widget.order.discountAmount! > 0;
    final originalAmount = hasDiscount 
        ? widget.order.totalAmount + widget.order.discountAmount!
        : widget.order.totalAmount;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.orderTotal,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          // 商品原价
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.order.planId == 0 
                  ? widget.order.getProductName((key) {
                      switch (key) {
                        case 'deposit':
                          return appLocalizations.deposit;
                        case 'unknown':
                          return appLocalizations.unknown;
                        default:
                          return key;
                      }
                    })
                  : '${widget.order.getProductName((key) {
                      switch (key) {
                        case 'deposit':
                          return appLocalizations.deposit;
                        case 'unknown':
                          return appLocalizations.unknown;
                        default:
                          return key;
                      }
                    })} x ${_getPeriodText(widget.order.period)}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                '¥${(originalAmount / 100).toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          
          // 如果有折扣，显示折扣行
          if (hasDiscount) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appLocalizations.discount,
                  style: const TextStyle(fontSize: 16, color: Colors.green),
                ),
                Text(
                  '-¥${(widget.order.discountAmount! / 100).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16, color: Colors.green),
                ),
              ],
            ),
          ],
          
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appLocalizations.total,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '¥ ${(widget.order.totalAmount / 100).toStringAsFixed(2)} CNY',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 构建底部按钮
  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: FilledButton(
        onPressed: (_processing || _selectedPaymentMethod == null)
            ? null
            : () => _handleDirectPayment(context),
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          backgroundColor: const Color(0xFF007AFF),
        ),
        child: _processing
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                appLocalizations.checkout,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
      ),
    );
  }

  // 构建信息行
  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  // 直接支付处理（不再打开新页面）
  Future<void> _handleDirectPayment(BuildContext context) async {
    if (_selectedPaymentMethod == null) return;

    setState(() => _processing = true);

    try {
      final api = ref.read(v2boardApiProvider);
      final paymentUrl = await api.getPaymentUrl(
        widget.order.tradeNo,
        methodId: _selectedPaymentMethod!.id,
      );

      if (context.mounted) {
        if (paymentUrl['type'] == 1 && paymentUrl['data'] is String) {
          final url = Uri.parse(paymentUrl['data']);
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
            // 支付后返回，需要刷新订单状态
            widget.onOrderUpdated?.call();
            Navigator.pop(context, true);
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
    } finally {
      if (mounted) {
        setState(() => _processing = false);
      }
    }
  }

  Future<void> _handleCancel(BuildContext context) async {
    // 先显示确认对话框
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(appLocalizations.tip),
        content: Text(appLocalizations.cancelOrderConfirmTip),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(appLocalizations.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(appLocalizations.confirm),
          ),
        ],
      ),
    );

    // 如果用户确认取消订单
    if (confirm == true && mounted) {
      setState(() => _cancelling = true);

      try {
        final api = ref.read(v2boardApiProvider);
        await api.cancelOrder(widget.order.tradeNo);

        if (context.mounted) {
          widget.onOrderUpdated?.call();
          Navigator.pop(context, true);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _cancelling = false);
        }
      }
    }
  }
}
