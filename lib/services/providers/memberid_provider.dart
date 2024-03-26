import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_chitty/services/models/addmember_model.dart';
import 'package:smart_chitty/widgets/features/dropdown_addmember.dart';
import 'package:smart_chitty/widgets/features/dropdown_selectmember.dart';

class MemberListProvider extends ChangeNotifier {
  List<String> memberIds = [];

  List<MemberModel> memberDatas = [];
   List<MemberModel> memberDatasdrop = [];

  Future<void> fetchMemberDatas() async {
    final box = await Hive.openBox<MemberModel>('members');
    final memberData = box.values.toList();
    memberDatasdrop=memberData;
   notifyListeners();
    
  }


  Future<void> fetchMemberData(context) async {
    final box = await Hive.openBox<MemberModel>('members');
    final memberData = box.values.toList();
    if(selectedMember==null){
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid input. Please check the values.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
        
      );

    }else{
    final selectedMemberData = memberData.firstWhere(
      (member) =>
          member.memberId == selectedMember
    );
    memberDatas = [selectedMemberData];
   notifyListeners();
    
    }
  }

  Future<void> getMemberIds() async {
    final box = await Hive.openBox<MemberModel>('members');
    final memberData = box.values.toList();

    memberIds = memberData.map((member) => member.memberId).toList();

    if (dropdownValue != null) {
      memberDatas = memberData
          .where((member) => member.memberId == selectedMember)
          .toList();
    } else {
      memberDatas = [];
    }
     
  }
}
