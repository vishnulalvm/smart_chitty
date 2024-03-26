import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_chitty/services/models/scheme_model.dart';

class SchemeIdListProvider extends ChangeNotifier{
  List<String> schemeIds = [];

  Future<void> getSchemeIds() async {
    final box = await Hive.openBox<SchemeModel>('schemes');
    final schemeData = box.values.toList();
    schemeIds = schemeData.map((scheme) => scheme.schemeId).toList();
  }
}
