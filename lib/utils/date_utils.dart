/// Date utility functions for formatting and operations
class AppDateUtils {
  // Private constructor to prevent instantiation
  AppDateUtils._();

  /// Formats a date to a readable string (e.g., "Jan 15, 2024")
  static String formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  /// Formats a date to a short format (e.g., "15/1/2024")
  static String formatDateShort(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  /// Gets the minimum date for booking (today)
  static DateTime getMinDate() {
    return DateTime.now();
  }

  /// Gets the maximum date for booking (1 year from now)
  static DateTime getMaxDate() {
    return DateTime.now().add(const Duration(days: 365));
  }

  /// Gets the minimum end date (1 day after start date)
  static DateTime getMinEndDate(DateTime startDate) {
    return startDate.add(const Duration(days: 1));
  }

  /// Gets the maximum end date (1 year after start date)
  static DateTime getMaxEndDate(DateTime startDate) {
    return startDate.add(const Duration(days: 365));
  }
}
