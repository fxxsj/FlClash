import 'package:fl_clash/common/app_localizations.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fl_clash/board/models/plan.dart';
import 'package:fl_clash/board/models/order.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/operation_feedback.dart';

// 购买流程步骤枚举
enum PurchaseStep {
  selectPlan, // 选择套餐
  selectPeriod, // 选择周期
  verifyCoupon, // 验证优惠码
}

// 优化后的状态管理
class _PlanState {
  PlanModel? selectedPlan;
}

class _PeriodState {
  String? selectedPeriod;
}

class _CouponState {
  String? couponCode;
  double? discountedPrice;
  String? couponError;
}

class _PurchaseState {
  final planState = _PlanState();
  final periodState = _PeriodState();
  final couponState = _CouponState();

  PlanModel? get selectedPlan => planState.selectedPlan;
  String? get selectedPeriod => periodState.selectedPeriod;

  void reset() {
    planState.selectedPlan = null;
    periodState.selectedPeriod = null;
    couponState.couponCode = null;
    couponState.discountedPrice = null;
    couponState.couponError = null;
  }
}

class PurchaseFlow extends ConsumerStatefulWidget {
  final List<PlanModel> plans;
  final Future<OrderModel> Function(
      PlanModel plan, String period, String? couponCode) onSubmit;
  final Future<Map<String, dynamic>> Function(int planId, String code)?
      onVerifyCoupon;
  final int? currentPlanId;
  final ValueChanged<PurchaseStep>? onStepChanged;
  final ValueChanged<String?>? onPeriodChanged;
  final VoidCallback? onNextPressed;
  final VoidCallback? onCreateOrderPressed;

  const PurchaseFlow({
    super.key,
    required this.plans,
    required this.onSubmit,
    this.onVerifyCoupon,
    this.currentPlanId,
    this.onStepChanged,
    this.onPeriodChanged,
    this.onNextPressed,
    this.onCreateOrderPressed,
  });

  @override
  ConsumerState<PurchaseFlow> createState() => PurchaseFlowState();
}

class PurchaseFlowState extends ConsumerState<PurchaseFlow> {
  final _state = _PurchaseState();
  PurchaseStep _step = PurchaseStep.selectPlan;
  final _couponController = TextEditingController();
  bool _verifying = false;
  bool _creating = false;

  @override
  void initState() {
    super.initState();
    // 初始化时通知当前步骤
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onStepChanged?.call(_step);
      widget.onPeriodChanged?.call(_state.selectedPeriod);
    });
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  void _updateStep(PurchaseStep newStep) {
    setState(() {
      _step = newStep;
    });
    widget.onStepChanged?.call(newStep);
    widget.onPeriodChanged?.call(_state.selectedPeriod);
  }

  // 公共方法：执行下一步操作
  void executeNext() {
    if (_step == PurchaseStep.selectPeriod && _state.selectedPeriod != null) {
      _updateStep(PurchaseStep.verifyCoupon);
    }
  }

  // 公共方法：执行返回操作
  void executeBack() {
    switch (_step) {
      case PurchaseStep.selectPlan:
        // 在选择套餐页面，不执行任何操作
        break;
      case PurchaseStep.selectPeriod:
        // 从选择周期返回到选择套餐
        setState(() {
          _state.reset();
        });
        _updateStep(PurchaseStep.selectPlan);
        break;
      case PurchaseStep.verifyCoupon:
        // 从优惠码页面返回到选择周期
        setState(() {
          _state.couponState.couponCode = null;
          _state.couponState.discountedPrice = null;
          _state.couponState.couponError = null;
          _couponController.clear();
        });
        _updateStep(PurchaseStep.selectPeriod);
        break;
    }
  }

  // 公共方法：执行创建订单操作
  Future<void> executeCreateOrder() async {
    if (_step == PurchaseStep.verifyCoupon && !_verifying && !_creating) {
      try {
        final order = await ref.executeWithFeedback(
          'create_order',
          '正在创建订单...',
          () => widget.onSubmit(
            _state.selectedPlan!,
            _state.selectedPeriod!,
            _state.couponState.couponCode,
          ),
          successMessage: '订单创建成功',
          timeout: const Duration(seconds: 30),
        );
      } catch (e) {
        // 错误处理已由 executeWithFeedback 处理
        if (kDebugMode) {
          debugPrint('订单创建失败: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return OperationFeedbackWidget(
      showSnackBar: true,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    switch (_step) {
      case PurchaseStep.selectPlan:
        return _PlanSelectionStep(
          plans: widget.plans,
          state: _state,
          onPlanSelected: (plan) {
            setState(() {
              _state.planState.selectedPlan = plan;
            });
            _updateStep(PurchaseStep.selectPeriod);
          },
        );
      case PurchaseStep.selectPeriod:
        return _PeriodSelectionStep(
          state: _state,
          onBack: () {
            setState(() {
              _state.reset();
            });
            _updateStep(PurchaseStep.selectPlan);
          },
          onPeriodSelected: (period) {
            setState(() {
              _state.periodState.selectedPeriod = period;
            });
            widget.onPeriodChanged?.call(period);
          },
          currentPlanId: widget.currentPlanId,
        );
      case PurchaseStep.verifyCoupon:
        return _CouponVerificationStep(
          state: _state,
          couponController: _couponController,
          verifying: _verifying,
          creating: _creating,
          onBack: () {
            setState(() {
              _state.couponState.couponCode = null;
              _state.couponState.discountedPrice = null;
              _state.couponState.couponError = null;
              _couponController.clear();
            });
            _updateStep(PurchaseStep.selectPeriod);
          },
          onVerifyCoupon: () async {
            if (_couponController.text.isEmpty || widget.onVerifyCoupon == null)
              return;

            try {
              final result = await ref.executeWithFeedback(
                'verify_coupon',
                '验证优惠码...',
                () => widget.onVerifyCoupon!(
                  _state.selectedPlan!.id, 
                  _couponController.text
                ),
                successMessage: '优惠码验证成功',
                timeout: const Duration(seconds: 10),
              );

              final originalPrice =
                  _state.selectedPlan!.getPriceByPeriod(_state.selectedPeriod!);
              int discountedPrice = originalPrice;

              if (result['type'] == 2) {
                discountedPrice =
                    (originalPrice * (100 - (result['value'] as num)) / 100)
                        .round();
              } else if (result['type'] == 1) {
                discountedPrice =
                    originalPrice - (result['value'] as num).toInt();
              }

              setState(() {
                _state.couponState.couponCode = _couponController.text;
                _state.couponState.discountedPrice = discountedPrice.toDouble();
                _state.couponState.couponError = null;
              });
            } catch (e) {
              setState(() {
                _state.couponState.couponError = e.toString();
                _state.couponState.couponCode = null;
                _state.couponState.discountedPrice = null;
              });
              
              if (kDebugMode) {
                debugPrint('优惠码验证失败: $e');
              }
            }
          },
        );
    }
  }
}

// 套餐选择步骤
class _PlanSelectionStep extends StatelessWidget {
  final List<PlanModel> plans;
  final _PurchaseState state;
  final Function(PlanModel plan) onPlanSelected;

  const _PlanSelectionStep({
    required this.plans,
    required this.state,
    required this.onPlanSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: plans.length,
          itemBuilder: (context, index) {
            final plan = plans[index];
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
                  onTap: () => onPlanSelected(plan),
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
                                    plan.name,
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.cloud_download,
                                        size: 16,
                                        color: Theme.of(context).colorScheme.outline,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${plan.transferEnableGB} GB',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Theme.of(context).colorScheme.outline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  plan.lowestPriceInfo,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
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
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  
}

// 周期选择步骤
class _PeriodSelectionStep extends StatelessWidget {
  final _PurchaseState state;
  final VoidCallback onBack;
  final Function(String period) onPeriodSelected;
  final int? currentPlanId;

  const _PeriodSelectionStep({
    required this.state,
    required this.onBack,
    required this.onPeriodSelected,
    this.currentPlanId,
  });

  @override
  Widget build(BuildContext context) {
    final plan = state.selectedPlan!;
    final periods = [
      if (plan.monthPrice > 0)
        (appLocalizations.monthlyPlan, plan.monthPrice, 'month_price'),
      if (plan.quarterPrice > 0)
        (appLocalizations.quarterlyPlan, plan.quarterPrice, 'quarter_price'),
      if (plan.halfYearPrice > 0)
        (
          appLocalizations.halfYearlyPlan,
          plan.halfYearPrice,
          'half_year_price'
        ),
      if (plan.yearPrice > 0)
        (appLocalizations.yearlyPlan, plan.yearPrice, 'year_price'),
      if (plan.twoYearPrice != null && plan.twoYearPrice! > 0)
        (appLocalizations.twoYearlyPlan, plan.twoYearPrice!, 'two_year_price'),
      if (plan.threeYearPrice != null && plan.threeYearPrice! > 0)
        (
          appLocalizations.threeYearlyPlan,
          plan.threeYearPrice!,
          'three_year_price'
        ),
      if (plan.onetimePrice != null && plan.onetimePrice! > 0)
        (appLocalizations.onetimePlan, plan.onetimePrice!, 'onetime_price'),
      if (plan.resetPrice > 0 && currentPlanId == plan.id)
        (appLocalizations.resetTraffic, plan.resetPrice, 'reset_price'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 套餐详情卡片
        Container(
          margin: EdgeInsets.only(bottom: 16.ap),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.cloud_download,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${plan.transferEnableGB} GB',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  if (plan.content.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Html(
                      data: plan.content,
                      style: {
                        "body": Style(
                          margin: Margins.zero,
                          padding: HtmlPaddings.zero,
                          fontSize: FontSize(14),
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        // 周期选择卡片列表
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: periods.length,
          itemBuilder: (context, index) {
            final period = periods[index];
            final isSelected = period.$3 == state.selectedPeriod;

            return Container(
              margin: EdgeInsets.only(bottom: 16.ap),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).dividerColor,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    if (state.selectedPeriod != period.$3) {
                      onPeriodSelected(period.$3);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.outline,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                period.$1,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              if (period.$3 == 'year_price') ...[
                                const SizedBox(height: 2),
                                Text(
                                  appLocalizations.mostPopular,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Theme.of(context).colorScheme.primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '¥${(period.$2 / 100).toStringAsFixed(2)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : null,
                                  ),
                            ),
                            if (period.$3 != 'month_price' &&
                                plan.monthPrice > 0) ...[
                              const SizedBox(height: 2),
                              Text(
                                appLocalizations.pricePerMonth((period.$2 / _getMonthCount(period.$3) / 100).toStringAsFixed(2)),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Theme.of(context).colorScheme.outline,
                                    ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // 获取月份数量（用于计算月均价格）
  int _getMonthCount(String period) {
    switch (period) {
      case 'month_price':
        return 1;
      case 'quarter_price':
        return 3;
      case 'half_year_price':
        return 6;
      case 'year_price':
        return 12;
      case 'two_year_price':
        return 24;
      case 'three_year_price':
        return 36;
      default:
        return 1;
    }
  }
}

// 优惠码验证步骤
class _CouponVerificationStep extends StatelessWidget {
  final _PurchaseState state;
  final TextEditingController couponController;
  final bool verifying;
  final bool creating;
  final VoidCallback onBack;
  final VoidCallback onVerifyCoupon;

  const _CouponVerificationStep({
    super.key,
    required this.state,
    required this.couponController,
    required this.verifying,
    required this.creating,
    required this.onBack,
    required this.onVerifyCoupon,
  });

  @override
  Widget build(BuildContext context) {
    final originalPrice =
        state.selectedPlan!.getPriceByPeriod(state.selectedPeriod!);

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(22.ap),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.card_giftcard,
                size: 70,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                appLocalizations.haveCoupon,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 22),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: couponController,
                        decoration: InputDecoration(
                          hintText: appLocalizations.couponCodeHint,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        enabled: !verifying,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                      ),
                      child: verifying
                          ? const SizedBox(
                              width: 48,
                              child: Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                ),
                              ),
                            )
                          : TextButton(
                              onPressed: onVerifyCoupon,
                              style: TextButton.styleFrom(
                                minimumSize: const Size(80, 48),
                              ),
                              child: Text(appLocalizations.verify),
                            ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  state.couponState.couponError ??
                      (state.couponState.discountedPrice != null
                          ? appLocalizations.couponValid
                          : ''),
                  style: TextStyle(
                    color: state.couponState.couponError != null
                        ? Theme.of(context).colorScheme.error
                        : Colors.green,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Text(state.selectedPlan!.name),
          subtitle: Text('${state.selectedPlan!.transferEnableGB} GB'),
          trailing: Text(
            '¥${((state.couponState.discountedPrice ?? originalPrice) / 100).toStringAsFixed(2)}',
            style: TextStyle(
              color:
                  state.couponState.discountedPrice != null ? Colors.red : null,
              fontWeight: state.couponState.discountedPrice != null
                  ? FontWeight.bold
                  : null,
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
