import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_chitty/models/scheme_model.dart';
import 'package:flutter/foundation.dart';



ValueNotifier<List<SchemeModel>> schemeDateListNotifer = ValueNotifier([]);

void addScheme (SchemeModel value){
  schemeDateListNotifer.value.add(value);
  schemeDateListNotifer.notifyListeners();
  
}

void getSchemeCredentials() async {
  schemeDateListNotifer.value.clear();
  final schemeDB = await Hive.openBox<SchemeModel>('schemes');

  schemeDateListNotifer.value.addAll(schemeDB.values);
  schemeDateListNotifer.notifyListeners();


}