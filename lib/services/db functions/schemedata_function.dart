import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_chitty/services/models/scheme_model.dart';
import 'package:flutter/foundation.dart';

ValueNotifier<List<SchemeModel>> schemeListNotifer = ValueNotifier([]);

// void addScheme (SchemeModel value){
//   schemeListNotifer.value.add(value);
//   schemeListNotifer.notifyListeners();
  
// }

void getSchemeCredentials() async {
  schemeListNotifer.value.clear();
  final schemeDB = await Hive.openBox<SchemeModel>('schemes');
  schemeListNotifer.value.addAll(schemeDB.values);
  schemeListNotifer.notifyListeners();


}