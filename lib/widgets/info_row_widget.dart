import 'package:flutter/material.dart';

import 'text_extension.dart';

/// Widget for displaying information in a row format with icon, label, and value
class InfoRowWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;

  const InfoRowWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: iconColor ?? colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label.bodySmall(
                context: context,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 4),
              value.bodyLarge(
                context: context,
                medium: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
