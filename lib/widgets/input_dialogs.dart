import 'package:flutter/material.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/widgets/widgets.dart';

/// 字段模型
class Field {
  final String label;
  final String value;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;

  Field({
    required this.label,
    required this.value,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
  });
}

/// 通用添加对话框
class AddDialog extends StatefulWidget {
  final Field valueField;
  final String title;

  const AddDialog({
    super.key,
    required this.valueField,
    required this.title,
  });

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  late final TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.valueField.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleConfirm() {
    if (_formKey.currentState?.validate() == true) {
      Navigator.of(context).pop(_controller.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _controller,
              validator: widget.valueField.validator,
              keyboardType: widget.valueField.keyboardType,
              obscureText: widget.valueField.obscureText,
              maxLines: widget.valueField.maxLines,
              decoration: InputDecoration(
                labelText: widget.valueField.label,
                border: const OutlineInputBorder(),
              ),
              autofocus: true,
              onFieldSubmitted: (_) => _handleConfirm(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(appLocalizations.cancel),
        ),
        FilledButton(
          onPressed: _handleConfirm,
          child: Text(appLocalizations.confirm),
        ),
      ],
    );
  }
}

/// Map添加对话框
class AddMapDialog extends StatefulWidget {
  final Field keyField;
  final Field valueField;
  final String title;

  const AddMapDialog({
    super.key,
    required this.keyField,
    required this.valueField,
    required this.title,
  });

  @override
  State<AddMapDialog> createState() => _AddMapDialogState();
}

class _AddMapDialogState extends State<AddMapDialog> {
  late final TextEditingController _keyController;
  late final TextEditingController _valueController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _keyController = TextEditingController(text: widget.keyField.value);
    _valueController = TextEditingController(text: widget.valueField.value);
  }

  @override
  void dispose() {
    _keyController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void _handleConfirm() {
    if (_formKey.currentState?.validate() == true) {
      final key = _keyController.text.trim();
      final value = _valueController.text.trim();
      Navigator.of(context).pop(MapEntry(key, value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _keyController,
              validator: widget.keyField.validator,
              keyboardType: widget.keyField.keyboardType,
              obscureText: widget.keyField.obscureText,
              maxLines: widget.keyField.maxLines,
              decoration: InputDecoration(
                labelText: widget.keyField.label,
                border: const OutlineInputBorder(),
              ),
              autofocus: true,
              onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _valueController,
              validator: widget.valueField.validator,
              keyboardType: widget.valueField.keyboardType,
              obscureText: widget.valueField.obscureText,
              maxLines: widget.valueField.maxLines,
              decoration: InputDecoration(
                labelText: widget.valueField.label,
                border: const OutlineInputBorder(),
              ),
              onFieldSubmitted: (_) => _handleConfirm(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(appLocalizations.cancel),
        ),
        FilledButton(
          onPressed: _handleConfirm,
          child: Text(appLocalizations.confirm),
        ),
      ],
    );
  }
}