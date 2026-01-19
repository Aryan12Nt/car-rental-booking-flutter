import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/car.dart';
import '../providers/booking_provider.dart';
import '../providers/ui_provider.dart';
import '../utils/app_strings.dart';
import '../utils/app_theme.dart';
import '../utils/booking_utils.dart';
import '../utils/date_utils.dart' as app_date_utils;
import '../widgets/common_app_bar.dart';
import '../widgets/text_extension.dart';

class BookingFormScreen extends StatelessWidget {
  final Car car;

  const BookingFormScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final uiProvider = context.watch<UIProvider>();
    final bookingProvider = context.watch<BookingProvider>();

    final startDate = uiProvider.bookingStartDate;
    final endDate = uiProvider.bookingEndDate;
    final totalPrice = BookingUtils.calculateTotalPrice(
      startDate: startDate,
      endDate: endDate,
      pricePerDay: car.pricePerDay,
    );

    return Scaffold(
      appBar: const CommonAppBar(title: AppStrings.bookCarTitle),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: uiProvider.bookingFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Car Info Card
              Card(
                color: colorScheme.surfaceContainerHighest,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppStrings.bookingDetails.titleMedium(context: context),
                      const SizedBox(height: 8),
                      car.fullName.bodyLarge(context: context),
                      const SizedBox(height: 4),
                      '\$${car.pricePerDay.toStringAsFixed(2)} ${AppStrings.perDay}'
                          .bodyMedium(
                            context: context,
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Full Name Field
              TextFormField(
                controller: uiProvider.fullNameController,
                decoration: InputDecoration(
                  labelText: AppStrings.fullNameLabel,
                  hintText: AppStrings.fullNameHint,
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.fullNameEmptyError;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Pickup Location Field
              TextFormField(
                controller: uiProvider.pickupLocationController,
                decoration: InputDecoration(
                  labelText: AppStrings.pickupLocationLabel,
                  hintText: AppStrings.pickupLocationHint,
                  prefixIcon: const Icon(Icons.location_on),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.pickupLocationEmptyError;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Start Date Field
              InkWell(
                onTap: () => uiProvider.selectBookingStartDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: AppStrings.pickupDateLabel,
                    hintText: AppStrings.pickupDateHint,
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:
                      (startDate == null
                              ? AppStrings.selectDate
                              : app_date_utils.AppDateUtils.formatDateShort(
                                  startDate,
                                ))
                          .bodyLarge(
                            context: context,
                            color: startDate == null
                                ? colorScheme.onSurfaceVariant
                                : colorScheme.onSurface,
                          ),
                ),
              ),
              const SizedBox(height: 16),

              // End Date Field
              InkWell(
                onTap: () => uiProvider.selectBookingEndDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: AppStrings.returnDateLabel,
                    hintText: AppStrings.returnDateHint,
                    prefixIcon: const Icon(Icons.event),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:
                      (endDate == null
                              ? AppStrings.selectDate
                              : app_date_utils.AppDateUtils.formatDateShort(
                                  endDate,
                                ))
                          .bodyLarge(
                            context: context,
                            color: endDate == null
                                ? colorScheme.onSurfaceVariant
                                : colorScheme.onSurface,
                          ),
                ),
              ),
              const SizedBox(height: 24),

              // Total Price Card
              if (startDate != null && endDate != null)
                Card(
                  color: colorScheme.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppStrings.totalPrice.primaryContainer(
                              context: context,
                            ),
                            const SizedBox(height: 4),
                            '\$${totalPrice.toStringAsFixed(2)}'
                                .primaryContainer(
                                  context: context,
                                  title: true,
                                ),
                            '${endDate.difference(startDate).inDays} ${AppStrings.days} × \$${car.pricePerDay.toStringAsFixed(2)}'
                                .primaryContainer(
                                  context: context,
                                  fontSize: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.fontSize,
                                ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              if (startDate != null && endDate != null)
                const SizedBox(height: 24),

              // Submit Button
              FilledButton(
                onPressed: bookingProvider.isLoading
                    ? null
                    : () => uiProvider.processBooking(context, car),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: bookingProvider.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : AppStrings.confirmBooking.custom(
                        context: context,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.surfaceColor(context),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
