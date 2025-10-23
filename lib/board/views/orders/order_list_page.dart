import 'package:fl_clash/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/models/order.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/enum/enum.dart';
import 'components/order_detail_sheet.dart';
import 'package:fl_clash/widgets/widgets.dart';

class OrderListPage extends ConsumerStatefulWidget {
  const OrderListPage({super.key = const GlobalObjectKey(PageLabel.myOrders)});

  @override
  ConsumerState<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends ConsumerState<OrderListPage> {
  List<OrderModel>? _orders;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final api = ref.read(v2boardApiProvider);
      final orders = await api.getOrders();
      setState(() {
        _orders = orders;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
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

  Color _getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.green;
      case 2:
        return Colors.grey;
      case 3: // STATUS_REFUNDED
        return Colors.grey;
      case 4: // STATUS_DEDUCTED
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  

  Widget _buildOrderItem(OrderModel order) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.ap),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).dividerColor,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () async {
            // 区分移动和桌面模式，和用户中心保持一致
            final viewMode = globalState.appController.viewMode;
            bool? shouldRefresh;
            
            if (viewMode == ViewMode.mobile) {
              shouldRefresh = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (context) => CommonScaffold.open(
                    title: appLocalizations.orderDetails,
                    actions: const [],
                    body: OrderDetailSheet(
                      order: order,
                      onOrderUpdated: () {
                        // 标记需要刷新
                        _loadOrders();
                      },
                    ),
                    onBack: () => Navigator.pop(context, true),
                  ),
                ),
              );
            } else {
              // 桌面模式使用居中对话框
              shouldRefresh = await showDialog<bool>(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    child: OrderDetailSheetWidget(
                      order: order,
                      onOrderUpdated: () {
                        // 标记需要刷新
                        _loadOrders();
                      },
                    ),
                  );
                },
              );
            }
            
            // 如果订单有更新，刷新订单列表
            if (shouldRefresh == true) {
              _loadOrders();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.getProductName((key) {
                              switch (key) {
                                case 'deposit':
                                  return appLocalizations.deposit;
                                case 'unknown':
                                  return appLocalizations.unknown;
                                default:
                                  return key;
                              }
                            }),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatDateTime(order.createdAt),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '¥${(order.totalAmount / 100).toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _getStatusColor(order.status),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _getStatusText(order.status),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: _getStatusColor(order.status),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
    return RefreshIndicator(
      onRefresh: _loadOrders,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.ap).copyWith(
          bottom: 88,
        ),
        child: _buildOrderContent(),
      ),
    );
  }

  Widget _buildOrderContent() {
    if (_isLoading) {
      return const SizedBox(
        height: 300,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return SizedBox(
        height: 300,
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
                _error!,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadOrders,
                child: Text(appLocalizations.retry),
              ),
            ],
          ),
        ),
      );
    }

    if (_orders?.isEmpty ?? true) {
      return SizedBox(
        height: 300,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(height: 16),
              Text(
                appLocalizations.noOrdersYet,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                appLocalizations.noOrdersYet,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 订单统计信息（可选）
        Container(
          margin: EdgeInsets.only(bottom: 16.ap),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.receipt_long,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                appLocalizations.totalOrdersCount(_orders!.length),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        // 订单卡片列表
        ..._orders!.map(_buildOrderItem),
      ],
    );
  }
}
