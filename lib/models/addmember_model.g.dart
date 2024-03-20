// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addmember_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemberModelAdapter extends TypeAdapter<MemberModel> {
  @override
  final int typeId = 3;

  @override
  MemberModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MemberModel(
      memberName: fields[0] as String,
      contactNumber: fields[1] as String,
      memberAge: fields[2] as String,
      memberAddress: fields[3] as String,
      avatar: fields[4] as String,
      idFront: fields[5] as String,
      idBack: fields[6] as String,
      schemeId: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MemberModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.memberName)
      ..writeByte(1)
      ..write(obj.contactNumber)
      ..writeByte(2)
      ..write(obj.memberAge)
      ..writeByte(3)
      ..write(obj.memberAddress)
      ..writeByte(4)
      ..write(obj.avatar)
      ..writeByte(5)
      ..write(obj.idFront)
      ..writeByte(6)
      ..write(obj.idBack)
      ..writeByte(7)
      ..write(obj.schemeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
