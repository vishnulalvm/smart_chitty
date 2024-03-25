import 'package:hive_flutter/adapters.dart';
import 'package:smart_chitty/services/models/registration_model.dart';

final List<RegistrationModel> allData = [];

void insertData(RegistrationModel value) async {
  final companyDb = await Hive.openBox<RegistrationModel>('company_data');
  await companyDb.add(value);
}

void getUserCredentials() async {
  final companyDb = await Hive.openBox<RegistrationModel>('company_data');
  allData.addAll(companyDb.values.toList());
}
