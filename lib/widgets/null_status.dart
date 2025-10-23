import 'package:flutter/material.dart';

import '../common/common.dart';

class NullStatus extends StatelessWidget {
  final String label;
  final IconData? icon;

  const NullStatus({super.key, required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.toBold,
          ),
        ],
      ),
    );
  }
}
