import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_chitty/services/models/addmember_model.dart';
part 'payment_details_model.g.dart';

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

  @HiveField(4)
  int installmentCount = 0;

  @HiveField(5)
  final String imagePath;

  @HiveField(6)
  final MemberModel memberModel;

  PaymentModel({
    required this.imagePath,
    required this.memberModel,
    required this.installmentCount,
    required this.schemeId,
    required this.memberId,
    required this.payment,
    required this.paymentDate,
  });
}
