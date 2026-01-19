import 'package:flutter/material.dart';

import 'text_extension.dart';

/// Widget for displaying car specifications as a chip with icon
class SpecChipWidget extends StatelessWidget {
  final IconData icon;
  final String label;

  const SpecChipWidget({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        label.bodyMedium(
          context: context,
          variant: true,
        ),
      ],
    );
  }
}
