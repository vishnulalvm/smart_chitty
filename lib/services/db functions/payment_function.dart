import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smart_chitty/services/models/addmember_model.dart';
import 'package:smart_chitty/services/models/payment_details_model.dart';

final List<PaymentModel> allPaymentData = [];
ValueNotifier<List<MemberModel>> schemeIdListner = ValueNotifier([]);

void insertPaymentData(PaymentModel value) async {
  final companyDb = await Hive.openBox<PaymentModel>('payment_data');
  await companyDb.add(value);
}

void getPaymentCredentials() async {
  final companyDb = await Hive.openBox<PaymentModel>('payment_data');
  allPaymentData.addAll(companyDb.values.toList());
}


Future<void> getSchemeIds() async {
  final box = await Hive.openBox<MemberModel>('members');
  schemeIdListner.value.clear();
  schemeIdListner.value.addAll(box.values.toList());
  schemeIdListner.notifyListeners();
 
}
