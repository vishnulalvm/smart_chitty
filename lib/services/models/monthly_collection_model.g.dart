// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_collection_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MonthlyCollectionAdapter extends TypeAdapter<MonthlyCollection> {
  @override
  final int typeId = 5;

  @override
  MonthlyCollection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MonthlyCollection(
      month: fields[0] as String,
      sales: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MonthlyCollection obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.month)
      ..writeByte(1)
      ..write(obj.sales);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthlyCollectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
