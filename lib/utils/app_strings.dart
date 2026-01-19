/// Common static strings used throughout the application
/// Centralizes all text content for easier maintenance and localization
class AppStrings {
  // Private constructor to prevent instantiation
  AppStrings._();

  // App Name
  static const String appName = 'Car Rental Booking';

  // Login Screen
  static const String loginTitle = 'Car Rental Booking';
  static const String loginSubtitle = 'Welcome! Please login to continue.';
  static const String loginButton = 'Login';
  static const String loginFailed = 'Login failed: ';

  // Login Form Fields
  static const String emailOrPhoneLabel = 'Email or Phone Number';
  static const String emailOrPhoneHint = 'Enter your email or phone';
  static const String emailOrPhoneEmptyError =
      'Please enter your email or phone number';
  static const String emailOrPhoneInvalidError =
      'Please enter a valid email or phone number';

  static const String passwordLabel = 'Password';
  static const String passwordHint = 'Enter your password';
  static const String passwordEmptyError = 'Please enter your password';
  static const String passwordMinLengthError =
      'Password must be at least 6 characters';

  // Password Visibility
  static const String showPassword = 'Show password';
  static const String hidePassword = 'Hide password';

  // Booking Form Screen
  static const String bookCarTitle = 'Book Car';
  static const String bookingDetails = 'Booking Details';
  static const String perDay = 'per day';
  static const String fullNameLabel = 'Full Name';
  static const String fullNameHint = 'Enter your full name';
  static const String fullNameEmptyError = 'Please enter your full name';
  static const String pickupLocationLabel = 'Pickup Location';
  static const String pickupLocationHint = 'Enter pickup location';
  static const String pickupLocationEmptyError = 'Please enter pickup location';
  static const String pickupDateLabel = 'Pickup Date';
  static const String pickupDateHint = 'Select pickup date';
  static const String returnDateLabel = 'Return Date';
  static const String returnDateHint = 'Select return date';
  static const String selectDate = 'Select date';
  static const String selectPickupDateFirst = 'Please select pickup date first';
  static const String selectBothDates =
      'Please select both pickup and return dates';
  static const String totalPrice = 'Total Price';
  static const String days = 'days';
  static const String confirmBooking = 'Confirm Booking';
  static const String bookingFailed = 'Booking failed: ';

  // Car List Screen
  static const String availableCars = 'Available Cars';
  static const String noCarsAvailable = 'No cars available';
  static const String bookingHistory = 'Booking History';

  // Car Detail Screen
  static const String carDetails = 'Car Details';
  static const String bookNow = 'Book Now';
  static const String pricePerDay = 'Price per day';
  static const String specifications = 'Specifications';
  static const String features = 'Features';
  static const String description = 'Description';

  // Booking Confirmation Screen
  static const String bookingConfirmed = 'Booking Confirmed';
  static const String car = 'Car';
  static const String name = 'Name';
  static const String pickupLocation = 'Pickup Location';
  static const String pickupDate = 'Pickup Date';
  static const String returnDate = 'Return Date';
  static const String duration = 'Duration';
  static const String day = 'day';
  static const String browseMoreCars = 'Browse More Cars';
  static const String viewBookingHistory = 'View Booking History';
  static const String noBookingFound = 'No booking found';
  static const String noBookingFoundMessage =
      'It seems there was an issue confirming your booking.';

  // Booking History Screen
  static const String bookingHistoryTitle = 'Booking History';
  static const String noBookingsYet = 'No Bookings Yet';
  static const String noBookingsYetMessage =
      'Your booking history will appear here once you make a reservation.';
  static const String dates = 'Dates';
  static const String totalPriceLabel = 'Total Price';

  // Booking Status
  static const String statusPending = 'Pending';
  static const String statusConfirmed = 'Confirmed';
  static const String statusCancelled = 'Cancelled';
  static const String statusCompleted = 'Completed';

  // Logout
  static const String logout = 'Logout';
  static const String logoutConfirmation = 'Are you sure you want to logout?';
  static const String cancel = 'Cancel';
  static const String logoutButton = 'Logout';
  static const String logoutFailed = 'Logout failed: ';

  // Common
  static const String nA = 'N/A';
  static const String error = 'Error';
  static const String browseCars = 'Browse Cars';
  static const String carNotFound = 'Car not found with ID: ';
  static const String carId = 'Car ID: ';
  static const String location = 'Location';
  static const String dateRange = 'Date Range';
  static const String seats = 'Seats';
  static const String transmission = 'Transmission';
  static const String fuelType = 'Fuel Type';
  static const String bookingConfirmedTitle = 'Booking Confirmed!';
  static const String bookingConfirmationTitle = 'Booking Confirmation';
  static const String bookingConfirmedMessage =
      'Your booking has been successfully created';
  static const String pressBackAgainToExit = 'Press back again to exit';
  static const String routerError = 'Error: ';
  static const String routerNotInitialized =
      'Router not initialized. Call initializeAppRouter() in main.dart with AuthProvider';
  static const String notesFullNamePrefix = 'Full Name: ';
  static const String notesPickupLocationPrefix = 'Pickup Location: ';
  static const String userPrefix = 'user_';
  static const String bookingPrefix = 'booking_';
}
