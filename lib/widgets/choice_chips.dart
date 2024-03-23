import 'package:flutter/material.dart';
import 'package:smart_chitty/db%20functions/memberdata_fuction.dart';
import 'package:smart_chitty/models/scheme_model.dart';
import 'package:smart_chitty/utils/colors.dart';

int? selectedSchemeId;
String? selectedId;

class MemberFillter extends StatefulWidget {
  
  final Function(String?) onChipSelected;
  const MemberFillter({super.key, required this.onChipSelected});

  @override
  State<MemberFillter> createState() => _MemberFillterState();
}

class _MemberFillterState extends State<MemberFillter> {
  String? selectedIdon;

  @override
  void initState() {
    super.initState();
    getSchemeIds();

  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: schemeChipListner,
      builder: (BuildContext context, List<SchemeModel> schemeModels,
          Widget? child) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildChoiceChips(schemeModels),
          ),
        );
      },
    );
  }

  List<Widget> _buildChoiceChips(List<SchemeModel> schemeModels) {
    return schemeModels.map((schemeModel) {
      int? schemeIdInt = int.tryParse(schemeModel.schemeId);
      return Padding(
        padding: const EdgeInsets.only(left: 12),
        child: ChoiceChip(
            selectedColor: Colors.blue,
            showCheckmark: false,
            labelStyle: TextStyle(
              color: selectedSchemeId == schemeIdInt
                  ? Colors.white
                  : AppColor.fontColor,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            label: Text('Scheme: ${schemeModel.schemeId}'),
            selected: selectedSchemeId == schemeIdInt,
            onSelected: (bool selected) {
              if (mounted) {
                setState(() {
                  selectedSchemeId = selected ? schemeIdInt : firstSchemeId;
                  selectedId = schemeIdInt.toString().padLeft(4, '0');
                  widget.onChipSelected(selectedId);
                });
              }
            }),
      );
    }).toList();
  }
}
