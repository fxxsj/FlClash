import 'package:fl_clash/common/app_localizations.dart';
import 'package:fl_clash/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/models/plan.dart';
import 'package:fl_clash/board/models/order.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/board/views/purchase/components/purchase_flow.dart';
import 'package:fl_clash/board/views/orders/components/order_detail_sheet.dart';
import 'package:fl_clash/board/views/orders/order_list_page.dart';
import 'package:fl_clash/board/widgets/active_builder.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:fl_clash/providers/app.dart';

class PurchaseFragment extends ConsumerStatefulWidget {
  const PurchaseFragment({super.key});

  @override
  ConsumerState<PurchaseFragment> createState() => _PurchaseFragmentState();
}

class _PurchaseFragmentState extends ConsumerState<PurchaseFragment> {
  List<PlanModel>? _plans;
  bool _isLoading = false;
  String? _error;
  bool _hasInitialized = false;
  PurchaseStep _currentStep = PurchaseStep.selectPlan;
  String? _selectedPeriod;
  final GlobalKey<PurchaseFlowState> _purchaseFlowKey = GlobalKey<PurchaseFlowState>();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_hasInitialized) {
        _loadPlans();
      }
    });
  }

  void dispose() {
    super.dispose();
  }

  Future<void> _loadPlans() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _error = null;
      _hasInitialized = true;
    });

    try {
      final api = ref.read(v2boardApiProvider);
      final plans = await api.getPlans();
      if (mounted) {
        setState(() {
          _plans = plans;
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

  Future<OrderModel> _handleCreateOrder(
      PlanModel plan, String period, String? couponCode) async {
    final api = ref.read(v2boardApiProvider);
    final tradeNo = await api.createOrder(
      plan.id,
      period,
      couponCode: couponCode,
    );

    final order = await api.getOrderDetail(tradeNo);

    if (context.mounted) {
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
              onBack: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommonScaffold.open(
                      title: appLocalizations.myOrders,
                      actions: const [],
                      body: const OrderListPage(),
                      onBack: () => Navigator.pop(context),
                    ),
                  ),
                );
              },
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

  void _initScaffold() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (!mounted) return;
        final commonScaffoldState =
            context.findAncestorStateOfType<CommonScaffoldState>();
        final authState = ref.read(authStateProvider);

        if (authState.isAuthenticated) {
          commonScaffoldState?.actions = [
            IconButton(
              onPressed: () {
                _hasInitialized = false;
                _loadPlans();
              },
              icon: const Icon(Icons.refresh),
              tooltip: appLocalizations.refresh,
            ),
          ];
          commonScaffoldState?.floatingActionButton = _buildFloatingActionButton();
          
          // 根据当前步骤设置返回按钮
          if (_currentStep != PurchaseStep.selectPlan) {
            commonScaffoldState?.leading = IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                _handleBackButton();
              },
            );
          } else {
            commonScaffoldState?.leading = null;
          }
        } else {
          commonScaffoldState?.actions = const [];
          commonScaffoldState?.floatingActionButton = null;
          commonScaffoldState?.leading = null;
        }
      },
    );
  }

  void _handleBackButton() {
    _purchaseFlowKey.currentState?.executeBack();
  }

  Widget? _buildFloatingActionButton() {
    switch (_currentStep) {
      case PurchaseStep.selectPlan:
        return null; // 购买列表时不显示按钮
      case PurchaseStep.selectPeriod:
        // 只有选择了周期后才显示下一步按钮
        if (_selectedPeriod == null) {
          return null;
        }
        return FloatingActionButton.extended(
          onPressed: () {
            _purchaseFlowKey.currentState?.executeNext();
          },
          label: Text(appLocalizations.next),
          icon: const Icon(Icons.arrow_forward),
        );
      case PurchaseStep.verifyCoupon:
        return FloatingActionButton.extended(
          onPressed: () {
            _purchaseFlowKey.currentState?.executeCreateOrder();
          },
          label: Text(appLocalizations.createOrder),
          icon: const Icon(Icons.shopping_cart),
        );
    }
  }


  @override
  Widget build(BuildContext context) {
    ref.listen<PageLabel>(
      currentPageLabelProvider,
      (previous, next) {
        if (previous == PageLabel.purchase && next != PageLabel.purchase) {
          if (mounted) {
            final commonScaffoldState =
                context.findAncestorStateOfType<CommonScaffoldState>();
            commonScaffoldState?.leading = null;
            commonScaffoldState?.floatingActionButton = null;
          }
        }
      },
    );
    final authState = ref.watch(authStateProvider);

    return ActiveBuilder(
      label: "purchase",
      builder: (isCurrent, child) {
        if (isCurrent && mounted) {
          _initScaffold();
        }
        return child!;
      },
      child: Builder(
        builder: (context) {
          if (!authState.isAuthenticated) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '请先登录',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '登录后查看和购买套餐',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
            );
          }

          return Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.ap).copyWith(
                bottom: 88,
              ),
              child: _buildPurchaseContent(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPurchaseContent() {
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
              Text(_error!),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadPlans,
                child: Text(appLocalizations.retry),
              ),
            ],
          ),
        ),
      );
    }

    if (_plans?.isEmpty ?? true) {
      return SizedBox(
        height: 300,
        child: Center(
          child: Text(appLocalizations.noPlans),
        ),
      );
    }

    return PurchaseFlow(
      key: _purchaseFlowKey,
      plans: _plans!,
      onSubmit: _handleCreateOrder,
      onVerifyCoupon: (planId, code) async {
        final api = ref.read(v2boardApiProvider);
        final result = await api.checkCoupon(planId, code);
        return result;
      },
      currentPlanId: ref.watch(userStateProvider).user?.planId,
      onStepChanged: (step) {
        setState(() {
          _currentStep = step;
        });
        _initScaffold();
      },
      onPeriodChanged: (period) {
        setState(() {
          _selectedPeriod = period;
        });
        _initScaffold();
      },
    );
  }
}
