import 'package:flutter/material.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:fl_clash/enum/enum.dart';

/// 通用数据输入类型
enum DataInputType {
  list,
  map,
}

/// 数据项基类
abstract class DataItem {
  String get displayKey;
  String get displayValue;
  Map<String, dynamic> toJson();
  
  static DataItem fromType(DataInputType type, dynamic data) {
    switch (type) {
      case DataInputType.list:
        return StringDataItem(data as String);
      case DataInputType.map:
        final entry = data as MapEntry<String, String>;
        return MapDataItem(entry.key, entry.value);
    }
  }
}

/// 字符串数据项（用于List类型）
class StringDataItem extends DataItem {
  final String value;
  
  StringDataItem(this.value);
  
  @override
  String get displayKey => value;
  
  @override
  String get displayValue => value;
  
  @override
  Map<String, dynamic> toJson() => {'value': value};
}

/// 键值对数据项（用于Map类型）
class MapDataItem extends DataItem {
  final String key;
  final String value;
  
  MapDataItem(this.key, this.value);
  
  @override
  String get displayKey => key;
  
  @override
  String get displayValue => value;
  
  @override
  Map<String, dynamic> toJson() => {'key': key, 'value': value};
}

/// 通用数据输入页面
/// 统一了之前的 ListInputPage 和 MapInputPage 功能
class UniversalInputPage<T> extends StatefulWidget {
  final String title;
  final DataInputType type;
  final dynamic data; // List<String> 或 Map<String, String>
  final Widget Function(DataItem item) titleBuilder;
  final Widget Function(DataItem item)? subtitleBuilder;
  final Widget Function(DataItem item)? leadingBuilder;
  final String? keyLabel;
  final String? valueLabel;
  final Function(dynamic data) onChange;
  final bool allowReorder;
  final bool allowDuplicate;

  const UniversalInputPage({
    super.key,
    required this.title,
    required this.type,
    required this.data,
    required this.titleBuilder,
    required this.onChange,
    this.subtitleBuilder,
    this.leadingBuilder,
    this.keyLabel,
    this.valueLabel,
    this.allowReorder = true,
    this.allowDuplicate = false,
  });

  @override
  State<UniversalInputPage<T>> createState() => _UniversalInputPageState<T>();
}

class _UniversalInputPageState<T> extends State<UniversalInputPage<T>> {
  late List<DataItem> _items;

  @override
  void initState() {
    super.initState();
    _convertDataToItems();
  }

  void _convertDataToItems() {
    switch (widget.type) {
      case DataInputType.list:
        final list = widget.data as List<String>;
        _items = list.map((item) => StringDataItem(item)).toList();
        break;
      case DataInputType.map:
        final map = widget.data as Map<String, String>;
        _items = map.entries.map((entry) => MapDataItem(entry.key, entry.value)).toList();
        break;
    }
  }

  void _notifyChange() {
    dynamic result;
    switch (widget.type) {
      case DataInputType.list:
        result = _items.map((item) => (item as StringDataItem).value).toList();
        break;
      case DataInputType.map:
        final map = <String, String>{};
        for (final item in _items) {
          final mapItem = item as MapDataItem;
          map[mapItem.key] = mapItem.value;
        }
        result = map;
        break;
    }
    widget.onChange(result);
  }

  String? _uniqueValidator(String? value, DataItem? item) {
    if (!widget.allowDuplicate) {
      final index = _items.indexWhere((entry) {
        return widget.type == DataInputType.list 
          ? entry.displayValue == value
          : entry.displayKey == value;
      });
      final current = item != null && (
        widget.type == DataInputType.list 
          ? item.displayValue == value
          : item.displayKey == value
      );
      if (index != -1 && !current) {
        return appLocalizations.existsTip(
          widget.type == DataInputType.list ? appLocalizations.value : appLocalizations.key
        );
      }
    }
    return null;
  }

  Future<void> _handleAddOrEdit([DataItem? item]) async {
    DataItem? result;
    
    if (widget.type == DataInputType.list) {
      final valueField = Field(
        label: widget.valueLabel ?? appLocalizations.value,
        value: item?.displayValue ?? "",
        validator: (value) => _uniqueValidator(value, item),
      );
      
      final value = await globalState.showCommonDialog<String>(
        child: AddDialog(
          valueField: valueField,
          title: widget.title,
        ),
      );
      
      if (value != null) {
        result = StringDataItem(value);
      }
    } else {
      final keyField = Field(
        label: widget.keyLabel ?? appLocalizations.key,
        value: item?.displayKey ?? "",
        validator: (value) => _uniqueValidator(value, item),
      );
      
      final valueField = Field(
        label: widget.valueLabel ?? appLocalizations.value,
        value: item?.displayValue ?? "",
      );
      
      final resultData = await globalState.showCommonDialog<MapEntry<String, String>>(
        child: AddMapDialog(
          keyField: keyField,
          valueField: valueField,
          title: widget.title,
        ),
      );
      
      if (resultData != null) {
        result = MapDataItem(resultData.key, resultData.value);
      }
    }

    if (result == null) return;

    setState(() {
      if (item != null) {
        final index = _items.indexOf(item);
        if (index != -1) {
          _items[index] = result!;
        }
      } else {
        _items.add(result!);
      }
    });
    
    _notifyChange();
  }

  void _handleDelete(DataItem item) {
    setState(() {
      _items.remove(item);
    });
    _notifyChange();
  }

  void _handleReorder(int oldIndex, int newIndex) {
    if (!widget.allowReorder) return;
    
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
    _notifyChange();
  }

  Widget _buildItem(DataItem item, int index) {
    return Container(
      key: ValueKey(item.displayKey + item.displayValue),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: CommonCard(
        type: CommonCardType.filled,
        child: ListTile(
          leading: widget.leadingBuilder?.call(item),
          title: widget.titleBuilder(item),
          subtitle: widget.subtitleBuilder?.call(item),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => _handleAddOrEdit(item),
                icon: const Icon(Icons.edit_outlined),
                tooltip: appLocalizations.edit,
              ),
              IconButton(
                onPressed: () => _handleDelete(item),
                icon: const Icon(Icons.delete_outlined),
                tooltip: appLocalizations.delete,
              ),
              if (widget.allowReorder)
                ReorderableDragStartListener(
                  index: index,
                  child: const Icon(Icons.drag_handle),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: widget.title,
      actions: [
        IconButton(
          onPressed: () => _handleAddOrEdit(),
          icon: const Icon(Icons.add),
          tooltip: appLocalizations.add,
        ),
      ],
      body: _items.isEmpty
          ? NullStatus(label: appLocalizations.nullDataDesc ?? '暂无数据')
          : widget.allowReorder
              ? ReorderableListView.builder(
                  padding: const EdgeInsets.all(16),
                  onReorder: _handleReorder,
                  itemCount: _items.length,
                  itemBuilder: (context, index) => _buildItem(_items[index], index),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _items.length,
                  itemBuilder: (context, index) => _buildItem(_items[index], index),
                ),
    );
  }
}

/// 简化的List输入页面
class ListInputPage extends StatelessWidget {
  final String title;
  final List<String> items;
  final Widget Function(String item) titleBuilder;
  final Widget Function(String item)? subtitleBuilder;
  final Widget Function(String item)? leadingBuilder;
  final String? valueLabel;
  final Function(List<String> items) onChange;
  final bool allowReorder;
  final bool allowDuplicate;

  const ListInputPage({
    super.key,
    required this.title,
    required this.items,
    required this.titleBuilder,
    required this.onChange,
    this.subtitleBuilder,
    this.leadingBuilder,
    this.valueLabel,
    this.allowReorder = true,
    this.allowDuplicate = false,
  });

  @override
  Widget build(BuildContext context) {
    return UniversalInputPage(
      title: title,
      type: DataInputType.list,
      data: items,
      titleBuilder: (item) => titleBuilder(item.displayValue),
      subtitleBuilder: subtitleBuilder != null 
        ? (item) => subtitleBuilder!(item.displayValue) 
        : null,
      leadingBuilder: leadingBuilder != null 
        ? (item) => leadingBuilder!(item.displayValue) 
        : null,
      valueLabel: valueLabel,
      onChange: (data) => onChange(data as List<String>),
      allowReorder: allowReorder,
      allowDuplicate: allowDuplicate,
    );
  }
}

/// 简化的Map输入页面
class MapInputPage extends StatelessWidget {
  final String title;
  final Map<String, String> map;
  final Widget Function(MapEntry<String, String> item) titleBuilder;
  final Widget Function(MapEntry<String, String> item)? subtitleBuilder;
  final Widget Function(MapEntry<String, String> item)? leadingBuilder;
  final String? keyLabel;
  final String? valueLabel;
  final Function(Map<String, String> map) onChange;
  final bool allowReorder;
  final bool allowDuplicate;

  const MapInputPage({
    super.key,
    required this.title,
    required this.map,
    required this.titleBuilder,
    required this.onChange,
    this.subtitleBuilder,
    this.leadingBuilder,
    this.keyLabel,
    this.valueLabel,
    this.allowReorder = true,
    this.allowDuplicate = false,
  });

  @override
  Widget build(BuildContext context) {
    return UniversalInputPage(
      title: title,
      type: DataInputType.map,
      data: map,
      titleBuilder: (item) => titleBuilder(MapEntry(item.displayKey, item.displayValue)),
      subtitleBuilder: subtitleBuilder != null 
        ? (item) => subtitleBuilder!(MapEntry(item.displayKey, item.displayValue))
        : null,
      leadingBuilder: leadingBuilder != null 
        ? (item) => leadingBuilder!(MapEntry(item.displayKey, item.displayValue))
        : null,
      keyLabel: keyLabel,
      valueLabel: valueLabel,
      onChange: (data) => onChange(data as Map<String, String>),
      allowReorder: allowReorder,
      allowDuplicate: allowDuplicate,
    );
  }
}