import 'package:hive_flutter/adapters.dart';
import 'package:smart_chitty/services/models/monthly_collection_model.dart';

List<MonthlyCollection> data = [];

Future<void> fetchMemberDatas() async {
  final collectionBox = await Hive.openBox<MonthlyCollection>('collections');
  final transactionDb = collectionBox.values.toList();
  data = transactionDb;

  data.sort((a, b) {
    final aMonthComponents = a.month.split('-');
    final bMonthComponents = b.month.split('-');

    final aYear = int.parse(
        '20${aMonthComponents[1]}'); // Assuming the year format is 'yy'
    final bYear = int.parse('20${bMonthComponents[1]}');

    final aMonthAbbr = aMonthComponents[0];
    final bMonthAbbr = bMonthComponents[0];

    final aMonthNum = _getMonthNumber(aMonthAbbr);
    final bMonthNum = _getMonthNumber(bMonthAbbr);

    // Compare years first
    if (aYear != bYear) {
      return bYear.compareTo(aYear);
    }

    // If years are the same, compare months
    return bMonthNum.compareTo(aMonthNum);
  });
}

int _getMonthNumber(String monthAbbr) {
  final months = {
    'Jan': 1,
    'Feb': 2,
    'Mar': 3,
    'Apr': 4,
    'May': 5,
    'Jun': 6,
    'Jul': 7,
    'Aug': 8,
    'Sep': 9,
    'Oct': 10,
    'Nov': 11,
    'Dec': 12,
  };

  if (months.containsKey(monthAbbr)) {
    return months[monthAbbr]!;
  } else {
    // Handle the case where the monthAbbr is not found in the months map
    return 0;
  }
}
