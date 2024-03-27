import 'package:hive_flutter/adapters.dart';
import 'package:smart_chitty/services/models/payment_details_model.dart';

List<PaymentModel> transactionData = [];
List<PaymentModel> sortedTransactionData = [];
List<PaymentModel> specificTransaction = [];
List<PaymentModel> lastFourTransaction = [];
double monthlyCollection = 0;
final distinctMonths = <int>{};
Future<void> fetchMemberDatas() async {
  final box = await Hive.openBox<PaymentModel>('payments');
  final transactionDb = box.values.toList();
  transactionData = transactionDb;
  transactionData.sort((a, b) {
    final aDate = a.paymentDate;
    final bDate = b.paymentDate;

    if (aDate == null && bDate == null) {
      return 0; // Both paymentDates are null, consider them equal
    } else if (aDate == null) {
      return 1; // a is null, so it should come after b
    } else if (bDate == null) {
      return -1; // b is null, so it should come after a
    } else {
      // Sort in descending order (recent dates first)
      return bDate.compareTo(aDate);
    }
  });
  sortedTransactionData.addAll(transactionData);
  final lastFourTransactions = transactionData.take(4).toList();
  lastFourTransaction = lastFourTransactions;
}

Future<void> fetchTransactionsForMonth(int month) async {
  await fetchMemberDatas();
  final transactionsForMonth = getTransactionsByMonth(month);
  specificTransaction = transactionsForMonth;
}

List<PaymentModel> getTransactionsByMonth(int month) {
  return transactionData.where((transaction) {
    final date = transaction.paymentDate;
    return date != null && date.month == month;
  }).toList();
}

double calculateTotalMonthlyCollection() {
  double totalCollection = 0;
  for (var transaction in specificTransaction) {
    totalCollection += double.tryParse(transaction.payment) ?? 0;
    monthlyCollection = totalCollection;
  }
  for (final transaction in transactionData) {
    final paymentDate = transaction.paymentDate;
    if (paymentDate != null) {
      distinctMonths.add(paymentDate.month);
    }
  }
  return totalCollection;
}