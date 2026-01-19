/// App route paths and names
/// Centralized route constants to avoid hardcoding route strings
class AppRoutes {
  // Private constructor to prevent instantiation
  AppRoutes._();

  // Route paths
  static const String login = '/';
  static const String cars = '/cars';
  static const String carDetail = '/car';
  static const String booking = '/booking';
  static const String confirmation = '/confirmation';
  static const String history = '/history';

  // Route names (for named navigation)
  static const String loginName = 'login';
  static const String carsName = 'cars';
  static const String carDetailName = 'car-detail';
  static const String bookingName = 'booking';
  static const String confirmationName = 'confirmation';
  static const String historyName = 'history';
}
