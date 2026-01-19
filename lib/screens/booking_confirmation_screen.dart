import 'package:car_rental_booking/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/booking.dart';
import '../providers/booking_provider.dart';
import '../router/app_routes.dart';
import '../utils/app_strings.dart';
import '../utils/data_utils.dart';
import '../utils/date_utils.dart' as app_date_utils;
import '../widgets/common_app_bar.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/info_row_widget.dart';
import '../widgets/text_extension.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final Booking? booking;

  const BookingConfirmationScreen({super.key, this.booking});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Get booking from parameter or provider
    final bookingProvider = context.watch<BookingProvider>();
    final confirmedBooking = booking ?? bookingProvider.latestBooking;

    if (confirmedBooking == null) {
      return Scaffold(
        appBar: const CommonAppBar(title: AppStrings.bookingConfirmationTitle),
        body: EmptyStateWidget(
          icon: Icons.error_outline,
          title: AppStrings.noBookingFound,
          action: FilledButton(
            onPressed: () => context.go(AppRoutes.cars),
            child: AppStrings.browseCars.custom(context: context),
          ),
        ),
      );
    }

    final car = DataUtils.getCarById(confirmedBooking.carId);
    if (car == null) {
      return Scaffold(
        appBar: const CommonAppBar(title: AppStrings.bookingConfirmationTitle),
        body: Center(
          child:
              '${AppStrings.error} ${AppStrings.carNotFound}${confirmedBooking.carId}'
                  .error(context: context),
        ),
      );
    }

    final fullName = DataUtils.extractFullName(confirmedBooking.notes);
    final pickupLocation = DataUtils.extractPickupLocation(
      confirmedBooking.notes,
    );

    return Scaffold(
      appBar: const CommonAppBar(title: AppStrings.bookingConfirmed),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Success Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                size: 80,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),

            // Success Message
            AppStrings.bookingConfirmedTitle.headlineMedium(
              context: context,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            AppStrings.bookingConfirmedMessage.bodyLarge(
              context: context,
              color: colorScheme.onSurfaceVariant,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Booking Details Card
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Car Information
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.directions_car,
                            color: colorScheme.onPrimaryContainer,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppStrings.car.bodySmall(
                                context: context,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(height: 4),
                              car.fullName.titleMedium(
                                context: context,
                                semiBold: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 32),

                    // Full Name
                    if (fullName != null) ...[
                      InfoRowWidget(
                        icon: Icons.person,
                        label: AppStrings.name,
                        value: fullName,
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Pickup Location
                    if (pickupLocation != null) ...[
                      InfoRowWidget(
                        icon: Icons.location_on,
                        label: AppStrings.pickupLocation,
                        value: pickupLocation,
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Booking Dates
                    InfoRowWidget(
                      icon: Icons.calendar_today,
                      label: AppStrings.pickupDate,
                      value: app_date_utils.AppDateUtils.formatDate(
                        confirmedBooking.startDate,
                      ),
                    ),
                    const SizedBox(height: 16),
                    InfoRowWidget(
                      icon: Icons.event,
                      label: AppStrings.returnDate,
                      value: app_date_utils.AppDateUtils.formatDate(
                        confirmedBooking.endDate,
                      ),
                    ),
                    const SizedBox(height: 16),
                    InfoRowWidget(
                      icon: Icons.access_time,
                      label: AppStrings.duration,
                      value:
                          '${confirmedBooking.numberOfDays} ${confirmedBooking.numberOfDays == 1 ? AppStrings.day : AppStrings.days}',
                    ),
                    const Divider(height: 32),

                    // Total Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppStrings.totalPrice.titleLarge(context: context),
                        '\$${confirmedBooking.totalPrice.toStringAsFixed(2)}'
                            .price(context: context, small: true),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Action Buttons
            FilledButton(
              onPressed: () => context.go(AppRoutes.cars),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: AppStrings.browseMoreCars.custom(
                context: context,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.surfaceColor(context),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => context.go(AppRoutes.history),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: AppStrings.viewBookingHistory.custom(
                context: context,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
