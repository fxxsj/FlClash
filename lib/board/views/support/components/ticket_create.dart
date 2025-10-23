import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_clash/board/providers/providers.dart';
import 'package:fl_clash/common/app_localizations.dart';

class TicketCreateSheet extends ConsumerStatefulWidget {
  const TicketCreateSheet({super.key});

  @override
  ConsumerState<TicketCreateSheet> createState() => _TicketCreateSheetState();
}

class _TicketCreateSheetState extends ConsumerState<TicketCreateSheet> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
  int _level = 1; // 默认优先级

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        final api = ref.read(v2boardApiProvider);
        await api.createTicket(
          _titleController.text,
          _level,
          _contentController.text,
        );

        if (mounted) {
          Navigator.pop(context, true); // 返回true表示创建成功，需要刷新列表
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('工单创建成功')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: appLocalizations.ticketSubject,
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return appLocalizations.emptyTip(appLocalizations.ticketSubject);
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              value: _level,
              decoration: InputDecoration(
                labelText: appLocalizations.ticketLevel,
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(
                  value: 1,
                  child: Text(appLocalizations.ticketLevelLow),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text(appLocalizations.ticketLevelMedium),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text(appLocalizations.ticketLevelHigh),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _level = value);
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: appLocalizations.content,
                border: const OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 8,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return appLocalizations.emptyTip(appLocalizations.content);
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isSubmitting ? null : _handleSubmit,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(appLocalizations.submit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
