import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/booking.dart';

/// Provider for managing booking state and persistence
/// Uses Hive for local storage of bookings
class BookingProvider extends ChangeNotifier {
  static const String _bookingsBoxName = 'bookings';

  Box<Booking>? _bookingsBox;
  List<Booking> _bookings = [];
  bool _isLoading = false;

  /// Returns an unmodifiable list of all bookings
  List<Booking> get bookings => List.unmodifiable(_bookings);
  
  /// Returns true if a booking operation is in progress
  bool get isLoading => _isLoading;

  /// Gets the most recently created booking
  /// Returns null if no bookings exist
  Booking? get latestBooking {
    if (_bookings.isEmpty) return null;
    // Create a copy to avoid mutating the original list
    final sorted = List<Booking>.from(_bookings)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted.first;
  }

  BookingProvider() {
    _initializeBox();
  }

  /// Initializes the Hive box and loads existing bookings
  Future<void> _initializeBox() async {
    try {
      _bookingsBox = await Hive.openBox<Booking>(_bookingsBoxName);
      _loadBookings();
    } catch (e) {
      debugPrint('Error initializing bookings box: $e');
      // If box is already open, get the existing instance
      if (Hive.isBoxOpen(_bookingsBoxName)) {
        _bookingsBox = Hive.box<Booking>(_bookingsBoxName);
        _loadBookings();
      }
    }
  }

  /// Loads all bookings from Hive box
  void _loadBookings() {
    if (_bookingsBox == null) return;

    try {
      _bookings = _bookingsBox!.values.toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading bookings: $e');
      _bookings = [];
    }
  }

  /// Adds a new booking to Hive and updates the local list
  Future<void> addBooking(Booking booking) async {
    if (_bookingsBox == null) {
      await _initializeBox();
    }

    if (_bookingsBox == null) {
      debugPrint('Bookings box is not available');
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await _bookingsBox!.put(booking.id, booking);
      _bookings.add(booking);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Error adding booking: $e');
      rethrow;
    }
  }

  /// Gets a booking by ID
  Booking? getBookingById(String id) {
    if (_bookingsBox == null) return null;
    try {
      return _bookingsBox!.get(id);
    } catch (e) {
      debugPrint('Error getting booking by ID: $e');
      return null;
    }
  }

  /// Updates an existing booking
  Future<void> updateBooking(Booking booking) async {
    if (_bookingsBox == null) {
      await _initializeBox();
    }

    if (_bookingsBox == null) {
      debugPrint('Bookings box is not available');
      return;
    }

    try {
      await _bookingsBox!.put(booking.id, booking);
      final index = _bookings.indexWhere((b) => b.id == booking.id);
      if (index != -1) {
        _bookings[index] = booking;
      } else {
        _bookings.add(booking);
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error updating booking: $e');
      rethrow;
    }
  }

  /// Deletes a booking
  Future<void> deleteBooking(String id) async {
    if (_bookingsBox == null) {
      await _initializeBox();
    }

    if (_bookingsBox == null) {
      debugPrint('Bookings box is not available');
      return;
    }

    try {
      await _bookingsBox!.delete(id);
      _bookings.removeWhere((b) => b.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting booking: $e');
      rethrow;
    }
  }

  /// Gets bookings for a specific user
  List<Booking> getBookingsByUserId(String userId) {
    return _bookings.where((b) => b.userId == userId).toList();
  }

  /// Gets bookings for a specific car
  List<Booking> getBookingsByCarId(String carId) {
    return _bookings.where((b) => b.carId == carId).toList();
  }

  /// Clears all bookings from Hive and local list
  /// This is typically called when a user logs out
  Future<void> clearAllBookings() async {
    if (_bookingsBox == null) {
      await _initializeBox();
    }

    if (_bookingsBox == null) {
      debugPrint('Bookings box is not available');
      return;
    }

    try {
      // Clear all bookings from Hive
      await _bookingsBox!.clear();
      // Clear local list
      _bookings.clear();
      notifyListeners();
      debugPrint('All bookings cleared successfully');
    } catch (e) {
      debugPrint('Error clearing bookings: $e');
      rethrow;
    }
  }

  /// Clears bookings for a specific user
  /// This is typically called when a user logs out
  Future<void> clearBookingsByUserId(String userId) async {
    if (_bookingsBox == null) {
      await _initializeBox();
    }

    if (_bookingsBox == null) {
      debugPrint('Bookings box is not available');
      return;
    }

    try {
      // Get all booking IDs for this user
      final userBookingIds = _bookings
          .where((b) => b.userId == userId)
          .map((b) => b.id)
          .toList();

      // Delete each booking from Hive
      for (final id in userBookingIds) {
        await _bookingsBox!.delete(id);
      }

      // Remove from local list
      _bookings.removeWhere((b) => b.userId == userId);
      notifyListeners();
      debugPrint('Bookings cleared for user: $userId');
    } catch (e) {
      debugPrint('Error clearing bookings for user: $e');
      rethrow;
    }
  }
}
