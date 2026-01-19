// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarAdapter extends TypeAdapter<Car> {
  @override
  final int typeId = 0;

  @override
  Car read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Car(
      id: fields[0] as String,
      make: fields[1] as String,
      model: fields[2] as String,
      year: fields[3] as int,
      color: fields[4] as String,
      pricePerDay: fields[5] as double,
      imageUrl: fields[6] as String?,
      available: fields[7] as bool,
      transmission: fields[8] as String,
      seats: fields[9] as int,
      fuelType: fields[10] as String,
      features: (fields[11] as List).cast<String>(),
      description: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Car obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.make)
      ..writeByte(2)
      ..write(obj.model)
      ..writeByte(3)
      ..write(obj.year)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.pricePerDay)
      ..writeByte(6)
      ..write(obj.imageUrl)
      ..writeByte(7)
      ..write(obj.available)
      ..writeByte(8)
      ..write(obj.transmission)
      ..writeByte(9)
      ..write(obj.seats)
      ..writeByte(10)
      ..write(obj.fuelType)
      ..writeByte(11)
      ..write(obj.features)
      ..writeByte(12)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
