// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentModelAdapter extends TypeAdapter<PaymentModel> {
  @override
  final int typeId = 4;

  @override
  PaymentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentModel(
      paymentMonth: fields[7] as dynamic,
      imagePath: fields[5] as String,
      memberModel: fields[6] as MemberModel,
      installmentCount: fields[4] as int,
      schemeId: fields[0] as String,
      memberId: fields[1] as String,
      payment: fields[2] as String,
      paymentDate: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.schemeId)
      ..writeByte(1)
      ..write(obj.memberId)
      ..writeByte(2)
      ..write(obj.payment)
      ..writeByte(3)
      ..write(obj.paymentDate)
      ..writeByte(4)
      ..write(obj.installmentCount)
      ..writeByte(5)
      ..write(obj.imagePath)
      ..writeByte(6)
      ..write(obj.memberModel)
      ..writeByte(7)
      ..write(obj.paymentMonth);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
