import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 4)
class PaymentModel {
  @HiveField(0)
  final String schemeId;

  @HiveField(1)
  final String memberId;

  @HiveField(2)
  final String payment;

  @HiveField(3)
  final DateTime? paymentDate;

  PaymentModel({
    required this.schemeId,
    required this.memberId,
    required this.payment,
    required this.paymentDate,
  });
}
