import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smart_chitty/services/models/payment_details_model.dart';
ValueNotifier<List<PaymentModel>> allPaymentData = ValueNotifier([]);



void insertPaymentData(PaymentModel value) async {
  final paymentDb = await Hive.openBox<PaymentModel>('payments');
  await paymentDb.add(value);
}

void getPaymentCredentials(String? memberId) async {
  allPaymentData.value.clear();
  final paymentDb = await Hive.openBox<PaymentModel>('payments');
final filteredPayment = paymentDb.values
      .whereType<PaymentModel>()
      .where((member) => member.memberId == memberId)
      .toList();
  allPaymentData.value.addAll(filteredPayment);
  allPaymentData.notifyListeners();
}


