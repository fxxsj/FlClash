import 'package:fl_clash/clash/clash.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/utils/silent_update_manager.dart';

/// 节点列表页面 - 用于显示和选择代理节点
class NodeListView extends ConsumerStatefulWidget {
  const NodeListView({super.key});

  @override
  ConsumerState<NodeListView> createState() => _NodeListViewState();
}

class _NodeListViewState extends ConsumerState<NodeListView> {
  String _query = '';
  bool _isTestingLatency = false;
  final Map<String, int?> _latencyResults = {};
  
  // 静态变量：记录上次延迟测试的时间
  static DateTime? _lastTestTime;
  static const Duration _autoTestInterval = Duration(minutes: 3);

  @override
  void initState() {
    super.initState();
    // 页面初始化时加载历史延迟记录和检查是否需要自动测试
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadHistoricalDelays();
      _checkAndAutoTest();
      SilentUpdateManager.triggerSilentUpdateIfNeeded(ref, pageName: "节点列表");
    });
  }
  
  /// 加载历史延迟记录
  void _loadHistoricalDelays() {
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
      // 从 provider 加载每个节点的历史延迟
      for (final proxy in targetGroup.all) {
        final delay = ref.read(getDelayProvider(
          proxyName: proxy.name,
          testUrl: targetGroup.testUrl,
        ));
        if (delay != null) {
          setState(() {
            _latencyResults[proxy.name] = delay;
          });
        }
      }
    }
  }
  
  /// 检查并执行自动测试
  void _checkAndAutoTest() {
    // 如果没有上次测试时间，或者距离上次测试超过3分钟，则自动测试
    if (_lastTestTime == null || 
        DateTime.now().difference(_lastTestTime!) > _autoTestInterval) {
      // 延迟一小段时间再执行，避免与页面加载冲突
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _testAllLatency();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.selectNode),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          // 延迟测试按钮
          IconButton(
            icon: _isTestingLatency 
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              : const Icon(Icons.flash_on),
            onPressed: _isTestingLatency ? null : _testAllLatency,
          ),
        ],
      ),
      body: Column(
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
      ),
    );
  }

  Widget _buildNodeList() {
    return Consumer(
      builder: (_, ref, __) {
        // 监听代理组状态变化和当前模式
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

        // 根据模式决定显示的组
        Group? targetGroup;
        
        if (mode == Mode.global) {
          // 全局模式：查找GLOBAL组
          targetGroup = groups.where((group) => group.name == 'GLOBAL').firstOrNull;
        } else {
          // 规则模式：获取第一个可见组（已过滤掉GLOBAL）
          final visibleGroups = groups.where((item) => 
            item.hidden != true && item.name != 'GLOBAL'
          ).toList();
          
          if (visibleGroups.isNotEmpty) {
            targetGroup = visibleGroups.first; // 第一个组作为主要组
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

  /// 构建简洁的节点列表
  Widget _buildSimpleNodeList(Group targetGroup) {
    final List<ProxyItem> proxies = [];
    
    // 获取目标组的节点
    if (targetGroup.all.isNotEmpty) {
      for (final proxy in targetGroup.all) {
        // 过滤搜索结果
        if (_query.isEmpty || proxy.name.toLowerCase().contains(_query)) {
          proxies.add(ProxyItem(
            proxy: proxy,
            groupName: targetGroup.name,
            isSelected: proxy.name == targetGroup.now,
            testUrl: targetGroup.testUrl,
            groupType: targetGroup.type,
          ));
        }
      }
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

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: proxies.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final proxyItem = proxies[index];
        return _buildProxyCard(proxyItem);
      },
    );
  }

  Widget _buildProxyCard(ProxyItem proxyItem) {
    final proxy = proxyItem.proxy;
    final isSelected = proxyItem.isSelected;
    
    return CommonCard(
      onPressed: () => _selectProxy(proxyItem),
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
                _buildDelayDisplay(_latencyResults[proxy.name], proxy.name, proxyItem.testUrl),
                
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
          color: utils.getDelayColor(delay), // 与代理页面一致
        ),
      ),
    );
  }

  /// 测试单个节点延迟 - 与代理页面逻辑一致
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

  /// 选择代理 - 与代理页面逻辑一致
  void _selectProxy(ProxyItem proxyItem) async {
    final groupType = proxyItem.groupType;
    final isComputedSelected = groupType.isComputedSelected;
    final isSelector = groupType == GroupType.Selector;
    
    // 检查是否可以手动切换节点（与代理页面逻辑一致）
    if (isComputedSelected || isSelector) {
      final currentProxyName = ref.read(getProxyNameProvider(proxyItem.groupName));
      final nextProxyName = switch (isComputedSelected) {
        true => currentProxyName == proxyItem.proxy.name ? "" : proxyItem.proxy.name,
        false => proxyItem.proxy.name,
      };
      
      final appController = globalState.appController;
      // 先更新本地选中状态
      appController.updateCurrentSelectedMap(
        proxyItem.groupName,
        nextProxyName,
      );
      // 使用 changeProxyDebounce，内部会自动调用 updateGroups()
      await appController.changeProxyDebounce(proxyItem.groupName, nextProxyName);
      
      // 关闭页面
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

  /// 测试所有节点的延迟
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

      if (targetGroup != null && targetGroup.all.isNotEmpty) {
        final testUrl = targetGroup.testUrl ?? 'http://www.gstatic.com/generate_204';
        final appController = globalState.appController;
        
        // 参考common.dart的delayTest实现
        final delayProxies = targetGroup.all.map<Future>((proxy) async {
          final state = appController.getProxyCardState(proxy.name);
          final url = state.testUrl.getSafeValue(
            appController.getRealTestUrl(testUrl),
          );
          final name = state.proxyName;
          if (name.isEmpty) {
            return;
          }
          
          // 设置延迟为0表示开始测试
          appController.setDelay(
            Delay(
              url: url,
              name: name,
              value: 0,
            ),
          );
          
          try {
            // 获取实际延迟
            final delayResult = await clashCore.getDelay(url, name);
            appController.setDelay(delayResult);
            
            if (mounted) {
              setState(() {
                // delayResult.value 可能是正数（成功）或负数（超时）
                _latencyResults[proxy.name] = delayResult.value;
              });
            }
          } catch (e) {
            // 异常时设置为null，与代理页面保持一致
            if (mounted) {
              setState(() {
                _latencyResults[proxy.name] = null;
              });
            }
          }
        }).toList();

        // 批量执行，每次最多100个
        final batchesDelayProxies = _batchList(delayProxies, 100);
        for (final batchDelayProxies in batchesDelayProxies) {
          await Future.wait(batchDelayProxies);
        }
        
        appController.addSortNum();
      }
      
      // 更新上次测试时间
      _lastTestTime = DateTime.now();
      
      // 显示完成提示
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("延迟测试完成"),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("延迟测试失败: $e"),
            backgroundColor: Theme.of(context).colorScheme.error,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isTestingLatency = false;
        });
      }
    }
  }

  /// 将列表分批处理
  List<List<T>> _batchList<T>(List<T> list, int batchSize) {
    final batches = <List<T>>[];
    for (int i = 0; i < list.length; i += batchSize) {
      final end = (i + batchSize < list.length) ? i + batchSize : list.length;
      batches.add(list.sublist(i, end));
    }
    return batches;
  }

}

/// 代理项数据类
class ProxyItem {
  final Proxy proxy;
  final String groupName;
  final bool isSelected;
  final String? testUrl;
  final GroupType groupType;

  ProxyItem({
    required this.proxy,
    required this.groupName,
    required this.isSelected,
    this.testUrl,
    required this.groupType,
  });
}