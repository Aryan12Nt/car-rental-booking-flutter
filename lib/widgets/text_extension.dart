import 'package:flutter/material.dart';

import '../utils/app_theme.dart';

/// Extension on String to create styled Text widgets
/// Provides convenient methods for common text styling patterns
extension TextExtension on String {
  /// Creates a Text widget with headline medium style
  Widget headlineMedium({
    BuildContext? context,
    FontWeight? fontWeight,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? fontSize,
  }) {
    return _buildText(
      context: context,
      textStyle: context != null
          ? AppTheme.headlineMediumBold(context)
          : null,
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      fontSize: fontSize,
    );
  }

  /// Creates a Text widget with headline small style
  Widget headlineSmall({
    BuildContext? context,
    FontWeight? fontWeight,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? fontSize,
  }) {
    return _buildText(
      context: context,
      textStyle: context != null
          ? AppTheme.headlineSmallBold(context)
          : null,
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      fontSize: fontSize,
    );
  }

  /// Creates a Text widget with title large style
  Widget titleLarge({
    BuildContext? context,
    FontWeight? fontWeight,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? fontSize,
  }) {
    return _buildText(
      context: context,
      textStyle: context != null
          ? AppTheme.titleLargeBold(context)
          : null,
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      fontSize: fontSize,
    );
  }

  /// Creates a Text widget with title medium style
  Widget titleMedium({
    BuildContext? context,
    FontWeight? fontWeight,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? fontSize,
    bool semiBold = false,
  }) {
    return _buildText(
      context: context,
      textStyle: context != null
          ? (semiBold
              ? AppTheme.titleMediumSemiBold(context)
              : AppTheme.titleMediumBold(context))
          : null,
      fontWeight: fontWeight ?? (semiBold ? FontWeight.w600 : FontWeight.bold),
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      fontSize: fontSize,
    );
  }

  /// Creates a Text widget with body large style
  Widget bodyLarge({
    BuildContext? context,
    FontWeight? fontWeight,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? fontSize,
    bool medium = false,
  }) {
    return _buildText(
      context: context,
      textStyle: context != null
          ? (medium
              ? AppTheme.bodyLargeMedium(context)
              : AppTheme.bodyLarge(context))
          : null,
      fontWeight: fontWeight ?? (medium ? FontWeight.w500 : FontWeight.normal),
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      fontSize: fontSize,
    );
  }

  /// Creates a Text widget with body medium style
  Widget bodyMedium({
    BuildContext? context,
    FontWeight? fontWeight,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? fontSize,
    bool variant = false,
  }) {
    return _buildText(
      context: context,
      textStyle: context != null
          ? (variant
              ? AppTheme.bodyMediumVariant(context)
              : AppTheme.bodyMedium(context))
          : null,
      fontWeight: fontWeight,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      fontSize: fontSize,
    );
  }

  /// Creates a Text widget with body small style
  Widget bodySmall({
    BuildContext? context,
    FontWeight? fontWeight,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? fontSize,
    bool variant = false,
  }) {
    return _buildText(
      context: context,
      textStyle: context != null
          ? (variant
              ? AppTheme.bodySmallVariant(context)
              : AppTheme.bodySmall(context))
          : null,
      fontWeight: fontWeight,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      fontSize: fontSize,
    );
  }

  /// Creates a Text widget with label small style
  Widget labelSmall({
    BuildContext? context,
    FontWeight? fontWeight,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? fontSize,
  }) {
    return _buildText(
      context: context,
      textStyle: context != null ? AppTheme.labelSmall(context) : null,
      fontWeight: fontWeight,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      fontSize: fontSize,
    );
  }

  /// Creates a Text widget with price style (headline medium, bold, primary color)
  Widget price({
    BuildContext? context,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? fontSize,
    bool small = false,
  }) {
    return _buildText(
      context: context,
      textStyle: context != null
          ? (small
              ? AppTheme.priceTextStyleSmall(context)
              : AppTheme.priceTextStyle(context))
          : null,
      fontWeight: FontWeight.bold,
      color: context != null
          ? (small
              ? AppTheme.primaryColor(context)
              : AppTheme.primaryColor(context))
          : null,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      fontSize: fontSize,
    );
  }

  /// Creates a Text widget with error style
  Widget error({
    BuildContext? context,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? fontSize,
  }) {
    return _buildText(
      context: context,
      textStyle: context != null ? AppTheme.errorTextStyle(context) : null,
      fontWeight: FontWeight.normal,
      color: context != null ? AppTheme.errorColor(context) : null,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      fontSize: fontSize,
    );
  }

  /// Creates a Text widget with primary container style
  Widget primaryContainer({
    BuildContext? context,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? fontSize,
    bool title = false,
    bool semiBold = false,
  }) {
    return _buildText(
      context: context,
      textStyle: context != null
          ? (title
              ? AppTheme.primaryContainerTitleStyle(context)
              : AppTheme.primaryContainerTextStyle(context))
          : null,
      fontWeight: fontWeight ??
          (title
              ? FontWeight.bold
              : (semiBold ? FontWeight.w600 : FontWeight.normal)),
      color: context != null
          ? AppTheme.onPrimaryContainerColor(context)
          : null,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      fontSize: fontSize,
    );
  }

  /// Creates a custom Text widget with full control
  Widget custom({
    BuildContext? context,
    TextStyle? style,
    FontWeight? fontWeight,
    Color? color,
    double? fontSize,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
  }) {
    TextStyle? finalStyle = style;
    
    if (context != null) {
      final theme = Theme.of(context);
      finalStyle = theme.textTheme.bodyMedium?.copyWith(
        fontWeight: fontWeight,
        color: color ?? AppTheme.onSurfaceColor(context),
        fontSize: fontSize,
        height: height,
        letterSpacing: letterSpacing,
        decoration: decoration,
      );
    } else if (style != null) {
      finalStyle = style.copyWith(
        fontWeight: fontWeight,
        color: color,
        fontSize: fontSize,
        height: height,
        letterSpacing: letterSpacing,
        decoration: decoration,
      );
    } else {
      finalStyle = TextStyle(
        fontWeight: fontWeight,
        color: color,
        fontSize: fontSize,
        height: height,
        letterSpacing: letterSpacing,
        decoration: decoration,
      );
    }

    return Text(
      this,
      style: finalStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow ?? (maxLines != null ? TextOverflow.ellipsis : null),
    );
  }

  /// Internal helper method to build Text widget
  Widget _buildText({
    BuildContext? context,
    TextStyle? textStyle,
    FontWeight? fontWeight,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double? fontSize,
  }) {
    TextStyle? finalStyle = textStyle;

    if (finalStyle != null) {
      finalStyle = finalStyle.copyWith(
        fontWeight: fontWeight ?? finalStyle.fontWeight,
        color: color ?? finalStyle.color,
        fontSize: fontSize ?? finalStyle.fontSize,
      );
    } else {
      finalStyle = TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color,
        fontSize: fontSize,
      );
    }

    return Text(
      this,
      style: finalStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow ?? (maxLines != null ? TextOverflow.ellipsis : null),
    );
  }
}
