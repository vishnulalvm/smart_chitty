import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_chitty/services/models/scheme_model.dart';
import 'package:smart_chitty/services/providers/filter_member_provider.dart';
import 'package:smart_chitty/services/providers/memberdata_provider.dart';
import 'package:smart_chitty/utils/colors.dart';

String? selectedSchemeId;
String? selectedId;
String? fistvalue;

class MemberFillter extends StatefulWidget {
  final Function(String?) onChipSelected;
  const MemberFillter({super.key, required this.onChipSelected});

  @override
  State<MemberFillter> createState() => _MemberFillterState();
}

class _MemberFillterState extends State<MemberFillter> {
 final String allChipId = 'ALL';
  String? selectedIdon;

  @override
  void initState() {
    super.initState();
    selectedSchemeId = allChipId;
    final schemeIdModel =
        Provider.of<MemberDataProvider>(context, listen: false);
    schemeIdModel.getSchemeIds();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MemberDataProvider>(builder: (context, schememodel, child) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildChoiceChips(schememodel.schemeIdList),
        ),
      );
    });
  }

  List<Widget> _buildChoiceChips(List<SchemeModel> schememodels) {
    List<Widget> chips = [
    Padding(
      padding: const EdgeInsets.only(left: 12),
      child: ChoiceChip(
        selectedColor: Colors.blue,
        showCheckmark: false,
        labelStyle: TextStyle(
          color: selectedSchemeId == allChipId ? Colors.white : AppColor.fontColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        label: const Text('All'),
        selected: selectedSchemeId == allChipId,
        onSelected: (bool selected) {
          if (mounted) {
            setState(() {
              selectedSchemeId = selected ? allChipId : null;
              selectedId = null;
              widget.onChipSelected(selectedId);
              final memberModel = Provider.of<FilterMemberProvider>(context, listen: false);
              memberModel.getMemberCredentials(selectedId);
            });
          }
        },
      ),
    ),
  ];
    chips.addAll( schememodels.map((schemeModel) {
      String? schemeIdInt = schemeModel.schemeId;

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
                  selectedSchemeId = selected ? schemeIdInt : fistvalue;
                  selectedId = schemeIdInt.toString().padLeft(4, '0');
                  widget.onChipSelected(selectedId);
                  final memberModel =
                      Provider.of<FilterMemberProvider>(context, listen: false);
                  memberModel.getMemberCredentials(selectedId);
                });
              }
            }),
      );
    }).toList());
    return chips;
  }
}
