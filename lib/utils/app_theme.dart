import 'package:flutter/material.dart';

/// Common theme utilities for text styles and colors
/// Provides centralized access to commonly used styles and colors
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Common spacing constants
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 12.0;
  static const double spacingL = 16.0;
  static const double spacingXL = 24.0;
  static const double spacingXXL = 32.0;

  // Common border radius
  static const double borderRadiusS = 8.0;
  static const double borderRadiusM = 12.0;
  static const double borderRadiusL = 16.0;

  // Common icon sizes
  static const double iconSizeS = 16.0;
  static const double iconSizeM = 20.0;
  static const double iconSizeL = 24.0;
  static const double iconSizeXL = 48.0;
  static const double iconSizeXXL = 64.0;

  // Common image heights
  static const double imageHeightS = 200.0;
  static const double imageHeightM = 250.0;
  static const double imageHeightL = 300.0;

  /// Gets the primary color from the current theme
  static Color primaryColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  /// Gets the primary container color from the current theme
  static Color primaryContainerColor(BuildContext context) {
    return Theme.of(context).colorScheme.primaryContainer;
  }

  /// Gets the on primary container color from the current theme
  static Color onPrimaryContainerColor(BuildContext context) {
    return Theme.of(context).colorScheme.onPrimaryContainer;
  }

  /// Gets the surface color from the current theme
  static Color surfaceColor(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }

  /// Gets the surface variant color from the current theme
  static Color surfaceVariantColor(BuildContext context) {
    return Theme.of(context).colorScheme.surfaceVariant;
  }

  /// Gets the on surface color from the current theme
  static Color onSurfaceColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface;
  }

  /// Gets the on surface variant color from the current theme
  static Color onSurfaceVariantColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurfaceVariant;
  }

  /// Gets the error color from the current theme
  static Color errorColor(BuildContext context) {
    return Theme.of(context).colorScheme.error;
  }

  /// Gets the secondary container color from the current theme
  static Color secondaryContainerColor(BuildContext context) {
    return Theme.of(context).colorScheme.secondaryContainer;
  }

  // Text Styles

  /// Gets headline medium text style with bold weight
  static TextStyle? headlineMediumBold(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: onSurfaceColor(context),
    );
  }

  /// Gets headline small text style with bold weight
  static TextStyle? headlineSmallBold(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: onSurfaceColor(context),
    );
  }

  /// Gets title large text style with bold weight
  static TextStyle? titleLargeBold(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.bold,
      color: onSurfaceColor(context),
    );
  }

  /// Gets title medium text style with bold weight
  static TextStyle? titleMediumBold(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: onSurfaceColor(context),
    );
  }

  /// Gets title medium text style with semi-bold weight
  static TextStyle? titleMediumSemiBold(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w600,
      color: onSurfaceColor(context),
    );
  }

  /// Gets body large text style
  static TextStyle? bodyLarge(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(color: onSurfaceColor(context));
  }

  /// Gets body large text style with medium weight
  static TextStyle? bodyLargeMedium(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w500,
      color: onSurfaceColor(context),
    );
  }

  /// Gets body medium text style
  static TextStyle? bodyMedium(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: onSurfaceColor(context));
  }

  /// Gets body medium text style with variant color
  static TextStyle? bodyMediumVariant(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: onSurfaceVariantColor(context));
  }

  /// Gets body small text style
  static TextStyle? bodySmall(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: onSurfaceColor(context));
  }

  /// Gets body small text style with variant color
  static TextStyle? bodySmallVariant(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: onSurfaceVariantColor(context));
  }

  /// Gets label small text style
  static TextStyle? labelSmall(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.labelSmall?.copyWith(color: onSurfaceColor(context));
  }

  /// Gets price text style (headline medium, bold, primary color)
  static TextStyle? priceTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: primaryColor(context),
    );
  }

  /// Gets price text style small (title medium, bold, primary color)
  static TextStyle? priceTextStyleSmall(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: primaryColor(context),
    );
  }

  /// Gets primary container text style (for text on primary container)
  static TextStyle? primaryContainerTextStyle(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: onPrimaryContainerColor(context));
  }

  /// Gets primary container title text style
  static TextStyle? primaryContainerTitleStyle(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: onPrimaryContainerColor(context),
    );
  }

  /// Gets error text style
  static TextStyle? errorTextStyle(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: errorColor(context));
  }
}
