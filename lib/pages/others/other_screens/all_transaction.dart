import 'package:flutter/material.dart';
import 'package:smart_chitty/pages/others/other_screens/transaction_details.dart';
import 'package:smart_chitty/services/db%20functions/schemedata_function.dart';
import 'package:smart_chitty/services/models/scheme_model.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/appbar.dart';
import 'package:smart_chitty/pages/others/schemescreen_features/addscheme.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({
    super.key,
  });

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: customAppBar(
          title: 'Transaction',
          onpresed: (value) {},
          item1: 'Settings',
          item2: 'Info'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoldText(
                  text: 'Sort Transactions',
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
                  itemCount: schemeListNotifer.value.length,
                  itemBuilder: (context, index) {
                    if (schemedata.isEmpty) {
                      return const Text('No data available');
                    }

                    final data = schemedata[index];
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 6, right: 6, bottom: 4),
                      child: Card(
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
                                        const TransactionDetails(),
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
                                  text: data.installment,
                                  size: 26,
                                  color: Colors.white),
                            ),
                            title: ModifiedText(
                              text: '${data.subscription}×${data.totalMembers}',
                              size: 18,
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w500,
                            ),
                            subtitle: ModifiedText(
                              text: 'Subscribers : ${data.totalMembers}',
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) => const AddSchemeBottomSheet());
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
