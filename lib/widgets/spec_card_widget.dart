import 'package:flutter/material.dart';

import 'text_extension.dart';

/// Widget for displaying car specifications in a card format
class SpecCardWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const SpecCardWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: colorScheme.onPrimaryContainer,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  label.bodyMedium(
                    context: context,
                    variant: true,
                  ),
                  const SizedBox(height: 4),
                  value.titleMedium(
                    context: context,
                    semiBold: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
