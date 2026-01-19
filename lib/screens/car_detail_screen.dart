import 'package:car_rental_booking/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/car.dart';
import '../router/app_routes.dart';
import '../utils/app_strings.dart';
import '../widgets/car_image_widget.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/spec_card_widget.dart';
import '../widgets/text_extension.dart';

class CarDetailScreen extends StatelessWidget {
  final Car car;

  const CarDetailScreen({super.key, required this.car});

  void _navigateToBooking(BuildContext context) {
    context.push(AppRoutes.booking, extra: car);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: const CommonAppBar(title: AppStrings.carDetails),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Car Image
            CarImageWidget(car: car, height: 300),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Car Name
                  car.fullName.headlineMedium(context: context),
                  const SizedBox(height: 8),

                  // Color
                  car.color.titleMedium(
                    context: context,
                    fontWeight: FontWeight.normal,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 24),

                  // Price Card
                  Card(
                    color: colorScheme.primaryContainer,

                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppStrings.pricePerDay.primaryContainer(
                                context: context,
                              ),
                              const SizedBox(height: 4),
                              '\$${car.pricePerDay.toStringAsFixed(2)}'
                                  .primaryContainer(
                                    context: context,
                                    title: true,
                                  ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Specifications Section
                  AppStrings.specifications.titleLarge(context: context),
                  const SizedBox(height: 16),

                  SpecCardWidget(
                    icon: Icons.people,
                    label: AppStrings.seats,
                    value: '${car.seats}',
                  ),
                  const SizedBox(height: 12),

                  SpecCardWidget(
                    icon: Icons.settings,
                    label: AppStrings.transmission,
                    value: car.transmission,
                  ),
                  const SizedBox(height: 12),

                  SpecCardWidget(
                    icon: Icons.local_gas_station,
                    label: AppStrings.fuelType,
                    value: car.fuelType,
                  ),
                  const SizedBox(height: 24),

                  // Features Section
                  if (car.features.isNotEmpty) ...[
                    AppStrings.features.titleLarge(context: context),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: car.features.map((feature) {
                        return Chip(
                          label: feature.bodySmall(context: context),
                          avatar: Icon(
                            Icons.check_circle,
                            size: 18,
                            color: colorScheme.primary,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Description
                  if (car.description != null) ...[
                    AppStrings.description.titleLarge(context: context),
                    const SizedBox(height: 12),
                    car.description!.custom(
                      context: context,
                      color: colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Book Now Button
                  Center(
                    child: FilledButton(
                      onPressed: () => _navigateToBooking(context),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 32,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: AppStrings.bookNow.custom(
                        context: context,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                          color: AppTheme.surfaceColor(context)
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
