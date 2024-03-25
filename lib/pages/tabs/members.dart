import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smart_chitty/services/db%20functions/memberdata_fuction.dart';
import 'package:smart_chitty/services/models/addmember_model.dart';
import 'package:smart_chitty/pages/others/memberscreen_features/addmembers.dart';
import 'package:smart_chitty/pages/others/memberscreen_features/member_details.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/appbar.dart';
import 'package:smart_chitty/widgets/features/choice_chips.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';
 
class MembersScreen extends StatefulWidget {
  const MembersScreen({
    super.key,
  });

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  void handleChipSelection(String? newSelectedId) {
    setState(() {
      selectedId = newSelectedId;
    });
  }
  @override
  void initState() {
    super.initState();
    getSchemeIds();
  }

  @override
  Widget build(BuildContext context) {
    getMemberCredentials(selectedId);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: customAppBar(title: 'Members', onpresed: (value) {}),
      body: ValueListenableBuilder(
          valueListenable: memberDataListNotifer,
          builder: (BuildContext context, List<MemberModel> memberdata,
              Widget? child) {
            final filteredMembers = memberdata
                .where((member) => member.schemeId == selectedId)
                .toList();
                
            return Column(
              children: <Widget>[
                gap(height: 5),
                MemberFillter(onChipSelected: handleChipSelection),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BoldText(
                              text: 'Members',
                              size: 18,
                              color: AppColor.fontColor),
                          BoldText(
                              text: '${filteredMembers.length}',
                              size: 18,
                              color: AppColor.fontColor)
                        ],
                      ),
                    ),
                  ),
                ),
                gap(height: 12),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredMembers.length,
                    itemBuilder: (context, index) {
                      if (filteredMembers.isEmpty) {
                        return const Text('No data available');
                      }

                      final data = filteredMembers[index];
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 6, right: 6, bottom: 4),
                        child: Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: IntrinsicHeight(
                              child: ListTile(
                                onTap: () {                             
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        transitionDuration:
                                            const Duration(milliseconds: 400),
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                             MemberDetails(
                                               pool: data.schemeModel.poolAmount,
                                              address: data.memberAddress,
                                              avatar: data.avatar,
                                              contact: data.contactNumber,
                                              idBack: data.idBack,
                                              idFront: data.idFront ,
                                              installment: data.schemeModel.installment,
                                              memberId: data.memberId,
                                              memberName: data.memberName,
                                              memberage: data.memberAge ,
                                              scheme: data.schemeId!,

                                             ),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          final tween = Tween<Offset>(
                                              begin: const Offset(1.0, 0.0),
                                              end: Offset.zero);
                                          return SlideTransition(
                                            position: animation.drive(tween),
                                            child: child,
                                          );
                                        },
                                      ));
                                },
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(File(data.avatar)),
                                  radius: 25,
                                  backgroundColor: Colors.blue,
                                ),
                                title: ModifiedText(
                                  text: data.memberName,
                                  size: 18,
                                  color: AppColor.fontColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                subtitle: ModifiedText(
                                  text: 'Member Id : ${data.memberId}',
                                  size: 14,
                                  color: AppColor.fontColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    gap(height: 2),
                                    ModifiedText(
                                      text: '₹${data.schemeModel.poolAmount}',
                                      size: 18,
                                      color: AppColor.fontColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    gap(
                                        height:
                                            4), // Add some spacing between text widgets (optional)
                                    ModifiedText(
                                        text: 'Installment : 32/${data.schemeModel.installment}',
                                        size: 12,
                                        color: AppColor.fontColor)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddMemberScreen()));
        },
        child: const Icon(
          Icons.add,
          weight: 800,
          color: Colors.white,
        ),
      ),
    );
  }
}
