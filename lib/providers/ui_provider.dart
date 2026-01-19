import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/booking.dart';
import '../models/car.dart';
import '../router/app_routes.dart';
import '../utils/app_strings.dart';
import '../utils/app_theme.dart';
import '../utils/booking_utils.dart';
import '../utils/date_utils.dart' as app_date_utils;
import '../utils/validators.dart';
import '../widgets/text_extension.dart';
import 'auth_provider.dart';
import 'booking_provider.dart';

// ... (rest of imports)

// ... (inside class, after submitBooking)

/// Provider for managing UI state across the app
/// Handles form states, loading states, and other UI-related state
class UIProvider extends ChangeNotifier {
  // Login screen state
  bool _isLoginLoading = false;
  bool _obscurePassword = true;

  // Booking form state
  bool _isBookingSubmitting = false;
  DateTime? _bookingStartDate;
  DateTime? _bookingEndDate;

  // Login screen controllers
  final formKey = GlobalKey<FormState>();
  final scrollController = ScrollController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Booking form controllers
  final bookingFormKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final pickupLocationController = TextEditingController();

  // Getters
  bool get isLoginLoading => _isLoginLoading;

  bool get obscurePassword => _obscurePassword;

  bool get isBookingSubmitting => _isBookingSubmitting;

  DateTime? get bookingStartDate => _bookingStartDate;

  DateTime? get bookingEndDate => _bookingEndDate;

  // Login screen methods
  void setLoginLoading(bool value) {
    _isLoginLoading = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    if (!Validators.isNotEmpty(value)) {
      return 'Email or Phone is required';
    }
    final trimmedValue = value!.trim();
    if (!Validators.isValidEmailOrPhone(trimmedValue)) {
      return 'Please enter a valid email or phone number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (!Validators.isNotEmpty(value)) {
      return 'Password is required';
    }
    if (!Validators.isValidPassword(value!)) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> submitLogin(
    AuthProvider authProvider, {
    required VoidCallback onSuccess,
    required void Function(String) onError,
  }) async {
    if (!formKey.currentState!.validate()) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    try {
      await authProvider.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      onSuccess();
    } catch (e) {
      onError(e.toString());
    }
  }

  // Booking form methods
  void setBookingSubmitting(bool value) {
    _isBookingSubmitting = value;
    notifyListeners();
  }

  void setBookingStartDate(DateTime? date) {
    _bookingStartDate = date;
    // Reset end date if it's before the new start date
    if (_bookingEndDate != null &&
        date != null &&
        _bookingEndDate!.isBefore(date)) {
      _bookingEndDate = null;
    }
    notifyListeners();
  }

  void setBookingEndDate(DateTime? date) {
    _bookingEndDate = date;
    notifyListeners();
  }

  Future<void> selectBookingStartDate(BuildContext context) async {
    final now = app_date_utils.AppDateUtils.getMinDate();
    final firstDate = app_date_utils.AppDateUtils.getMinDate();
    final lastDate = app_date_utils.AppDateUtils.getMaxDate();

    final picked = await showDatePicker(
      context: context,
      initialDate: _bookingStartDate ?? now,
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: AppStrings.pickupDateHint,
    );

    if (picked != null) {
      setBookingStartDate(picked);
    }
  }

  Future<void> selectBookingEndDate(BuildContext context) async {
    if (_bookingStartDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppStrings.selectPickupDateFirst.bodyMedium(
            context: context,
          ),
          backgroundColor: AppTheme.errorColor(context),
        ),
      );
      return;
    }

    final firstDate = app_date_utils.AppDateUtils.getMinEndDate(
      _bookingStartDate!,
    );
    final lastDate = app_date_utils.AppDateUtils.getMaxEndDate(
      _bookingStartDate!,
    );

    final picked = await showDatePicker(
      context: context,
      initialDate: _bookingEndDate ?? firstDate,
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: AppStrings.returnDateHint,
    );

    if (picked != null) {
      setBookingEndDate(picked);
    }
  }

  void clearBookingDates() {
    _bookingStartDate = null;
    _bookingEndDate = null;
    notifyListeners();
  }

  void resetBookingForm() {
    _bookingStartDate = null;
    _bookingEndDate = null;
    fullNameController.clear();
    pickupLocationController.clear();
    notifyListeners();
  }

  Future<void> submitBooking({
    required BookingProvider bookingProvider,
    required AuthProvider authProvider,
    required Car car,
    required void Function(Booking) onSuccess,
    required void Function(String) onError,
  }) async {
    if (!bookingFormKey.currentState!.validate()) {
      return;
    }

    if (_bookingStartDate == null || _bookingEndDate == null) {
      onError('Please select both pickup and return dates');
      return;
    }

    try {
      final userId =
          authProvider.userId ??
          '${AppStrings.userPrefix}${DateTime.now().millisecondsSinceEpoch}';
      final bookingId =
          '${AppStrings.bookingPrefix}${DateTime.now().millisecondsSinceEpoch}';

      // Store full name and pickup location in notes
      final notes =
          '${AppStrings.notesFullNamePrefix}${fullNameController.text}\n${AppStrings.notesPickupLocationPrefix}${pickupLocationController.text}';

      final totalPrice = BookingUtils.calculateTotalPrice(
        startDate: _bookingStartDate,
        endDate: _bookingEndDate,
        pricePerDay: car.pricePerDay,
      );

      final booking = Booking(
        id: bookingId,
        carId: car.id,
        userId: userId,
        startDate: _bookingStartDate!,
        endDate: _bookingEndDate!,
        totalPrice: totalPrice,
        status: BookingStatus.pending,
        notes: notes,
      );

      await bookingProvider.addBooking(booking);
      resetBookingForm();
      onSuccess(booking);
    } catch (e) {
      onError(e.toString());
    }
  }

  void processBooking(BuildContext context, Car car) {
    final bookingProvider = Provider.of<BookingProvider>(
      context,
      listen: false,
    );
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    submitBooking(
      bookingProvider: bookingProvider,
      authProvider: authProvider,
      car: car,
      onSuccess: (booking) {
        if (context.mounted) {
          context.pushReplacement(AppRoutes.confirmation, extra: booking);
        }
      },
      onError: (error) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${AppStrings.bookingFailed}$error',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: AppTheme.errorColor(context),
            ),
          );
        }
      },
    );
  }

  Future<void> performLogout({
    required AuthProvider authProvider,
    required BookingProvider bookingProvider,
    required VoidCallback onSuccess,
    required void Function(String) onError,
  }) async {
    try {
      // Clear all bookings when user logs out
      await bookingProvider.clearAllBookings();
      // Then logout
      await authProvider.logout();
      onSuccess();
    } catch (e) {
      onError(e.toString());
    }
  }

  Future<void> handleLogoutWithDialog(BuildContext context) async {
    // Show confirmation dialog
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: AppStrings.logout.titleMedium(context: context),
        content: AppStrings.logoutConfirmation.bodyMedium(context: context),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: AppStrings.cancel.bodyMedium(context: context),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: AppStrings.logoutButton.bodyMedium(
              context: context,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );

    if (shouldLogout == true && context.mounted) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final bookingProvider = Provider.of<BookingProvider>(
        context,
        listen: false,
      );

      await performLogout(
        authProvider: authProvider,
        bookingProvider: bookingProvider,
        onSuccess: () {
          if (context.mounted) {
            context.go(AppRoutes.login);
          }
        },
        onError: (error) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${AppStrings.logoutFailed}$error',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: AppTheme.errorColor(context),
              ),
            );
          }
        },
      );
    }
  }
}
