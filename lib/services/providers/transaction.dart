import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_chitty/services/models/payment_details_model.dart';
 double monthlyCollection =0;

class TransactionHistoryProvider extends ChangeNotifier {
  List<PaymentModel> transactionData = [];
  List<PaymentModel> sortedTransactionData = [];
  List<PaymentModel> specificTransaction = [];
  List<PaymentModel> lastFourTransaction = [];
 
  Future<void> fetchTransactionsForMonth(String stringmonth) async {
    await fetchMemberDatas();
    final transactionsForMonth = getTransactionsByMonth(stringmonth);
    specificTransaction = transactionsForMonth;
    notifyListeners();
  }

  Future<void> fetchMemberDatas() async {
    sortedTransactionData.clear();
    lastFourTransaction.clear();
    final box = await Hive.openBox<PaymentModel>('payments');
    final transactionDb = box.values.toList();
    transactionData = transactionDb;
    transactionData.sort((a, b) {
      final aDate = a.paymentDate;
      final bDate = b.paymentDate;

      if (aDate == null && bDate == null) {
        return 0;
      } else if (aDate == null) {
        return 1; 
      } else if (bDate == null) {
        return -1; 
      } else {
        return bDate.compareTo(aDate);
      }
    });
    sortedTransactionData.addAll(transactionData);
    final lastFourTransactions = transactionData.take(4).toList();
    lastFourTransaction = lastFourTransactions;
    notifyListeners();
  }

  List<PaymentModel> getTransactionsByMonth(String month) {
    return transactionData.where((transaction) {
      final monthPart = month;
      final date = transaction.paymentMonth;
      return  date == monthPart ;
    }).toList();
  }
Future<void> deleteTransaction(String key) async {
  final box = await Hive.openBox<PaymentModel>('payments');
  final transactionToDelete = box.get(key);

  if (transactionToDelete != null) {
    await box.delete(key);
    lastFourTransaction.remove(transactionToDelete);
    transactionData.remove(transactionToDelete);
    sortedTransactionData.remove(transactionToDelete);

    notifyListeners();
  }

}
}