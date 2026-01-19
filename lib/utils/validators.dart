/// Validation utility functions
class Validators {
  // Private constructor to prevent instantiation
  Validators._();

  /// Validates email format
  static bool isValidEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value);
  }

  /// Validates phone number format (10+ digits)
  static bool isValidPhone(String value) {
    final phoneRegex = RegExp(r'^[0-9]{10,}$');
    return phoneRegex.hasMatch(value.replaceAll(RegExp(r'[\s\-\(\)]'), ''));
  }

  /// Validates email or phone number
  static bool isValidEmailOrPhone(String value) {
    final trimmedValue = value.trim();
    return isValidEmail(trimmedValue) || isValidPhone(trimmedValue);
  }

  /// Validates password (minimum 6 characters)
  static bool isValidPassword(String value) {
    return value.length >= 6;
  }

  /// Validates that a value is not empty
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
}
