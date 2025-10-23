import 'package:fl_clash/common/app_localizations.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/board/states/user_center_state.dart';
import 'package:fl_clash/board/widgets/active_builder.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/views/dashboard/widgets/start_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fl_clash/common/error_handler.dart';
import 'package:fl_clash/board/utils/silent_update_manager.dart';

// 导入认证页面
import '../account/auth/index.dart';
// 导入用户中心组件
import '../../constants/app_config.dart';
import 'notices/notice_list.dart';
import 'components/connection_status.dart';  // 导入连接状态组件
import 'package:fl_clash/board/views/orders/components/order_detail_sheet.dart';

// 导入仪表盘组件
import 'package:fl_clash/views/dashboard/widgets/widgets.dart';
import 'package:fl_clash/views/dashboard/widgets/quick_options.dart';
import 'package:fl_clash/views/dashboard/widgets/traffic_usage.dart';

// 用户中心表单状态枚举
enum UserFormState {
  login,
  register,
  resetPassword,
}

class UserCenterFragment extends ConsumerStatefulWidget {
  const UserCenterFragment({super.key});

  @override
  ConsumerState<UserCenterFragment> createState() => _UserCenterFragmentState();
}

class _UserCenterFragmentState extends ConsumerState<UserCenterFragment> {
  // 当前显示的表单状态
  UserFormState _formState = UserFormState.login;

  @override
  void initState() {
    super.initState();
    // 页面初始化时触发静默更新
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SilentUpdateManager.triggerSilentUpdateIfNeeded(ref, pageName: "用户中心");
    });
  }
  
  @override
  dispose() {
    super.dispose();
  }
  
  // 切换表单状态的方法
  void _switchFormState(UserFormState state) {
    setState(() {
      _formState = state;
    });
  }

  // 获取当前表单（这些已经移动到auth文件夹，这里保留兼容性）
  Widget _buildCurrentForm() {
    switch (_formState) {
      case UserFormState.login:
        return const LoginPage();
      case UserFormState.register:
        return const RegisterPage();
      case UserFormState.resetPassword:
        return const ResetPasswordPage();
    }
  }

  void _checkUnpaidOrders() async {
    try {
      final authState = ref.read(authStateProvider);
      // 如果用户未认证，直接返回，不执行后续逻辑
      if (!authState.isAuthenticated) return;
      
      final userState = ref.read(userStateProvider.notifier);
      
      // 异步执行，不阻塞UI渲染
      Future.microtask(() async {
        try {
          // 检查组件是否仍然mounted
          if (!mounted) return;
          
          // 再次检查用户是否仍然认证
          if (!ref.read(authStateProvider).isAuthenticated) return;
          
          await userState.checkUnpaidOrders();
          
          // 如果组件已被销毁，不再继续执行
          if (!mounted) return;
          
          // 再次检查用户是否仍然认证（防止在API请求过程中用户退出）
          if (!ref.read(authStateProvider).isAuthenticated) return;
          
          final unpaidOrders = ref.read(userStateProvider).unpaidOrders;

          if (unpaidOrders.isNotEmpty && mounted) {
            // 先隐藏当前显示的任何 SnackBar
            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(appLocalizations.unpaidOrderTip),
                    ),
                  ],
                ),
                action: SnackBarAction(
                  label: appLocalizations.goToPay,
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();

                    final viewMode = globalState.appController.viewMode;
                    if (viewMode == ViewMode.mobile) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommonScaffold.open(
                            title: appLocalizations.orderDetails,
                            actions: const [],
                            body: OrderDetailSheet(
                                order: unpaidOrders.first),
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
                              order: unpaidOrders.first,
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
                duration: const Duration(minutes: 5),
                dismissDirection: DismissDirection.horizontal,
                behavior: SnackBarBehavior.fixed,
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            );
          }
        } catch (e) {
          // 使用新的错误处理系统
          if (mounted && e is AppError) {
            UserFriendlyErrorHandler.showErrorSnackBar(
              context,
              e,
              onRetry: () => _checkUnpaidOrders(),
            );
          } else if (mounted) {
            // 如果不是 AppError，创建一个
            final appError = AppError(
              type: AppErrorType.network,
              severity: ErrorSeverity.low,
              code: 'UNPAID_ORDER_CHECK_ERROR',
              originalMessage: e.toString(),
              userMessage: '检查未支付订单失败',
            );
            UserFriendlyErrorHandler.showErrorSnackBar(
              context,
              appError,
              onRetry: () => _checkUnpaidOrders(),
            );
          }
        }
      });
    } catch (e) {
      // 外层错误也使用新的错误处理系统
      if (mounted) {
        final appError = AppError(
          type: AppErrorType.unknown,
          severity: ErrorSeverity.low,
          code: 'UNPAID_ORDER_INIT_ERROR',
          originalMessage: e.toString(),
          userMessage: '初始化检查失败',
        );
        UserFriendlyErrorHandler.showErrorSnackBar(
          context,
          appError,
          onRetry: () => _checkUnpaidOrders(),
        );
      }
    }
  }

  void _showExtendPage({
    required BuildContext context, 
    required Widget body, 
    required String title
  }) {
    showExtend(
      context,
      builder: (context, type) {
        return AdaptiveSheetScaffold(
          type: type,
          body: body,
          title: title,
          actions: const [],
        );
      },
    );
  }

  void _initScaffold() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final commonScaffoldState =
            context.findAncestorStateOfType<CommonScaffoldState>();
        final authState = ref.read(authStateProvider);
        
        if (authState.isAuthenticated) {
          // 已登录状态：不显示任何操作按钮，保持简洁
          commonScaffoldState?.actions = [];
          
          // 添加与仪表盘页面相同的浮动按钮
          commonScaffoldState?.floatingActionButton = const StartButton();
        } else {
          // 未登录状态：显示访问官网按钮
          commonScaffoldState?.actions = [
            IconButton(
              onPressed: () async {
                final appUrl = authState.appUrl;
                if (appUrl == null) return;

                final url = Uri.parse(appUrl);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
              icon: const Icon(Icons.language),
              tooltip: appLocalizations.officialWebsite,
            ),
          ];
          commonScaffoldState?.floatingActionButton = null;
        }
      },
    );
  }

  void _clearScaffold() {
    final commonScaffoldState =
        context.findAncestorStateOfType<CommonScaffoldState>();
    if (commonScaffoldState != null && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final currentPageLabel = ref.read(currentPageLabelProvider);
        final isUserCenter = currentPageLabel.name.toLowerCase() == 'usercenter';
        
        if (!isUserCenter) return;
        
        commonScaffoldState.actions = const [];
        commonScaffoldState.floatingActionButton = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    
    // 监听认证状态的变化
    ref.listen(authStateProvider, (prev, next) {
      // 如果登录状态发生变化，特别是从已登录变为未登录
      if (prev?.isAuthenticated == true && !next.isAuthenticated) {
        // 确保取消所有可能的SnackBar
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
    });
    
    return ActiveBuilder(
      label: "userCenter",
      builder: (isCurrent, child) {
        if (isCurrent) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // 只有当组件已挂载并且用户已认证时才进行初始化
            if (mounted) {
              _initScaffold();
              if (authState.isAuthenticated && mounted) {
                _checkUnpaidOrders();
                // 切换到用户中心页面时触发静默更新
                SilentUpdateManager.triggerSilentUpdateIfNeeded(ref, pageName: "用户中心-切换");
              }
            }
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _clearScaffold();
            }
          });
        }
        return child!;
      },
      child: Builder(
        builder: (context) {
          // 移除全局加载状态检查，登录按钮会显示自己的加载状态

          if (!authState.isAuthenticated) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // 显示应用标题和描述
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Column(
                        children: [
                          Text(
                            AppConfig.appTitle,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          if (authState.appDescription != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                authState.appDescription!,
                                style: Theme.of(context).textTheme.bodyMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                        ],
                      ),
                    ),
                    
                    // 表单选择选项卡
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => _switchFormState(UserFormState.login),
                            style: TextButton.styleFrom(
                              foregroundColor: _formState == UserFormState.login 
                                  ? Theme.of(context).colorScheme.primary 
                                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              textStyle: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            child: Text(appLocalizations.login),
                          ),
                          TextButton(
                            onPressed: () => _switchFormState(UserFormState.register),
                            style: TextButton.styleFrom(
                              foregroundColor: _formState == UserFormState.register 
                                  ? Theme.of(context).colorScheme.primary 
                                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              textStyle: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            child: Text(appLocalizations.register),
                          ),
                          TextButton(
                            onPressed: () => _switchFormState(UserFormState.resetPassword),
                            style: TextButton.styleFrom(
                              foregroundColor: _formState == UserFormState.resetPassword 
                                  ? Theme.of(context).colorScheme.primary 
                                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              textStyle: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            child: Text(appLocalizations.resetPassword),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // 当前表单
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 450),
                        child: _buildCurrentForm(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final userCenterState = ref.watch(userCenterStateProvider);

          return Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(16).copyWith(
                bottom: 88,
              ),
              child: Column(
                children: [
                  // 公告组件 - 固定高度
                  const NoticeList(),
                  
                  const SizedBox(height: 16),
                  
                  // 连接组件 - 自适应填满剩余空间
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: ConnectionStatus(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
