import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/booking.dart';
import '../providers/booking_provider.dart';
import '../providers/ui_provider.dart';
import '../router/app_routes.dart';
import '../utils/app_strings.dart';
import '../utils/booking_utils.dart';
import '../utils/data_utils.dart';
import '../utils/date_utils.dart' as app_date_utils;
import '../widgets/common_app_bar.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/info_row_widget.dart';
import '../widgets/text_extension.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bookingProvider = context.watch<BookingProvider>();
    final bookings = bookingProvider.bookings;

    // Sort bookings by creation date (newest first)
    final sortedBookings = List<Booking>.from(bookings)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return PopScope(
      canPop: context.canPop(),
      onPopInvoked: (didPop) {
        if (!didPop) {
          if (context.canPop()) {
            context.pop();
          } else {
            // If we can't pop, navigate to cars list instead of closing app
            context.go(AppRoutes.cars);
          }
        }
      },
      child: Scaffold(
        appBar: CommonAppBar(
          showBackButton: true,
          onBackPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              // If we can't pop, navigate to cars list instead of closing app
              context.go(AppRoutes.cars);
            }
          },
          title: AppStrings.bookingHistoryTitle,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () =>
                  context.read<UIProvider>().handleLogoutWithDialog(context),
              tooltip: 'Logout',
            ),
          ],
        ),
        body: sortedBookings.isEmpty
            ? EmptyStateWidget(
                icon: Icons.history,
                title: AppStrings.noBookingsYet,
                message: AppStrings.noBookingsYetMessage,
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: sortedBookings.length,
                itemBuilder: (context, index) {
                  final booking = sortedBookings[index];
                  final car = DataUtils.getCarById(booking.carId);
                  final location = DataUtils.extractPickupLocation(
                    booking.notes,
                  );

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Row: Car Name and Status
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (car != null)
                                      car.fullName.titleLarge(context: context)
                                    else
                                      '${AppStrings.carId}${booking.carId}'
                                          .titleLarge(
                                            context: context,
                                            color: colorScheme.error,
                                          ),
                                    const SizedBox(height: 4),
                                    app_date_utils.AppDateUtils.formatDate(
                                      booking.startDate,
                                    ).bodyMedium(
                                      context: context,
                                      variant: true,
                                    ),
                                  ],
                                ),
                              ),
                              // Status Badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: BookingUtils.getStatusColor(
                                    booking.status,
                                    colorScheme,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: BookingUtils.getStatusColor(
                                      booking.status,
                                      colorScheme,
                                    ).withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child:
                                    BookingUtils.getStatusText(
                                      booking.status,
                                    ).labelSmall(
                                      context: context,
                                      color: BookingUtils.getStatusColor(
                                        booking.status,
                                        colorScheme,
                                      ),
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Location
                          if (location != null) ...[
                            InfoRowWidget(
                              icon: Icons.location_on,
                              label: AppStrings.location,
                              value: location,
                              iconColor: colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(height: 12),
                          ],

                          // Date Range
                          InfoRowWidget(
                            icon: Icons.calendar_today,
                            label: AppStrings.dateRange,
                            value:
                                '${app_date_utils.AppDateUtils.formatDate(booking.startDate)} - ${app_date_utils.AppDateUtils.formatDate(booking.endDate)}',
                            iconColor: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 12),

                          // Duration and Price
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 8),
                              '${booking.numberOfDays} ${booking.numberOfDays == 1 ? AppStrings.day : AppStrings.days}'
                                  .bodyMedium(context: context, variant: true),
                              const Spacer(),
                              '\$${booking.totalPrice.toStringAsFixed(2)}'
                                  .price(context: context, small: true),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
