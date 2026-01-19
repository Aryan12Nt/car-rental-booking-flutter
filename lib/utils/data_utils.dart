import '../data/mock_cars.dart';
import '../models/car.dart';

/// Utility functions for data extraction and retrieval
class DataUtils {
  // Private constructor to prevent instantiation
  DataUtils._();

  /// Gets a car by ID from mock data
  /// Returns null if car is not found
  static Car? getCarById(String carId) {
    try {
      return MockCars.getCars().firstWhere(
        (car) => car.id == carId,
      );
    } catch (e) {
      return null;
    }
  }

  /// Extracts full name from booking notes
  /// Notes format: "Full Name: John Doe\nPickup Location: ..."
  static String? extractFullName(String? notes) {
    if (notes == null) return null;
    final match = RegExp(r'Full Name: (.+)').firstMatch(notes);
    return match?.group(1)?.split('\n').first.trim();
  }

  /// Extracts pickup location from booking notes
  /// Notes format: "Full Name: ...\nPickup Location: New York"
  static String? extractPickupLocation(String? notes) {
    if (notes == null) return null;
    final match = RegExp(r'Pickup Location: (.+)').firstMatch(notes);
    return match?.group(1)?.trim();
  }
}
