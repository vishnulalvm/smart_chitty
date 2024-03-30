import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_chitty/services/models/addmember_model.dart';


class FilterMemberProvider extends ChangeNotifier {
  List<MemberModel> memberDataListNotifer = [];

  void getMemberCredentials(String? schemeId) async {
  
    memberDataListNotifer.clear();
    final membersBox = await Hive.openBox<MemberModel>('members');
    final allMembers = membersBox.values.toList();
    final filteredMembers =
        membersBox.values.whereType<MemberModel>().where((member) {
      return member.schemeId == schemeId;
      
    }).toList();
if(schemeId==null){
  memberDataListNotifer.addAll(allMembers);
}else{
    memberDataListNotifer.addAll(filteredMembers);
}
    notifyListeners();
  }
}
