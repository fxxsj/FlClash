import 'package:fl_clash/enum/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../ticket_list_page.dart';
import 'ticket_create.dart';

class TicketSheet extends ConsumerStatefulWidget {
  const TicketSheet({super.key = const GlobalObjectKey(PageLabel.customerSupport)});

  @override
  ConsumerState<TicketSheet> createState() => _TicketSheetState();
}

class _TicketSheetState extends ConsumerState<TicketSheet> {
  bool _isCreating = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: kMaterialListPadding.copyWith(
            top: 16,
            bottom: 16,
          ),
          child: _isCreating
              ? const TicketCreateSheet()
              : const TicketListPage(),
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            onPressed: () => setState(() => _isCreating = !_isCreating),
            child: Icon(_isCreating ? Icons.close : Icons.add),
          ),
        ),
      ],
    );
  }
}
