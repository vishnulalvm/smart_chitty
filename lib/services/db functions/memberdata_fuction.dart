import 'package:flutter/material.dart';
import 'package:smart_chitty/main.dart';
import 'package:smart_chitty/services/models/addmember_model.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_chitty/services/models/scheme_model.dart';


ValueNotifier<List<MemberModel>> memberDataListNotifer = ValueNotifier([]);
ValueNotifier<List<SchemeModel>> schemeChipListner = ValueNotifier([]);

int? firstSchemeId;

void refreshMember(String? schemeId) async {
  memberDataListNotifer.value.clear();
  final filteredMembers = membersBox.values
      .whereType<MemberModel>()
      .where((member) => member.schemeId == schemeId)
      .toList();

  memberDataListNotifer.value.addAll(filteredMembers);
  memberDataListNotifer.notifyListeners();

}

void getMemberCredentials(String? schemeId) async {
  memberDataListNotifer.value.clear();
  final filteredMembers = membersBox.values
      .whereType<MemberModel>()
      .where((member) {
        return member.schemeId == schemeId;
      })
      .toList();
     
  memberDataListNotifer.value.addAll(filteredMembers);
  memberDataListNotifer.notifyListeners();
  schemeChipListner.notifyListeners();
}


