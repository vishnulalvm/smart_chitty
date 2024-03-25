import 'package:hive_flutter/hive_flutter.dart';
part 'scheme_model.g.dart';

@HiveType(typeId: 2)
class SchemeModel {
  @HiveField(0)
  final String installment;

  @HiveField(1)
  final String totalMembers;

  @HiveField(2)
  final String subscription;

  @HiveField(3)
  final String commission;

  @HiveField(4)
  final String installmentType;

  @HiveField(5)
  final DateTime? proposeDate;

  @HiveField(6)
  final String schemeId;

  @HiveField(7)
  final String poolAmount;

  SchemeModel({
    required this.poolAmount,
    required this.schemeId,
    required this.installment,
    required this.totalMembers,
    required this.subscription,
    required this.commission,
    required this.installmentType,
    required this.proposeDate,
  });
}
