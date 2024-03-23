import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_chitty/main.dart';
import 'package:smart_chitty/models/addmember_model.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_chitty/models/scheme_model.dart';
import 'package:smart_chitty/widgets/choice_chips.dart';

ValueNotifier<List<MemberModel>> memberDataListNotifer = ValueNotifier([]);
ValueNotifier<List<SchemeModel>> schemeChipListner = ValueNotifier([]);

int? firstSchemeId;

// void addScheme(MemberModel value) {
//   memberDataListNotifer.value.add(value);
//   memberDataListNotifer.notifyListeners();
// }

// filltering the member

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
      .where((member) => member.schemeId == schemeId)
      .toList();
  memberDataListNotifer.value.addAll(filteredMembers);
  memberDataListNotifer.notifyListeners();
  schemeChipListner.notifyListeners();
}

Future<void> getSchemeIds() async {
  final box = await Hive.openBox<SchemeModel>('schemes');
  schemeChipListner.value.clear();
  schemeChipListner.value.addAll(box.values.toList());
  if (schemeChipListner.value.isNotEmpty) {
    int? firstId = int.tryParse(schemeChipListner.value.first.schemeId);
    firstSchemeId = firstId;
    selectedSchemeId = firstId;
    String selectedIdString = firstSchemeId.toString().padLeft(4, '0');
    getMemberCredentials(selectedIdString);
  }
  memberDataListNotifer.notifyListeners();
  schemeChipListner.notifyListeners();
}
