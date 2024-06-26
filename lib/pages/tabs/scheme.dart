import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_chitty/services/db%20functions/schemedata_function.dart';
import 'package:smart_chitty/services/models/scheme_model.dart';
import 'package:smart_chitty/pages/others/schemescreen_features/scheme_details.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/appbar.dart';
import 'package:smart_chitty/pages/others/schemescreen_features/addscheme.dart';
import 'package:smart_chitty/widgets/global/scroll_to_hide.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';

class SchemeButtonHome extends StatefulWidget {
  const SchemeButtonHome({
    super.key,
  });

  @override
  State<SchemeButtonHome> createState() => _SchemeButtonHomeState();
}

class _SchemeButtonHomeState extends State<SchemeButtonHome> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: customAppBar(
          title: 'New Chits', onpresed: (value) {}, showMenu: false),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoldText(
                  text: 'Total Chits',
                  color: AppColor.fontColor,
                  size: 15,
                ),
                ValueListenableBuilder(
                    valueListenable: schemeListNotifer,
                    builder: (BuildContext context,
                        List<SchemeModel> schemedata, Widget? child) {
                      return BoldText(
                        text: schemeListNotifer.value.length.toString(),
                        color: AppColor.fontColor,
                        size: 16,
                      );
                    }),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: schemeListNotifer,
              builder: (BuildContext context, List<SchemeModel> schemedata,
                  Widget? child) {
                return ListView.builder(
                  controller: scrollController,
                  itemCount: schemeListNotifer.value.length,
                  itemBuilder: (context, index) {
                    if (schemedata.isEmpty) {
                      return const Text('No data available');
                    }
                    final data = schemedata[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 6, right: 6),
                      child: Card(
                        color: Colors.white,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 400),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        SchemeDetails(
                                      pool: data.poolAmount,
                                      schemeId: data.schemeId,
                                      dateTime: data.proposeDate,
                                      commission: data.commission,
                                      chittyIstallment: data.installment,
                                      chittyMembers: data.totalMembers,
                                      chittyPattern:
                                          '${data.subscription}×${data.totalMembers}',
                                      chittySubcription: data.subscription,
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
                              radius: 25,
                              backgroundColor: Colors.blue,
                              child: ModifiedText(
                                  text: data.totalMembers,
                                  size: 26,
                                  color: Colors.white),
                            ),
                            title: ModifiedText(
                              text:
                                  '${data.subscription} × ${data.installment} ${data.installmentType}',
                              size: 18,
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w500,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            subtitle: ModifiedText(
                              text:
                                  'Propose Date : ${data.proposeDate != null ? DateFormat('dd-MM-yyyy').format(data.proposeDate!) : ''}',
                              size: 12,
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w500,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                gap(height: 2),
                                ModifiedText(
                                  text: '₹ ${data.poolAmount}',
                                  size: 18,
                                  color: AppColor.fontColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                gap(
                                    height:
                                        4), // Add some spacing between text widgets (optional)
                                ModifiedText(
                                    text: 'Commission : ${data.commission}%',
                                    size: 12,
                                    color: AppColor.fontColor)
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: ScrollToHide(
        height: 60,
        hideDirection: Axis.vertical,
        scrollController: scrollController,
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          shape: const CircleBorder(),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) =>
                    const AddSchemeBottomSheet());
          },
          child: const Icon(
            Icons.add,
            weight: 800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget fabIcon() {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      shape: const CircleBorder(),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) => const AddSchemeBottomSheet(),
        );
      },
      child: const Icon(
        Icons.add,
        weight: 800,
        color: Colors.white,
      ),
    );
  }
}
