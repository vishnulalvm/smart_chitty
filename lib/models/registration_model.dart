
import 'package:hive_flutter/hive_flutter.dart';
part 'registration_model.g.dart';

@HiveType(typeId: 1)
class RegistrationModel{
  @HiveField(0)
  final String companyName;

  @HiveField(1)
  final String phoneNumber;

  @HiveField(2)
  final String whatsappLink;

  @HiveField(3)
  final String userId;

  @HiveField(4)
  final String password;
@HiveField(5)
  final String imagePath;

  RegistrationModel( {required this.companyName, required this.phoneNumber, required this.whatsappLink, required this.userId, required this.password,required this.imagePath,});

}