import 'package:flutter/material.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/appbar.dart';
import 'package:smart_chitty/widgets/row_text.dart';
import 'package:smart_chitty/widgets/widget_gap.dart';
import 'package:intl/intl.dart';

class SchemeDetails extends StatelessWidget {
  final String chittyPattern;
  final String chittySubcription;
  final String chittyIstallment;
  final String chittyMembers;
  final String commission;
  final DateTime? dateTime;
  final String schemeId;
  final int pool;

  const SchemeDetails(
      {super.key,
      required this.chittyPattern,
      required this.chittySubcription,
      required this.chittyIstallment,
      required this.chittyMembers,
      required this.commission,
      this.dateTime,
      required this.schemeId,
      required this.pool});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: customAppBar(
        title: 'Scheme : $chittyPattern',
        onpresed: () {},
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Center(
                  child: BoldText(
                      text: 'Scheme Details',
                      size: 20,
                      color: AppColor.fontColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
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
                        secoundText: chittyPattern),
                    rowText(firstText: 'Chitty ID :', secoundText: schemeId),
                    rowText(
                      firstText: 'Proposed Start Date :',
                      secoundText: dateTime != null
                          ? DateFormat('dd-MM-yyyy').format(dateTime!)
                          : '',
                    ),
                    rowText(
                        firstText: 'Subscription Amount :',
                        secoundText: chittySubcription),
                    rowText(
                        firstText: 'No.Of. Installment :',
                        secoundText: chittyIstallment),
                    rowText(
                        firstText: 'Commission :', secoundText: '$commission%'),
                    rowText(
                        firstText: 'Total Members :',
                        secoundText: chittyMembers),
                    rowText(
                        firstText: 'Pool Amount :', secoundText: pool.toString()),
                  ],
                ),
              ),
            ),
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
                          text: 'Members', size: 18, color: AppColor.fontColor),
                      BoldText(
                          text: '32/40', size: 18, color: AppColor.fontColor)
                    ],
                  ),
                ),
              ),
            ),
            gap(height: 12),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 18,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(left: 6, right: 6, bottom: 4),
                    child: Card(
                      color: Colors.white,
                      elevation: 0,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            // backgroundImage: AssetImage(item.imagePath), // Use your image path
                          ),
                          title: Text("item.title"),
                          subtitle: Text('item.subtitle'),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('item.trailingText1'),
                              SizedBox(
                                  height:
                                      15), // Add some spacing between text widgets (optional)
                              Text('item.trailingText2'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
