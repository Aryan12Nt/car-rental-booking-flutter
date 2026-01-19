import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/mock_cars.dart';
import '../models/car.dart';
import '../providers/ui_provider.dart';
import '../router/app_routes.dart';
import '../utils/app_strings.dart';
import '../utils/back_button_handler.dart';
import '../widgets/car_image_widget.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/spec_chip_widget.dart';
import '../widgets/text_extension.dart';

class CarListScreen extends StatelessWidget {
  const CarListScreen({super.key});

  void _navigateToCarDetail(BuildContext context, Car car) {
    context.push(AppRoutes.carDetail, extra: car);
  }

  void _navigateToHistory(BuildContext context) {
    context.push(AppRoutes.history);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cars = MockCars.getCars();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          if (BackButtonHandler.handleDoubleBackPress(context)) {
            // Exit app
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        appBar: CommonAppBar(
          title: AppStrings.availableCars,
          showBackButton: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: () => _navigateToHistory(context),
              tooltip: AppStrings.bookingHistory,
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () =>
                  context.read<UIProvider>().handleLogoutWithDialog(context),
              tooltip: AppStrings.logout,
            ),
          ],
        ),
        body: cars.isEmpty
            ? EmptyStateWidget(
                icon: Icons.directions_car_outlined,
                title: AppStrings.noCarsAvailable,
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  final car = cars[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 1,
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () => _navigateToCarDetail(context, car),
                      borderRadius: BorderRadius.circular(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Car Image
                          CarImageWidget(car: car, height: 200),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Car Name and Year
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: car.fullName.titleLarge(
                                        context: context,
                                      ),
                                    ),
                                    // Price Badge
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colorScheme.primaryContainer,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child:
                                          '\$${car.pricePerDay.toStringAsFixed(2)}/day'
                                              .primaryContainer(
                                                context: context,
                                                semiBold: true,
                                              ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),

                                // Specs Row
                                Wrap(
                                  spacing: 16,
                                  runSpacing: 8,
                                  children: [
                                    SpecChipWidget(
                                      icon: Icons.people,
                                      label: '${car.seats} Seats',
                                    ),
                                    SpecChipWidget(
                                      icon: Icons.settings,
                                      label: car.transmission,
                                    ),
                                    SpecChipWidget(
                                      icon: Icons.local_gas_station,
                                      label: car.fuelType,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),

                                // Features Preview
                                if (car.features.isNotEmpty)
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: car.features.take(3).map((
                                      feature,
                                    ) {
                                      return Chip(
                                        label: feature.labelSmall(
                                          context: context,
                                        ),
                                        visualDensity: VisualDensity.compact,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        padding: EdgeInsets.zero,
                                      );
                                    }).toList(),
                                  ),
                              ],
                            ),
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
