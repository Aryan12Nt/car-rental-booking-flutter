import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/booking.dart';
import '../models/car.dart';
import '../providers/auth_provider.dart';
import '../screens/booking_confirmation_screen.dart';
import '../screens/booking_form_screen.dart';
import '../screens/booking_history_screen.dart';
import '../screens/car_detail_screen.dart';
import '../screens/car_list_screen.dart';
import '../screens/login_screen.dart';
import '../utils/app_strings.dart';
import 'app_routes.dart';

/// Creates the app router with authentication guard
///
/// The router automatically redirects:
/// - Unauthenticated users to login page (/)
/// - Authenticated users away from login page to cars list (/cars)
GoRouter createAppRouter(AuthProvider authProvider) {
  return GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: authProvider,
    redirect: (BuildContext context, GoRouterState state) {
      final isLoggedIn = authProvider.isLoggedIn;
      final isLoginRoute = state.matchedLocation == AppRoutes.login;

      // If not logged in and trying to access protected route, redirect to login
      if (!isLoggedIn && !isLoginRoute) {
        return AppRoutes.login;
      }

      // If logged in and trying to access login, redirect to cars
      if (isLoggedIn && isLoginRoute) {
        return AppRoutes.cars;
      }

      return null; // No redirect needed
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.loginName,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.cars,
        name: AppRoutes.carsName,
        builder: (context, state) => const CarListScreen(),
      ),
      GoRoute(
        path: AppRoutes.carDetail,
        name: AppRoutes.carDetailName,
        builder: (context, state) {
          final car = state.extra as Car?;
          if (car == null) {
            // If no car provided, redirect to cars list
            return const CarListScreen();
          }
          return CarDetailScreen(car: car);
        },
      ),
      GoRoute(
        path: AppRoutes.booking,
        name: AppRoutes.bookingName,
        builder: (context, state) {
          final car = state.extra as Car?;
          if (car == null) {
            // If no car provided, redirect to cars list
            return const CarListScreen();
          }
          return BookingFormScreen(car: car);
        },
      ),
      GoRoute(
        path: AppRoutes.confirmation,
        name: AppRoutes.confirmationName,
        builder: (context, state) {
          final booking = state.extra as Booking?;
          return BookingConfirmationScreen(booking: booking);
        },
      ),
      GoRoute(
        path: AppRoutes.history,
        name: AppRoutes.historyName,
        builder: (context, state) => const BookingHistoryScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('${AppStrings.error} ${state.error}')),
    ),
  );
}

// Global router instance (will be initialized in main.dart)
GoRouter? _appRouter;

/// Gets the app router instance
/// Note: Must be initialized in main.dart using initializeAppRouter()
GoRouter get appRouter {
  if (_appRouter == null) {
    throw Exception(
      'Router not initialized. Call initializeAppRouter() in main.dart with AuthProvider',
    );
  }
  return _appRouter!;
}

/// Initializes the app router with the provided AuthProvider
/// This should be called in main.dart after setting up Provider
void initializeAppRouter(AuthProvider authProvider) {
  _appRouter = createAppRouter(authProvider);
}
