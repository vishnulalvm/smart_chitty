import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_chitty/services/models/addmember_model.dart';

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
        // width: 180,
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
        ),

        hintText: 'Select Schemem',
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
        onSelected: (String? value) {
          setState(() {
            selectedMember = value;
          });
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
}
