import 'package:hive_flutter/adapters.dart';
import 'package:smart_chitty/services/models/registration_model.dart';

final List<RegistrationModel> companyDatas = [];
final List<RegistrationModel> listofcompanydata = [];


void insertData(RegistrationModel value,String key) async {
  final companyDb = await Hive.openBox<RegistrationModel>('company_data');
  await companyDb.put(value.companyName,value);
  for (final company in companyDatas) {
    listofcompanydata.add(company);
     }
}

void getUserCredentials() async {
  final companyDb = await Hive.openBox<RegistrationModel>('company_data');
  companyDatas.addAll(companyDb.values.toList());
}
