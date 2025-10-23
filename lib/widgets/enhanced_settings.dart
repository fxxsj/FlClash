import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:fl_clash/enum/enum.dart';

/// 设置项类型
enum SettingItemType {
  switch_,
  slider,
  dropdown,
  input,
  navigation,
  action,
  info,
}

/// 设置项数据模型
class SettingItem {
  final String key;
  final String title;
  final String? subtitle;
  final String? description;
  final IconData? icon;
  final SettingItemType type;
  final dynamic value;
  final dynamic defaultValue;
  final List<String>? options;
  final double? min;
  final double? max;
  final int? divisions;
  final VoidCallback? onTap;
  final ValueChanged<dynamic>? onChanged;
  final String? searchKeywords;
  final bool enabled;
  final Widget? trailing;

  const SettingItem({
    required this.key,
    required this.title,
    this.subtitle,
    this.description,
    this.icon,
    required this.type,
    this.value,
    this.defaultValue,
    this.options,
    this.min,
    this.max,
    this.divisions,
    this.onTap,
    this.onChanged,
    this.searchKeywords,
    this.enabled = true,
    this.trailing,
  });

  /// 检查是否匹配搜索关键词
  bool matchesSearch(String query) {
    if (query.isEmpty) return true;
    
    final lowerQuery = query.toLowerCase();
    final searchText = [
      title,
      subtitle ?? '',
      description ?? '',
      searchKeywords ?? '',
    ].join(' ').toLowerCase();
    
    return searchText.contains(lowerQuery);
  }
}

/// 设置分组
class SettingGroup {
  final String title;
  final String? subtitle;
  final List<SettingItem> items;
  final IconData? icon;

  const SettingGroup({
    required this.title,
    this.subtitle,
    required this.items,
    this.icon,
  });

  /// 获取匹配搜索的项目
  List<SettingItem> getMatchingItems(String query) {
    return items.where((item) => item.matchesSearch(query)).toList();
  }
}

/// 增强的设置页面
class EnhancedSettingsPage extends ConsumerStatefulWidget {
  final String title;
  final List<SettingGroup> groups;
  final bool enableSearch;
  final bool enableGrouping;
  final Widget? header;
  final Widget? footer;

  const EnhancedSettingsPage({
    super.key,
    required this.title,
    required this.groups,
    this.enableSearch = true,
    this.enableGrouping = true,
    this.header,
    this.footer,
  });

  @override
  ConsumerState<EnhancedSettingsPage> createState() => _EnhancedSettingsPageState();
}

class _EnhancedSettingsPageState extends ConsumerState<EnhancedSettingsPage> {
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<String> _searchQuery = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _searchQuery.value = _searchController.text;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchQuery.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: widget.title,
      body: Column(
        children: [
          if (widget.header != null) widget.header!,
          if (widget.enableSearch) _buildSearchBar(),
          Expanded(
            child: ValueListenableBuilder<String>(
              valueListenable: _searchQuery,
              builder: (context, query, _) {
                return _buildSettingsList(query);
              },
            ),
          ),
          if (widget.footer != null) widget.footer!,
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: appLocalizations.searchSettings ?? '搜索设置...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: ValueListenableBuilder<String>(
            valueListenable: _searchQuery,
            builder: (context, query, _) {
              return query.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                      },
                    )
                  : const SizedBox.shrink();
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }

  Widget _buildSettingsList(String query) {
    final filteredGroups = widget.groups.map((group) {
      final matchingItems = group.getMatchingItems(query);
      return SettingGroup(
        title: group.title,
        subtitle: group.subtitle,
        icon: group.icon,
        items: matchingItems,
      );
    }).where((group) => group.items.isNotEmpty).toList();

    if (filteredGroups.isEmpty) {
      return NullStatus(
        label: appLocalizations.noSettingsFound ?? '未找到相关设置',
        icon: Icons.search_off,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filteredGroups.length,
      itemBuilder: (context, index) {
        final group = filteredGroups[index];
        return _buildSettingGroup(group, query.isNotEmpty);
      },
    );
  }

  Widget _buildSettingGroup(SettingGroup group, bool isSearching) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.enableGrouping && !isSearching) ...[
          _buildGroupHeader(group),
          const SizedBox(height: 8),
        ],
        ...group.items.map((item) => _buildSettingItem(item)),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildGroupHeader(SettingGroup group) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (group.icon != null) ...[
            Icon(
              group.icon,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (group.subtitle != null)
                  Text(
                    group.subtitle!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(SettingItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: CommonCard(
        type: item.enabled ? CommonCardType.filled : CommonCardType.plain,
        child: _buildItemContent(item),
      ),
    );
  }

  Widget _buildItemContent(SettingItem item) {
    switch (item.type) {
      case SettingItemType.switch_:
        return _buildSwitchItem(item);
      case SettingItemType.slider:
        return _buildSliderItem(item);
      case SettingItemType.dropdown:
        return _buildDropdownItem(item);
      case SettingItemType.input:
        return _buildInputItem(item);
      case SettingItemType.navigation:
        return _buildNavigationItem(item);
      case SettingItemType.action:
        return _buildActionItem(item);
      case SettingItemType.info:
        return _buildInfoItem(item);
    }
  }

  Widget _buildSwitchItem(SettingItem item) {
    return ListTile(
      leading: item.icon != null ? Icon(item.icon) : null,
      title: Text(item.title),
      subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
      trailing: Switch(
        value: item.value ?? item.defaultValue ?? false,
        onChanged: item.enabled ? (value) {
          item.onChanged?.call(value);
        } : null,
      ),
      enabled: item.enabled,
      onTap: item.enabled ? () {
        final newValue = !(item.value ?? item.defaultValue ?? false);
        item.onChanged?.call(newValue);
      } : null,
    );
  }

  Widget _buildSliderItem(SettingItem item) {
    final value = (item.value ?? item.defaultValue ?? 0.0) as double;
    
    return ListTile(
      leading: item.icon != null ? Icon(item.icon) : null,
      title: Text(item.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.subtitle != null) Text(item.subtitle!),
          const SizedBox(height: 8),
          Slider(
            value: value,
            min: item.min ?? 0.0,
            max: item.max ?? 1.0,
            divisions: item.divisions,
            label: value.toString(),
            onChanged: item.enabled ? (newValue) {
              item.onChanged?.call(newValue);
            } : null,
          ),
          Text(
            '${appLocalizations.currentValue ?? '当前值'}: ${value.toStringAsFixed(1)}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      enabled: item.enabled,
    );
  }

  Widget _buildDropdownItem(SettingItem item) {
    return ListTile(
      leading: item.icon != null ? Icon(item.icon) : null,
      title: Text(item.title),
      subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
      trailing: DropdownButton<String>(
        value: item.value ?? item.defaultValue,
        items: item.options?.map((option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: item.enabled ? (value) {
          item.onChanged?.call(value);
        } : null,
        underline: const SizedBox.shrink(),
      ),
      enabled: item.enabled,
    );
  }

  Widget _buildInputItem(SettingItem item) {
    return ListTile(
      leading: item.icon != null ? Icon(item.icon) : null,
      title: Text(item.title),
      subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
      trailing: const Icon(Icons.edit_outlined),
      enabled: item.enabled,
      onTap: item.enabled ? () {
        _showInputDialog(item);
      } : null,
    );
  }

  Widget _buildNavigationItem(SettingItem item) {
    return ListTile(
      leading: item.icon != null ? Icon(item.icon) : null,
      title: Text(item.title),
      subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
      trailing: item.trailing ?? const Icon(Icons.chevron_right),
      enabled: item.enabled,
      onTap: item.enabled ? item.onTap : null,
    );
  }

  Widget _buildActionItem(SettingItem item) {
    return ListTile(
      leading: item.icon != null ? Icon(item.icon) : null,
      title: Text(item.title),
      subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
      trailing: item.trailing,
      enabled: item.enabled,
      onTap: item.enabled ? item.onTap : null,
    );
  }

  Widget _buildInfoItem(SettingItem item) {
    return ListTile(
      leading: item.icon != null ? Icon(item.icon) : null,
      title: Text(item.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.subtitle != null) Text(item.subtitle!),
          if (item.description != null) ...[
            const SizedBox(height: 4),
            Text(
              item.description!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
      trailing: item.trailing,
      enabled: false,
    );
  }

  Future<void> _showInputDialog(SettingItem item) async {
    final controller = TextEditingController(text: item.value?.toString() ?? '');
    
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(item.title),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: item.subtitle ?? appLocalizations.value,
              border: const OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(appLocalizations.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: Text(appLocalizations.confirm),
            ),
          ],
        );
      },
    );

    if (result != null) {
      item.onChanged?.call(result);
    }
  }
}

/// 设置页面构建器
class SettingsBuilder {
  final List<SettingGroup> _groups = [];

  /// 添加设置分组
  SettingsBuilder addGroup(SettingGroup group) {
    _groups.add(group);
    return this;
  }

  /// 添加分组（通过构建器）
  SettingsBuilder group(String title, {
    String? subtitle,
    IconData? icon,
    required List<SettingItem> items,
  }) {
    _groups.add(SettingGroup(
      title: title,
      subtitle: subtitle,
      icon: icon,
      items: items,
    ));
    return this;
  }

  /// 构建设置页面
  Widget build(String title, {
    bool enableSearch = true,
    bool enableGrouping = true,
    Widget? header,
    Widget? footer,
  }) {
    return EnhancedSettingsPage(
      title: title,
      groups: _groups,
      enableSearch: enableSearch,
      enableGrouping: enableGrouping,
      header: header,
      footer: footer,
    );
  }
}

/// 设置项构建器
class SettingItemBuilder {
  /// 创建开关设置项
  static SettingItem switch_({
    required String key,
    required String title,
    String? subtitle,
    IconData? icon,
    required bool value,
    bool defaultValue = false,
    required ValueChanged<bool> onChanged,
    bool enabled = true,
    String? searchKeywords,
  }) {
    return SettingItem(
      key: key,
      title: title,
      subtitle: subtitle,
      icon: icon,
      type: SettingItemType.switch_,
      value: value,
      defaultValue: defaultValue,
      onChanged: (v) => onChanged(v as bool),
      enabled: enabled,
      searchKeywords: searchKeywords,
    );
  }

  /// 创建滑块设置项
  static SettingItem slider({
    required String key,
    required String title,
    String? subtitle,
    IconData? icon,
    required double value,
    double defaultValue = 0.0,
    double min = 0.0,
    double max = 1.0,
    int? divisions,
    required ValueChanged<double> onChanged,
    bool enabled = true,
    String? searchKeywords,
  }) {
    return SettingItem(
      key: key,
      title: title,
      subtitle: subtitle,
      icon: icon,
      type: SettingItemType.slider,
      value: value,
      defaultValue: defaultValue,
      min: min,
      max: max,
      divisions: divisions,
      onChanged: (v) => onChanged(v as double),
      enabled: enabled,
      searchKeywords: searchKeywords,
    );
  }

  /// 创建下拉选择设置项
  static SettingItem dropdown({
    required String key,
    required String title,
    String? subtitle,
    IconData? icon,
    required String value,
    String? defaultValue,
    required List<String> options,
    required ValueChanged<String> onChanged,
    bool enabled = true,
    String? searchKeywords,
  }) {
    return SettingItem(
      key: key,
      title: title,
      subtitle: subtitle,
      icon: icon,
      type: SettingItemType.dropdown,
      value: value,
      defaultValue: defaultValue,
      options: options,
      onChanged: (v) => onChanged(v as String),
      enabled: enabled,
      searchKeywords: searchKeywords,
    );
  }

  /// 创建导航设置项
  static SettingItem navigation({
    required String key,
    required String title,
    String? subtitle,
    IconData? icon,
    required VoidCallback onTap,
    Widget? trailing,
    bool enabled = true,
    String? searchKeywords,
  }) {
    return SettingItem(
      key: key,
      title: title,
      subtitle: subtitle,
      icon: icon,
      type: SettingItemType.navigation,
      onTap: onTap,
      trailing: trailing,
      enabled: enabled,
      searchKeywords: searchKeywords,
    );
  }

  /// 创建信息设置项
  static SettingItem info({
    required String key,
    required String title,
    String? subtitle,
    String? description,
    IconData? icon,
    Widget? trailing,
    String? searchKeywords,
  }) {
    return SettingItem(
      key: key,
      title: title,
      subtitle: subtitle,
      description: description,
      icon: icon,
      type: SettingItemType.info,
      trailing: trailing,
      enabled: false,
      searchKeywords: searchKeywords,
    );
  }
}