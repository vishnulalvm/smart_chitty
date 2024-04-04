import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chitty/pages/others/homescreen_features/payment_update_button.dart';
import 'package:smart_chitty/services/models/addmember_model.dart';
import 'package:smart_chitty/services/providers/memberid_provider.dart';

String? selectedMember;

class DropdownSelectMember extends StatefulWidget {
  final List<MemberModel> list;
  const DropdownSelectMember({super.key, required this.list});

  @override
  State<DropdownSelectMember> createState() => DropdownSelectMemberState();
}

class DropdownSelectMemberState extends State<DropdownSelectMember> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 45,
      width: 200,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30)),
      child: DropdownMenu<String>(
        expandedInsets: EdgeInsets.zero,
        enableSearch: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
        ),
        hintText: 'Select Member',
        textStyle: const TextStyle(color: Colors.white),
        leadingIcon: selectedMember != null
            ? Padding(
                padding: const EdgeInsets.all(2.0),
                child: CircleAvatar(
                  backgroundImage: FileImage(
                    File(widget.list
                        .firstWhere(
                            (member) => member.memberId == selectedMember)
                        .avatar),
                  ),
                  backgroundColor: Colors.blue,
                ),
              )
            : const Padding(
                padding: EdgeInsets.all(2.0),
                child: CircleAvatar(),
              ),
        onSelected: (String? value) async {
          setState(() {
            selectedMember = value;
            final memberModel =
                Provider.of<MemberListProvider>(context, listen: false);
            memberModel.fetchMemberData(context);
          });
          String memberid =
              selectedMember == null ? 'selectedMember' : selectedMember!;
          installment = await getInstallmentCount(memberid);
        },
        dropdownMenuEntries:
            widget.list.map<DropdownMenuEntry<String>>((MemberModel value) {
          return DropdownMenuEntry<String>(
            value: value.memberId,
            label: value.memberId,
            leadingIcon: CircleAvatar(
              backgroundColor: Colors.blue,
              backgroundImage: FileImage(File(value.avatar)),
            ),
          );
        }).toList(),
      ),
    );
  }

  Future<int> getInstallmentCount(String memberId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('installment_$memberId') ?? 0;
  }
}
