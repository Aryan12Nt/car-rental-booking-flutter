import 'package:flutter/material.dart';

import '../models/car.dart';

/// Widget for displaying car images with loading and error states
class CarImageWidget extends StatelessWidget {
  final Car car;
  final double height;
  final BoxFit fit;

  const CarImageWidget({
    super.key,
    required this.car,
    this.height = 200,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (car.imageUrl != null && car.imageUrl!.isNotEmpty) {
      return SizedBox(
        height: height,
        width: double.infinity,
        child: Image.network(
          car.imageUrl!,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholderImage(colorScheme, height);
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: height,
              color: colorScheme.surfaceVariant,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                  color: colorScheme.primary,
                ),
              ),
            );
          },
        ),
      );
    }
    return _buildPlaceholderImage(colorScheme, height);
  }

  Widget _buildPlaceholderImage(ColorScheme colorScheme, double height) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primaryContainer,
            colorScheme.secondaryContainer,
          ],
        ),
      ),
      child: Icon(
        Icons.directions_car,
        size: height * 0.4,
        color: colorScheme.onPrimaryContainer,
      ),
    );
  }
}
