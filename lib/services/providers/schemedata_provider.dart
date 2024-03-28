import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_chitty/services/models/scheme_model.dart';

class SchemeListProvider extends ChangeNotifier {
  List<SchemeModel> schemeListData = [];

  List<SchemeModel> sortedTransactionData = [];
  List<SchemeModel> latestSchemes = [];

  void getSchemeCredentials() async {
    final schemeDB = await Hive.openBox<SchemeModel>('schemes');
    schemeListData.addAll(schemeDB.values);
    schemeListData.sort((a, b) {
      final aDate = a.proposeDate;
      final bDate = b.proposeDate;

      if (aDate == null && bDate == null) {
        return 0; // Both paymentDates are null, consider them equal
      } else if (aDate == null) {
        return 1; // a is null, so it should come after b
      } else if (bDate == null) {
        return -1; // b is null, so it should come after a
      } else {
        return bDate.compareTo(aDate);
      }
    });
    sortedTransactionData.addAll(schemeListData);
    final fourlatestScheme = sortedTransactionData.take(4).toList();
    latestSchemes = fourlatestScheme;
      notifyListeners();
  }
}