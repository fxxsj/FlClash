import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/clash/clash.dart';
import 'dart:math';
import 'node_list.dart';

/// 连接状态组件 - 显示代理连接状态、模式切换和当前节点
class ConnectionStatus extends ConsumerStatefulWidget {
  const ConnectionStatus({super.key});

  @override
  ConsumerState<ConnectionStatus> createState() => _ConnectionStatusState();
}

class _ConnectionStatusState extends ConsumerState<ConnectionStatus> 
    with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // 必须调用以使 AutomaticKeepAliveClientMixin 生效
    
    return Consumer(
        builder: (_, ref, __) {
          // 监听代理启动状态
          final runTime = ref.watch(runTimeProvider);
          final isStart = runTime != null;
          
          // 监听当前模式
          final mode = ref.watch(
            patchClashConfigProvider.select((state) => state.mode),
          );
          
          // 监听代理组状态变化，确保实时更新
          final groups = ref.watch(groupsProvider);
          
          // 获取当前选中的代理节点名称
          String? currentProxyName;
          String? displayGroupName;
          
          if (isStart && groups.isNotEmpty) {
            // 根据当前模式查找对应的代理组和节点
            if (mode == Mode.global) {
              // 全局模式：查找GLOBAL组
              final globalGroup = groups.where((group) => group.name == 'GLOBAL').firstOrNull;
              if (globalGroup != null && globalGroup.now != null && globalGroup.now!.isNotEmpty) {
                currentProxyName = globalGroup.now;
                displayGroupName = globalGroup.name;
              }
            } else {
              // 规则模式：查找第一个可见的代理组（非GLOBAL组）
              final visibleGroups = groups.where((group) => 
                group.hidden != true && 
                group.name != 'GLOBAL' &&
                group.now != null && 
                group.now!.isNotEmpty
              ).toList();
              
              if (visibleGroups.isNotEmpty) {
                final activeGroup = visibleGroups.first;
                currentProxyName = activeGroup.now;
                displayGroupName = activeGroup.name;
              }
            }
            
            // 调试信息
            if (kDebugMode) {
              print('连接状态组件调试:');
              print('  isStart: $isStart');
              print('  mode: $mode');
              print('  currentProxyName: $currentProxyName');
              print('  displayGroupName: $displayGroupName');
              print('  groups count: ${groups.length}');
              for (final group in groups) {
                print('  Group: ${group.name}, now: ${group.now}, hidden: ${group.hidden}');
              }
            }
          }
          
          return CommonCard(
            onPressed: () {},
            child: !isStart
                ? Stack(
                    children: [
                      Center(
                        child: _buildPowerButton(context, isStart),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: _buildMovieStyleIP(context),
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 已连接状态：显示状态和模式切换
                            _buildConnectedStatus(context, mode),

                            // 当前节点显示（仅在已连接且有节点时显示）
                            if (currentProxyName != null && displayGroupName != null) ...[
                              const SizedBox(height: 12),
                              _buildCurrentNode(context, displayGroupName, currentProxyName),
                            ],
                            
                            const SizedBox(height: 12),

                            // 数字计时器
                            _buildDigitalTimer(context, isStart, runTime),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: _buildNetworkDetectionInfo(context),
                        ),
                      ],
                    ),
                  ),
          );
        },
      );
  }

  /// 构建电源按钮
  Widget _buildPowerButton(BuildContext context, bool isStart) {
    return AnimatedBuilder(
      animation: const AlwaysStoppedAnimation(0),
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            // 切换启动/停止状态
            globalState.appController.updateStatus(!isStart);
          },
          child: _buildPowerButtonWithPulse(context, isStart),
        );
      },
    );
  }

  /// 构建带脉动效果的电源按钮
  Widget _buildPowerButtonWithPulse(BuildContext context, bool isStart) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: isStart ? 1500 : 2500),
      tween: Tween(begin: 0.0, end: 1.0),
      onEnd: () {
        if (mounted) {
          setState(() {}); // 重启动画循环
        }
      },
      builder: (context, animationValue, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // 外层动态环形效果 - 参考图片样式
            if (!isStart) ...[
              // 第一层扩散圆环
              Transform.scale(
                scale: 1.0 + (animationValue * 1.2),
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.transparent,
                        Theme.of(context).colorScheme.primary
                            .withValues(alpha: 0.2 * (1.0 - animationValue)),
                        Theme.of(context).colorScheme.primary
                            .withValues(alpha: 0.1 * (1.0 - animationValue)),
                      ],
                    ),
                  ),
                ),
              ),
              // 第二层扩散圆环（延迟）
              if (animationValue > 0.2)
                Transform.scale(
                  scale: 1.0 + ((animationValue - 0.2) * 1.5),
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.transparent,
                          Theme.of(context).colorScheme.primary
                              .withValues(alpha: 0.15 * (1.0 - (animationValue - 0.2))),
                        ],
                      ),
                    ),
                  ),
                ),
              // 第三层扩散圆环（最后）
              if (animationValue > 0.5)
                Transform.scale(
                  scale: 1.0 + ((animationValue - 0.5) * 1.8),
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.transparent,
                          Theme.of(context).colorScheme.primary
                              .withValues(alpha: 0.1 * (1.0 - (animationValue - 0.5))),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
            
            // 已连接状态的柔和呼吸效果
            if (isStart) ...[
              // 外层呼吸光环
              Transform.scale(
                scale: 1.0 + (sin(animationValue * 2 * pi) * 0.1),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.transparent,
                        Colors.green.withValues(alpha: 0.2),
                        Colors.green.withValues(alpha: 0.05),
                      ],
                    ),
                  ),
                ),
              ),
              // 内层稳定光环
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.transparent,
                      Colors.green.withValues(alpha: 0.1),
                    ],
                  ),
                ),
              ),
            ],
            
            // 主按钮 - 参考图片的渐变和阴影效果
            Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isStart
                    ? const RadialGradient(
                        colors: [
                          Color(0xFF4CAF50), // 亮绿色中心
                          Color(0xFF2E7D32), // 深绿色边缘
                        ],
                        stops: [0.3, 1.0],
                      )
                    : RadialGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary.withValues(alpha: 0.9),
                          Theme.of(context).colorScheme.primary,
                        ],
                        stops: const [0.3, 1.0],
                      ),
                boxShadow: [
                  BoxShadow(
                    color: isStart 
                        ? Colors.green.withValues(alpha: 0.5)
                        : Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
                    blurRadius: 15,
                    spreadRadius: 2,
                    offset: const Offset(0, 5),
                  ),
                  // 内层柔光
                  BoxShadow(
                    color: Colors.white.withValues(alpha: isStart ? 0.2 : 0.15),
                    blurRadius: 8,
                    spreadRadius: -5,
                    offset: const Offset(-2, -2),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  isStart ? Icons.link_off_rounded : Icons.link_rounded,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            
            // 内圈高光装饰
            Container(
              width: 78,
              height: 78,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.3),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.white.withValues(alpha: 0.1),
                  ],
                  stops: const [0.0, 0.3, 0.7, 1.0],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// 构建电影台词风格的IP显示
  Widget _buildMovieStyleIP(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final localIp = ref.watch(localIpProvider);
        
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.05),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: localIp != null 
              ? _buildIPContent(context, localIp)
              : _buildLoadingContent(context),
        );
      },
    );
  }

  /// 构建IP内容显示
  Widget _buildIPContent(BuildContext context, String ip) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 设备图标
        Icon(
          Icons.devices_rounded,
          size: 14,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
        ),
        
        const SizedBox(width: 6),
        
        // 内网地址标签（国际化）
        Text(
          appLocalizations.intranetIP,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45),
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
        ),
        
        const SizedBox(width: 4),
        
        // 分隔符
        Text(
          ":",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
            fontSize: 11,
          ),
        ),
        
        const SizedBox(width: 4),
        
        // IP地址
        Text(
          ip.isNotEmpty ? ip : appLocalizations.noNetwork,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
            fontSize: 11,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// 构建加载内容显示
  Widget _buildLoadingContent(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1500),
      tween: Tween(begin: 0.0, end: 1.0),
      onEnd: () {
        if (mounted) {
          setState(() {}); // 重启动画
        }
      },
      builder: (context, value, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 设备图标
            Icon(
              Icons.devices_rounded,
              size: 14,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
            ),
            
            const SizedBox(width: 6),
            
            // 内网地址标签
            Text(
              appLocalizations.intranetIP,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.35),
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
            
            const SizedBox(width: 4),
            
            // 分隔符
            Text(
              ":",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.25),
                fontSize: 11,
              ),
            ),
            
            const SizedBox(width: 4),
            
            // 加载动画
            ...List.generate(3, (index) {
              final delay = index * 0.2;
              final opacity = value > delay 
                  ? (sin((value - delay) * 3 * pi) * 0.3 + 0.3).clamp(0.1, 0.4)
                  : 0.1;
              
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 1),
                child: Text(
                  '•',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: opacity),
                    fontSize: 10,
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  /// 构建已连接状态显示
  Widget _buildConnectedStatus(BuildContext context, Mode mode) {
    return Row(
      children: [
        // 左侧连接状态
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // 状态指示器
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 8),
                  
                  // 状态文字
                  Text(
                    appLocalizations.start,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // 右侧模式切换开关
        _buildModeSwitch(context, mode),
      ],
    );
  }

  /// 构建数字计时器
  Widget _buildDigitalTimer(BuildContext context, bool isStart, int? runTime) {
    return Center(
      child: StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          if (!isStart || runTime == null) {
            return const SizedBox.shrink();
          }
          // 使用项目原有的、更可靠的工具函数来格式化时间
          final timeText = utils.getTimeText(runTime);

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              timeText,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontFamily: 'JetBrainsMono',
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }

  /// 构建网络检测信息显示
  Widget _buildNetworkDetectionInfo(BuildContext context) {
    return ValueListenableBuilder<NetworkDetectionState>(
      valueListenable: detectionState.state,
      builder: (_, state, __) {
        final ipInfo = state.ipInfo;
        final isLoading = state.isLoading;
        
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.05),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ipInfo != null 
              ? _buildExternalIPContent(context, ipInfo)
              : _buildNetworkDetectionLoading(context, isLoading),
        );
      },
    );
  }

  /// 构建外网IP内容显示
  Widget _buildExternalIPContent(BuildContext context, IpInfo ipInfo) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 国家旗帜图标
        Text(
          _countryCodeToEmoji(ipInfo.countryCode),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontFamily: FontFamily.twEmoji.value,
            fontSize: 16,
          ),
        ),
        
        const SizedBox(width: 6),
        
        // 外网地址标签（国际化）
        Text(
          appLocalizations.networkDetection,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45),
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
        ),
        
        const SizedBox(width: 4),
        
        // 分隔符
        Text(
          ":",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
            fontSize: 11,
          ),
        ),
        
        const SizedBox(width: 4),
        
        // IP地址
        Flexible(
          child: Text(
            ipInfo.ip,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// 构建网络检测加载内容显示
  Widget _buildNetworkDetectionLoading(BuildContext context, bool isLoading) {
    if (isLoading == false) {
      // 检测超时或失败
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 错误图标
          Icon(
            Icons.error_outline,
            size: 14,
            color: Colors.red.withValues(alpha: 0.6),
          ),
          
          const SizedBox(width: 6),
          
          // 网络检测标签
          Text(
            appLocalizations.networkDetection,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.35),
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
          
          const SizedBox(width: 4),
          
          // 分隔符
          Text(
            ":",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.25),
              fontSize: 11,
            ),
          ),
          
          const SizedBox(width: 4),
          
          // 超时文字
          Text(
            "timeout",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.red.withValues(alpha: 0.6),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }
    
    // 正在加载
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1500),
      tween: Tween(begin: 0.0, end: 1.0),
      onEnd: () {
        if (mounted) {
          setState(() {}); // 重启动画
        }
      },
      builder: (context, value, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 网络检测图标
            Icon(
              Icons.network_check,
              size: 14,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
            ),
            
            const SizedBox(width: 6),
            
            // 网络检测标签
            Text(
              appLocalizations.networkDetection,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.35),
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
            
            const SizedBox(width: 4),
            
            // 分隔符
            Text(
              ":",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.25),
                fontSize: 11,
              ),
            ),
            
            const SizedBox(width: 4),
            
            // 加载动画
            ...List.generate(3, (index) {
              final delay = index * 0.2;
              final opacity = value > delay 
                  ? (sin((value - delay) * 3 * pi) * 0.3 + 0.3).clamp(0.1, 0.4)
                  : 0.1;
              
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 1),
                child: Text(
                  '•',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: opacity),
                    fontSize: 10,
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  /// 构建模式切换开关（左侧规则，右侧全局）
  Widget _buildModeSwitch(BuildContext context, Mode mode) {
    final isGlobalMode = mode == Mode.global;
    
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 规则模式按钮
          GestureDetector(
            onTap: () {
              if (mode != Mode.rule) {
                globalState.appController.changeMode(Mode.rule);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: !isGlobalMode 
                  ? Theme.of(context).colorScheme.primary 
                  : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                appLocalizations.rule,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: !isGlobalMode 
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          
          // 全局模式按钮
          GestureDetector(
            onTap: () {
              if (mode != Mode.global) {
                globalState.appController.changeMode(Mode.global);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isGlobalMode 
                  ? Theme.of(context).colorScheme.primary 
                  : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                appLocalizations.global,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isGlobalMode 
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建当前节点显示（可点击）
  Widget _buildCurrentNode(BuildContext context, String groupName, String proxyName) {
    return GestureDetector(
      onTap: () {
        // 区分移动和桌面模式，与公告详情保持一致
        final viewMode = globalState.appController.viewMode;
        
        if (viewMode == ViewMode.mobile) {
          // 移动端：跳转到节点列表页面
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NodeListView(),
            ),
          );
        } else {
          // 桌面模式使用弹窗，与公告详情和工单详情保持一致的显示方式
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: NodeListSheetWrapper(),
              );
            },
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // 节点名称
            Expanded(
              child: EmojiText(
                proxyName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            
            const SizedBox(width: 8),
            
            // 信号强度指示器
            Row(
              children: List.generate(4, (index) => 
                Container(
                  width: 3,
                  height: 4 + (index * 3),
                  margin: const EdgeInsets.only(right: 1),
                  decoration: BoxDecoration(
                    color: index < 3 
                      ? Colors.green 
                      : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
            ),
            
            const SizedBox(width: 8),
            
            // 箭头图标表示可点击
            Icon(
              Icons.chevron_right,
              size: 16,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ],
        ),
      ),
    );
  }

  /// 将国家代码转换为旗帜表情符号
  String _countryCodeToEmoji(String countryCode) {
    final String code = countryCode.toUpperCase();
    if (code.length != 2) {
      return countryCode;
    }
    final int firstLetter = code.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = code.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }
}

/// 桌面端节点列表弹窗包装器 - 与公告和工单详情弹窗样式保持一致
class NodeListSheetWrapper extends ConsumerStatefulWidget {
  const NodeListSheetWrapper({super.key});

  @override
  ConsumerState<NodeListSheetWrapper> createState() => _NodeListSheetWrapperState();
}

class _NodeListSheetWrapperState extends ConsumerState<NodeListSheetWrapper> {
  String _query = '';
  bool _isTestingLatency = false;
  final Map<String, int?> _latencyResults = {};

  // 测试所有延迟
  Future<void> _testAllLatency() async {
    if (_isTestingLatency) return;
    
    setState(() {
      _isTestingLatency = true;
      _latencyResults.clear();
    });

    try {
      final groups = ref.read(groupsProvider);
      final mode = ref.read(patchClashConfigProvider.select((state) => state.mode));
      
      Group? targetGroup;
      if (mode == Mode.global) {
        targetGroup = groups.where((group) => group.name == 'GLOBAL').firstOrNull;
      } else {
        final visibleGroups = groups.where((item) => 
          item.hidden != true && item.name != 'GLOBAL'
        ).toList();
        if (visibleGroups.isNotEmpty) {
          targetGroup = visibleGroups.first;
        }
      }
      
      if (targetGroup != null) {
        final allProxies = targetGroup.all ?? [];
        for (final proxy in allProxies) {
          if (mounted) {
            try {
              // 使用正确的参数：需要URL和节点名称
              final delayResult = await clashCore.getDelay("", proxy.name);
              setState(() {
                _latencyResults[proxy.name] = delayResult.value;
              });
            } catch (e) {
              setState(() {
                _latencyResults[proxy.name] = null;
              });
            }
          }
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isTestingLatency = false;
        });
      }
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
                  // 左侧节点图标
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.hub_rounded,
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
                          appLocalizations.selectNode,
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
                  // 延迟测试按钮
                  Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: _isTestingLatency ? null : _testAllLatency,
                      icon: _isTestingLatency 
                        ? SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )
                        : Icon(
                            Icons.flash_on,
                            color: Theme.of(context).colorScheme.outline,
                            size: 20,
                          ),
                      tooltip: "测试延迟",
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
                child: _buildNodeListContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 构建节点列表内容（不包含头部）
  Widget _buildNodeListContent() {
    return Column(
      children: [
        // 搜索栏
        Container(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              hintText: appLocalizations.search,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            onChanged: (value) {
              setState(() {
                _query = value.toLowerCase();
              });
            },
          ),
        ),
        
        // 节点列表
        Expanded(
          child: _buildNodeList(),
        ),
      ],
    );
  }

  Widget _buildNodeList() {
    return Consumer(
      builder: (_, ref, __) {
        final groups = ref.watch(groupsProvider);
        final mode = ref.watch(patchClashConfigProvider.select((state) => state.mode));
        
        if (groups.isEmpty) {
          return Center(
            child: Text(
              appLocalizations.nullTip(appLocalizations.proxies),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          );
        }

        Group? targetGroup;
        
        if (mode == Mode.global) {
          targetGroup = groups.where((group) => group.name == 'GLOBAL').firstOrNull;
        } else {
          final visibleGroups = groups.where((item) => 
            item.hidden != true && item.name != 'GLOBAL'
          ).toList();
          
          if (visibleGroups.isNotEmpty) {
            targetGroup = visibleGroups.first;
          }
        }

        if (targetGroup == null) {
          return Center(
            child: Text(
              "无可用的代理组",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          );
        }

        return _buildSimpleNodeList(targetGroup);
      },
    );
  }

  Widget _buildSimpleNodeList(Group targetGroup) {
    final List<NodeItem> proxies = [];
    final allProxies = targetGroup.all ?? [];
    
    // 过滤和搜索
    for (final proxy in allProxies) {
      if (_query.isNotEmpty && !proxy.name.toLowerCase().contains(_query)) {
        continue;
      }
      
      proxies.add(NodeItem(
        name: proxy.name,
        now: targetGroup.now,
        delay: _latencyResults[proxy.name],
      ));
    }

    if (proxies.isEmpty) {
      return Center(
        child: Text(
          _query.isNotEmpty ? "无搜索结果" : "此组无可用节点",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      );
    }

    return Consumer(
      builder: (_, ref, __) {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: proxies.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final proxy = proxies[index];
            final isSelected = proxy.name == proxy.now;
            
            return CommonCard(
              onPressed: () async {
                // 使用与代理页面一致的逻辑
                _changeProxyInNodeList(ref, targetGroup, proxy.name);
              },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // 节点信息
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 节点名称
                      EmojiText(
                        proxy.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // 右侧：延迟显示和选中状态
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 延迟显示 - 与代理页面一致
                    _buildDelayDisplay(proxy.delay, proxy.name, targetGroup.testUrl),
                    
                    const SizedBox(width: 12),
                    
                    // 选中状态指示器
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected 
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                        border: Border.all(
                          color: isSelected 
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outline,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                        ? Icon(
                            Icons.check,
                            size: 12,
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
        );
      },
    );
  }

  /// 节点切换逻辑 - 与代理页面保持一致
  void _changeProxyInNodeList(WidgetRef ref, Group targetGroup, String proxyName) async {
    final groupType = targetGroup.type;
    final isComputedSelected = groupType.isComputedSelected;
    final isSelector = groupType == GroupType.Selector;
    
    // 检查是否可以手动切换节点（与代理页面逻辑一致）
    if (isComputedSelected || isSelector) {
      final currentProxyName = ref.read(getProxyNameProvider(targetGroup.name));
      final nextProxyName = switch (isComputedSelected) {
        true => currentProxyName == proxyName ? "" : proxyName,
        false => proxyName,
      };
      
      final appController = globalState.appController;
      // 先更新本地选中状态
      appController.updateCurrentSelectedMap(
        targetGroup.name,
        nextProxyName,
      );
      // 使用 changeProxyDebounce，内部会自动调用 updateGroups()
      await appController.changeProxyDebounce(targetGroup.name, nextProxyName);
      
      // 关闭弹窗
      if (mounted) {
        Navigator.of(context).pop();
      }
      return;
    }
    
    // 不支持手动切换的组类型，显示提示
    globalState.showNotifier(
      appLocalizations.notSelectedTip,
    );
  }

  /// 构建延迟显示 - 与代理页面逻辑完全一致
  Widget _buildDelayDisplay(int? delay, String proxyName, String? testUrl) {
    // delay == 0 表示正在测试中
    if (delay == 0) {
      return const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }
    
    // delay == null 表示未测试
    if (delay == null) {
      return GestureDetector(
        onTap: () {
          // 触发单个节点延迟测试
          _testSingleNodeDelay(proxyName, testUrl);
        },
        child: Icon(
          Icons.bolt,
          size: 16,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
        ),
      );
    }
    
    // delay > 0 显示延迟数字，delay < 0 显示 Timeout
    // 颜色统一使用 utils.getDelayColor 处理（与代理页面完全一致）
    return GestureDetector(
      onTap: () {
        // 可以点击重新测试
        _testSingleNodeDelay(proxyName, testUrl);
      },
      child: Text(
        delay > 0 ? '$delay ms' : 'Timeout',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          overflow: TextOverflow.ellipsis,
          color: utils.getDelayColor(delay), // 与代理页面一致，统一使用此方法
        ),
      ),
    );
  }

  /// 测试单个节点延迟 - 与批量测试逻辑一致
  void _testSingleNodeDelay(String proxyName, String? testUrl) async {
    setState(() {
      _latencyResults[proxyName] = 0; // 设置为0表示正在测试
    });
    
    try {
      final delayResult = await clashCore.getDelay(testUrl ?? "", proxyName);
      if (mounted) {
        setState(() {
          // delayResult.value 可能是正数（成功）或负数（超时）
          _latencyResults[proxyName] = delayResult.value;
        });
      }
    } catch (e) {
      // 异常时设置为null，与批量测试保持一致
      if (mounted) {
        setState(() {
          _latencyResults[proxyName] = null;
        });
      }
    }
  }
}

// 简化的节点项目数据类
class NodeItem {
  final String name;
  final String? now;
  final int? delay;

  NodeItem({
    required this.name,
    this.now,
    this.delay,
  });
}