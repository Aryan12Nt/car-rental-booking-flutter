import 'package:hive/hive.dart';

part 'booking.g.dart';

@HiveType(typeId: 1)
class Booking extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String carId;

  @HiveField(2)
  final String userId;

  @HiveField(3)
  final DateTime startDate;

  @HiveField(4)
  final DateTime endDate;

  @HiveField(5)
  final double totalPrice;

  @HiveField(6)
  final BookingStatus status;

  @HiveField(7)
  final DateTime createdAt;

  @HiveField(8)
  final String? notes;

  Booking({
    required this.id,
    required this.carId,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    this.status = BookingStatus.pending,
    DateTime? createdAt,
    this.notes,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Returns the number of days between start and end date
  int get numberOfDays {
    return endDate.difference(startDate).inDays;
  }

  /// Returns true if the booking is currently active
  /// (status is confirmed and current date is between start and end dates)
  bool get isActive {
    final now = DateTime.now();
    return status == BookingStatus.confirmed &&
        startDate.isBefore(now) &&
        endDate.isAfter(now);
  }

  Booking copyWith({
    String? id,
    String? carId,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    double? totalPrice,
    BookingStatus? status,
    DateTime? createdAt,
    String? notes,
  }) {
    return Booking(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      notes: notes ?? this.notes,
    );
  }
}

@HiveType(typeId: 2)
enum BookingStatus {
  @HiveField(0)
  pending,

  @HiveField(1)
  confirmed,

  @HiveField(2)
  cancelled,

  @HiveField(3)
  completed,
}
