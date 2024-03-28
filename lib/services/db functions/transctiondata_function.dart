import 'package:hive_flutter/adapters.dart';
import 'package:smart_chitty/services/models/monthly_collection_model.dart';

List<MonthlyCollection> data = [];

Future<void> fetchMemberDatas() async {
  final collectionBox = await Hive.openBox<MonthlyCollection>('collections');
  final transactionDb = collectionBox.values.toList();
  data = transactionDb;
data.sort((b, a) {
  try {
    // Split the month string into month and year components
    final aMonthComponents = a.month.split('-');
    final bMonthComponents = b.month.split('-');

    // Parse the month components as integers
    final aMonthNum = int.parse(aMonthComponents[0]);
    final bMonthNum = int.parse(bMonthComponents[0]);

    // Parse the year components as integers
    final aYear = int.parse(aMonthComponents[1]);
    final bYear = int.parse(bMonthComponents[1]);

    // Compare the years first
    if (aYear != bYear) {
      return aYear.compareTo(bYear);
    }

    // If the years are the same, compare the months
    return aMonthNum.compareTo(bMonthNum);
  } catch (e) {
    // Handle invalid format by returning a default value or taking appropriate action
    print('Invalid month format: ${a.month}');
    return 0;
  }
});
}


