// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheme_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SchemeModelAdapter extends TypeAdapter<SchemeModel> {
  @override
  final int typeId = 2;

  @override
  SchemeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SchemeModel(
      poolAmount: fields[7] as String,
      schemeId: fields[6] as String,
      installment: fields[0] as String,
      totalMembers: fields[1] as String,
      subscription: fields[2] as String,
      commission: fields[3] as String,
      installmentType: fields[4] as String,
      proposeDate: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, SchemeModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.installment)
      ..writeByte(1)
      ..write(obj.totalMembers)
      ..writeByte(2)
      ..write(obj.subscription)
      ..writeByte(3)
      ..write(obj.commission)
      ..writeByte(4)
      ..write(obj.installmentType)
      ..writeByte(5)
      ..write(obj.proposeDate)
      ..writeByte(6)
      ..write(obj.schemeId)
      ..writeByte(7)
      ..write(obj.poolAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SchemeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
