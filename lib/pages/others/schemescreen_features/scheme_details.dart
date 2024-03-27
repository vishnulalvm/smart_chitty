import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smart_chitty/services/db%20functions/memberdata_fuction.dart';
import 'package:smart_chitty/services/models/addmember_model.dart';
import 'package:smart_chitty/pages/others/memberscreen_features/member_details.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/appbar.dart';
import 'package:smart_chitty/widgets/global/row_text.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';
import 'package:intl/intl.dart';

class SchemeDetails extends StatefulWidget {
  final String chittyPattern;
  final String chittySubcription;
  final String chittyIstallment;
  final String chittyMembers;
  final String commission;
  final DateTime? dateTime;
  final String schemeId;
  final String pool;

  const SchemeDetails(
      {super.key,
      required this.chittyPattern,
      required this.chittySubcription,
      required this.chittyIstallment,
      required this.chittyMembers,
      required this.commission,
      required this.dateTime,
      required this.schemeId,
      required this.pool});

  @override
  State<SchemeDetails> createState() => _SchemeDetailsState();
}

class _SchemeDetailsState extends State<SchemeDetails> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    getMemberCredentials(widget.schemeId);
    return Scaffold(
        backgroundColor: AppColor.primaryColor,
        appBar: customAppBar(
            title: 'Scheme : ${widget.chittyPattern}',
            onpresed: (value) {
              if (value == 1) {
              } else if (value == 2) {
                showLogoutDialog();
              }
            },
            item1: 'Edit',
            item2: 'Delete'),
        body: ValueListenableBuilder(
            valueListenable: memberDataListNotifer,
            builder: (BuildContext context, List<MemberModel> memberdata,
                Widget? child) {
              final filteredMembers = memberdata
                  .where((member) => member.schemeId == widget.schemeId)
                  .toList();
              return ListView(
                physics: const BouncingScrollPhysics(),
                controller: scrollController,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 12),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: BoldText(
                          text: 'Scheme Details',
                          size: 20,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 12),
                    child: Container(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Column(
                        children: [
                          rowText(
                              firstText: 'Chitty pattern :',
                              secoundText: widget.chittyPattern),
                          rowText(
                              firstText: 'Chitty ID :',
                              secoundText: widget.schemeId),
                          rowText(
                            firstText: 'Proposed Start Date :',
                            secoundText: widget.dateTime != null
                                ? DateFormat('dd-MM-yyyy')
                                    .format(widget.dateTime!)
                                : '',
                          ),
                          rowText(
                              firstText: 'Subscription Amount :',
                              secoundText: widget.chittySubcription),
                          rowText(
                              firstText: 'No.Of. Installment :',
                              secoundText: widget.chittyIstallment),
                          rowText(
                              firstText: 'Commission :',
                              secoundText: '${widget.commission}%'),
                          rowText(
                              firstText: 'Total Members :',
                              secoundText: widget.chittyMembers),
                          rowText(
                              firstText: 'Pool Amount :',
                              secoundText: widget.pool),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 12),
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
                                text:
                                    '${filteredMembers.length}/${widget.chittyMembers}',
                                size: 18,
                                color: AppColor.fontColor)
                          ],
                        ),
                      ),
                    ),
                  ),
                  gap(height: 12),
                  SizedBox(
                    height: 800,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      controller: scrollController,
                      itemCount: filteredMembers.length,
                      itemBuilder: (context, index) {
                        if (filteredMembers.isEmpty) {
                          return const Text('No data available');
                        }

                        final data = filteredMembers[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 6, right: 6, bottom: 4),
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
                                            idFront: data.idFront,
                                            installment:
                                                widget.chittyIstallment,
                                            memberId: data.memberId,
                                            memberName: data.memberName,
                                            memberage: data.memberAge,
                                            scheme: widget.schemeId,
                                          ),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
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
                                    backgroundImage:
                                        FileImage(File(data.avatar)),
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
                                          text: 'scheme Id : ${data.schemeId}',
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
            }));
  }

  void showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Are you sure you want to delete?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Text('delete'),
            ),
          ],
        );
      },
    );
  }
}
