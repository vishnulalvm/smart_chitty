import 'package:hive_flutter/hive_flutter.dart';

part 'addmember_model.g.dart';

@HiveType(typeId: 3)
class MemberModel {
  @HiveField(0)
  final String memberName;

  @HiveField(1)
  final String contactNumber;

  @HiveField(2)
  final String memberAge;

  @HiveField(3)
  final String memberAddress;

  @HiveField(4)
  final String avatar;
  

  @HiveField(5)
  final String idFront;

  @HiveField(6)
  final String idBack;

   @HiveField(7)
  final String? schemeId;
  MemberModel({
    required this.memberName,
    required this.contactNumber,
    required this.memberAge,
    required this.memberAddress,
    required this.avatar,
    required this.idFront,
    required this.idBack,
    required this.schemeId,
  });
}
