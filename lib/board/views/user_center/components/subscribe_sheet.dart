import 'package:fl_clash/common/app_localizations.dart';
import 'package:fl_clash/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/models/plan.dart';
import 'package:fl_clash/board/models/order.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/board/views/purchase/components/purchase_flow.dart';
import 'package:fl_clash/board/views/orders/components/order_detail_sheet.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';

class SubscribeSheet extends ConsumerStatefulWidget {
  const SubscribeSheet({super.key});

  @override
  ConsumerState<SubscribeSheet> createState() => _SubscribeSheetState();
}

class _SubscribeSheetState extends ConsumerState<SubscribeSheet> {
  List<PlanModel>? _plans;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPlans();
  }

  Future<void> _loadPlans() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final api = ref.read(v2boardApiProvider);
      final plans = await api.getPlans();
      print('Loaded plans: $plans');
      setState(() {
        _plans = plans;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading plans: $e');
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<OrderModel> _handleCreateOrder(
      PlanModel plan, String period, String? couponCode) async {
    final api = ref.read(v2boardApiProvider);
    // 1. 调用API创建订单，返回订单号
    final tradeNo = await api.createOrder(
      plan.id,
      period,
      couponCode: couponCode,
    );

    // 2. 获取订单详情
    final order = await api.getOrderDetail(tradeNo);

    if (context.mounted) {
      // 3. 关闭订阅页面
      Navigator.pop(context);

      // 4. 显示订单详情
      if (globalState.appController.viewMode == ViewMode.mobile) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CommonScaffold.open(
              title: appLocalizations.orderDetails,
              actions: const [],
              body: OrderDetailSheet(
                order: order,
              ),
              onBack: () => Navigator.pop(context),
            ),
          ),
        );
      } else {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: OrderDetailSheetWidget(
                order: order,
              ),
            );
          },
        );
      }
    }

    return order;
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      if (_isLoading)
        const ListTile(
          title: Center(child: CircularProgressIndicator()),
        )
      else if (_error != null)
        ListTile(
          title: Center(
            child: Column(
              children: [
                Text(_error!),
                TextButton(
                  onPressed: _loadPlans,
                  child: Text(appLocalizations.retry),
                ),
              ],
            ),
          ),
        )
      else if (_plans?.isEmpty ?? true)
        ListTile(
          title: Center(
            child: Text(appLocalizations.noPlans),
          ),
        )
      else
        PurchaseFlow(
          plans: _plans!,
          onSubmit: _handleCreateOrder,
          onVerifyCoupon: (planId, code) async {
            final api = ref.read(v2boardApiProvider);
            final result = await api.checkCoupon(planId, code);
            return result;
          },
          currentPlanId: ref.watch(userStateProvider).user?.planId,
        ),
    ];

    return Padding(
      padding: kMaterialListPadding.copyWith(
        top: 16,
        bottom: 16,
      ),
      child: generateListView(items),
    );
  }
}

// ignore: unused_element
class _PlanPeriodSheet extends StatelessWidget {
  final PlanModel plan;
  final Function(String period) onSelect;

  const _PlanPeriodSheet({
    required this.plan,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      if (plan.monthPrice > 0)
        ListItem(
          title: Text(appLocalizations.monthlyPlan),
          trailing: Text('¥${(plan.monthPrice / 100).toStringAsFixed(2)}'),
          onTap: () => onSelect('month_price'),
        ),
      if (plan.quarterPrice > 0)
        ListItem(
          title: Text(appLocalizations.quarterlyPlan),
          trailing: Text('¥${(plan.quarterPrice / 100).toStringAsFixed(2)}'),
          onTap: () => onSelect('quarter_price'),
        ),
      if (plan.halfYearPrice > 0)
        ListItem(
          title: Text(appLocalizations.halfYearlyPlan),
          trailing: Text('¥${(plan.halfYearPrice / 100).toStringAsFixed(2)}'),
          onTap: () => onSelect('half_year_price'),
        ),
      if (plan.yearPrice > 0)
        ListItem(
          title: Text(appLocalizations.yearlyPlan),
          trailing: Text('¥${(plan.yearPrice / 100).toStringAsFixed(2)}'),
          onTap: () => onSelect('year_price'),
        ),
      if (plan.twoYearPrice != null && plan.twoYearPrice! > 0)
        ListItem(
          title: Text(appLocalizations.twoYearlyPlan),
          trailing: Text('¥${(plan.twoYearPrice! / 100).toStringAsFixed(2)}'),
          onTap: () => onSelect('two_year_price'),
        ),
      if (plan.threeYearPrice != null && plan.threeYearPrice! > 0)
        ListItem(
          title: Text(appLocalizations.threeYearlyPlan),
          trailing: Text('¥${(plan.threeYearPrice! / 100).toStringAsFixed(2)}'),
          onTap: () => onSelect('three_year_price'),
        ),
      if (plan.onetimePrice != null && plan.onetimePrice! > 0)
        ListItem(
          title: Text(appLocalizations.onetimePlan),
          trailing: Text('¥${(plan.onetimePrice! / 100).toStringAsFixed(2)}'),
          onTap: () => onSelect('onetime_price'),
        ),
      if (plan.resetPrice > 0)
        ListItem(
          title: Text(appLocalizations.resetTraffic),
          trailing: Text('¥${(plan.resetPrice / 100).toStringAsFixed(2)}'),
          onTap: () => onSelect('reset_price'),
        ),
    ];

    return Padding(
      padding: kMaterialListPadding.copyWith(
        top: 16,
        bottom: 16,
      ),
      child: generateListView(items),
    );
  }
}
