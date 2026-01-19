import 'package:hive/hive.dart';

part 'car.g.dart';

@HiveType(typeId: 0)
class Car extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String make;

  @HiveField(2)
  final String model;

  @HiveField(3)
  final int year;

  @HiveField(4)
  final String color;

  @HiveField(5)
  final double pricePerDay;

  @HiveField(6)
  final String? imageUrl;

  @HiveField(7)
  final bool available;

  @HiveField(8)
  final String transmission; // e.g., "Automatic", "Manual"

  @HiveField(9)
  final int seats;

  @HiveField(10)
  final String fuelType; // e.g., "Petrol", "Diesel", "Electric"

  @HiveField(11)
  final List<String> features; // e.g., ["GPS", "Bluetooth", "Air Conditioning"]

  @HiveField(12)
  final String? description;

  Car({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.pricePerDay,
    this.imageUrl,
    this.available = true,
    required this.transmission,
    required this.seats,
    required this.fuelType,
    this.features = const [],
    this.description,
  });

  /// Returns the full car name in format: "Make Model (Year)"
  String get fullName => '$make $model ($year)';

  Car copyWith({
    String? id,
    String? make,
    String? model,
    int? year,
    String? color,
    double? pricePerDay,
    String? imageUrl,
    bool? available,
    String? transmission,
    int? seats,
    String? fuelType,
    List<String>? features,
    String? description,
  }) {
    return Car(
      id: id ?? this.id,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      color: color ?? this.color,
      pricePerDay: pricePerDay ?? this.pricePerDay,
      imageUrl: imageUrl ?? this.imageUrl,
      available: available ?? this.available,
      transmission: transmission ?? this.transmission,
      seats: seats ?? this.seats,
      fuelType: fuelType ?? this.fuelType,
      features: features ?? this.features,
      description: description ?? this.description,
    );
  }
}
