import 'package:flutter/material.dart';

import '../models/booking.dart';

/// Utility functions for booking calculations and operations
class BookingUtils {
  // Private constructor to prevent instantiation
  BookingUtils._();

  /// Calculates the total price for a booking
  /// [startDate] - Pickup date
  /// [endDate] - Return date
  /// [pricePerDay] - Price per day for the car
  static double calculateTotalPrice({
    required DateTime? startDate,
    required DateTime? endDate,
    required double pricePerDay,
  }) {
    if (startDate == null || endDate == null) return 0.0;
    final days = endDate.difference(startDate).inDays;
    return days * pricePerDay;
  }

  /// Calculates the number of days between two dates
  static int calculateDays(DateTime startDate, DateTime endDate) {
    return endDate.difference(startDate).inDays;
  }

  /// Gets the status text for a booking status
  static String getStatusText(BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.cancelled:
        return 'Cancelled';
      case BookingStatus.completed:
        return 'Completed';
    }
  }

  /// Gets the status color for a booking status
  static Color getStatusColor(BookingStatus status, ColorScheme colorScheme) {
    switch (status) {
      case BookingStatus.pending:
        return colorScheme.onSurfaceVariant;
      case BookingStatus.confirmed:
        return colorScheme.primary;
      case BookingStatus.cancelled:
        return colorScheme.error;
      case BookingStatus.completed:
        return colorScheme.tertiary;
    }
  }
}
