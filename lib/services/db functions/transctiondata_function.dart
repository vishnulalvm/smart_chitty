import 'package:hive_flutter/adapters.dart';
import 'package:smart_chitty/services/models/monthly_collection_model.dart';

List<MonthlyCollection> data = [];

Future<void> fetchMemberDatas() async {
  final collectionBox = await Hive.openBox<MonthlyCollection>('collections');
  final transactionDb = collectionBox.values.toList();
  data = transactionDb;
data.sort((b, a) {
  try {
    final aMonthComponents = a.month.split('-');
    final bMonthComponents = b.month.split('-');
    final aMonthNum = int.parse(aMonthComponents[0]);
    final bMonthNum = int.parse(bMonthComponents[0]);
    final aYear = int.parse(aMonthComponents[1]);
    final bYear = int.parse(bMonthComponents[1]);
    if (aYear != bYear) {
      return aYear.compareTo(bYear);
    }
    return aMonthNum.compareTo(bMonthNum);
  } catch (e) {
   
    return 0;
  }
});
}


