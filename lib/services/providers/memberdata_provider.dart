import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_chitty/main.dart';
import 'package:smart_chitty/services/models/addmember_model.dart';
import 'package:smart_chitty/services/models/scheme_model.dart';
import 'package:smart_chitty/widgets/features/choice_chips.dart';

class MemberDataProvider extends ChangeNotifier{
  List<MemberModel> memberDataList = [];
   List<SchemeModel> schemeIdList = [];

  Future<void> getSchemeIds() async {
    final box = await Hive.openBox<SchemeModel>('schemes');
    final schemeData = box.values.toList();
    schemeIdList = schemeData.map((scheme) => scheme).toList();
    if (schemeIdList.isNotEmpty) {
    fistvalue = schemeIdList.first.schemeId;
  } else {
    // Handle the case when schemeIdList is empty
    fistvalue = null; // or assign a default value
  }
     notifyListeners();
  }

  void getMemberCredentials(String? schemeId) async {
  memberDataList = membersBox.values
      .whereType<MemberModel>()
      .where((member) {
        return member.schemeId == schemeId;
      })
      .toList();
     
}
}