import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_chitty/services/models/addmember_model.dart';


// int? firstSchemeId;

class FilterMemberProvider extends ChangeNotifier {
  List<MemberModel> memberDataListNotifer = [];

  void getMemberCredentials(String? schemeId) async {
    memberDataListNotifer.clear();
    final membersBox = await Hive.openBox<MemberModel>('members');
    final filteredMembers =
        membersBox.values.whereType<MemberModel>().where((member) {
print(schemeId);
      return member.schemeId == schemeId;
      
    }).toList();

    memberDataListNotifer.addAll(filteredMembers);
    notifyListeners();
  }
}
