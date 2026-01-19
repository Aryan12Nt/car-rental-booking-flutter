import 'package:flutter/material.dart';

import 'app_strings.dart';

/// Utility class for handling double back press to exit
class BackButtonHandler {
  // Private constructor to prevent instantiation
  BackButtonHandler._();

  static DateTime? _lastBackPressTime;

  /// Handles double back press to exit
  /// Returns true if app should exit, false otherwise
  /// Shows a snackbar message on first press
  static bool handleDoubleBackPress(BuildContext context) {
    final now = DateTime.now();

    // If this is the first press or more than 2 seconds have passed
    if (_lastBackPressTime == null ||
        now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
      // First press - show message
      _lastBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(AppStrings.pressBackAgainToExit),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false; // Don't exit yet
    } else {
      // Second press within 2 seconds - exit app
      return true; // Exit app
    }
  }

  /// Resets the back press timer
  static void reset() {
    _lastBackPressTime = null;
  }
}
