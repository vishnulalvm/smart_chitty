import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:smart_chitty/pages/others/memberscreen_features/member_details.dart';
import 'package:smart_chitty/services/db%20functions/memberdata_fuction.dart';
import 'package:smart_chitty/services/db%20functions/schemedata_function.dart';
import 'package:smart_chitty/services/db%20functions/transctiondata_function.dart';
import 'package:smart_chitty/services/models/scheme_model.dart';
import 'package:smart_chitty/pages/tabs/profile.dart';
import 'package:smart_chitty/pages/tabs/members.dart';
import 'package:smart_chitty/pages/tabs/scheme.dart';
import 'package:smart_chitty/pages/others/homescreen_features/payment_update_button.dart';
import 'package:smart_chitty/services/providers/memberid_provider.dart';
import 'package:smart_chitty/services/providers/schemeid_provider.dart';
import 'package:smart_chitty/services/providers/transaction.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/images.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/features/choice_chips.dart';
import 'package:smart_chitty/widgets/global/icon_button.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';
import 'package:text_scroll/text_scroll.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    if (schemeListNotifer.value.isNotEmpty) {
      selectedId = schemeListNotifer.value.first.schemeId;
      getMemberCredentials(selectedId);
    } else {
      selectedId = '';
    }
    final schemeIdModel =
        Provider.of<SchemeIdListProvider>(context, listen: false);
    schemeIdModel.getSchemeIds();

    final memberModel = Provider.of<MemberListProvider>(context, listen: false);
    memberModel.getMemberIds();
    memberModel.fetchMemberDatas();

    final paymentHistory =
        Provider.of<TransactionHistoryProvider>(context, listen: false);
    paymentHistory.fetchMemberDatas();
    fetchMemberDatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfileScreen()));
              },
              child: CircleAvatar(
                backgroundImage: AssetImage(appLogo),
                radius: 22,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 500,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    backgroundImage,
                  ),
                  fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 190,
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Updates:',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                        TextScroll(
                          fadeBorderSide: FadeBorderSide.both,
                          'New Chitty Scheme is start on \'january\' ,Start saving Money!!  ',
                          mode: TextScrollMode.endless,
                          velocity: Velocity(pixelsPerSecond: Offset(70, 0)),
                          delayBefore: Duration(milliseconds: 100),
                          numberOfReps: 100,
                          pauseBetween: Duration(seconds: 1),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.right,
                          selectable: true,
                        ),
                      ],
                    ),
                  )),
                ),
                Positioned(
                  top: 240,
                  left: 25,
                  right: 25,
                  bottom: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircularIconhome(
                        icontype: Symbols.finance,
                        buttonpress: () {
                          fetchMemberDatas();
                          context.go('/statistics');
                        },
                        iconname: 'Statistics',
                      ),
                      CircularIconhome(
                        icontype: Symbols.keyboard_command_key,
                        buttonpress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const SchemeButtonHome()));
                        },
                        iconname: 'Scheme',
                      ),
                      CircularIconhome(
                        icontype: Symbols.group,
                        buttonpress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const MembersScreen()));
                        },
                        iconname: 'Members',
                      ),
                      CircularIconhome(
                        icontype: Symbols.alarm,
                        buttonpress: () {},
                        iconname: 'Reminder',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          DraggableScrollableSheet(
            snapAnimationDuration: Durations.extralong2,
            initialChildSize: 0.63,
            minChildSize: 0.63,
            maxChildSize: 0.88,
            builder: (context, scrollControllers) => Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(199, 245, 245, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 20),
                  child: ListView(
                    // physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    controller: scrollControllers,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Notification',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(29, 27, 32, 1)),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'See All',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(29, 27, 32, 1)),
                              )),
                        ],
                      ),
                      gap(height: 10),
                      Container(
                        width: double.maxFinite,
                        height: 50,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(28, 167, 190, 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.alarm,
                                color: Colors.white,
                              ),
                              gap(width: 10),
                              const ModifiedText(
                                text: 'Next Meet @ 10.00 12-02-24',
                                size: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              gap(width: 80),
                              const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      gap(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Transaction ',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(29, 27, 32, 1)),
                          ),
                          TextButton(
                              onPressed: () {
                                context.go('/transaction');
                              },
                              child: const Text(
                                'See All',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(29, 27, 32, 1)),
                              )),
                        ],
                      ),
                      gap(height: 10),
                      Consumer<TransactionHistoryProvider>(
                        builder: (context, paymentData, child) {
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            controller: scrollController,
                            itemCount: paymentData.lastFourTransaction.length,
                            itemBuilder: (BuildContext context, int index) {
                              final payment =
                                  paymentData.lastFourTransaction[index];
                              String formattedDateTime =
                                  DateFormat('dd-MM-yyyy HH:mm')
                                      .format(payment.paymentDate!);
                              installmentcount = payment.installmentCount;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Card(
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 25,
                                        backgroundImage:
                                            FileImage(File(payment.imagePath)),
                                        backgroundColor: Colors.blue,
                                      ),
                                      title: ModifiedText(
                                        text: formattedDateTime,
                                        size: 18,
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      subtitle: ModifiedText(
                                        text:
                                            'Installment: ${payment.installmentCount}', // Replace with the actual member ID field from PaymentModel
                                        size: 14,
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          gap(height: 2),
                                          ModifiedText(
                                            text:
                                                '₹ ${payment.payment}', // Replace with the actual amount field from PaymentModel
                                            size: 18,
                                            color: AppColor.fontColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          gap(height: 4),
                                          ModifiedText(
                                            text:
                                                'scheme : ${payment.schemeId}', // Replace with the actual payment mode field from PaymentModel
                                            size: 12,
                                            color: AppColor.fontColor,
                                          ),
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
                      gap(height: 10),
                      ModifiedText(
                        text: 'New Schemes',
                        size: 16,
                        color: AppColor.fontColor,
                        fontWeight: FontWeight.w500,
                      ),
                      gap(height: 20),
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            gap(width: 12),
                            Container(
                              height: 100,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            gap(width: 12),
                            Container(
                              height: 100,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            gap(width: 12),
                            Container(
                              height: 100,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            gap(width: 12),
                            Container(
                              height: 100,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )
                          ],
                        ),
                      ),
                      gap(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'New Members',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(29, 27, 32, 1)),
                          ),
                          TextButton(
                              onPressed: () {
                                context.go('/members');
                              },
                              child: const Text(
                                'See All',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(29, 27, 32, 1)),
                              )),
                        ],
                      ),
                      ValueListenableBuilder(
                          valueListenable: schemeListNotifer,
                          builder: (BuildContext context,
                              List<SchemeModel> schemedata, Widget? child) {
                            return SizedBox(
                              height: 300,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                controller: scrollController,
                                itemCount: schemedata.length,
                                itemBuilder: (context, index) {
                                  final data = schemedata[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Card(
                                      elevation: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            radius: 20,
                                            child: Text(
                                              data.installment,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          title: Text(
                                              '${data.installment}×${data.subscription}'),
                                          subtitle: Text(
                                              'Subcribers :${data.totalMembers}'),
                                          trailing: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                  'Subcribers :${data.totalMembers}'),
                                              const SizedBox(
                                                  height:
                                                      15), // Add some spacing between text widgets (optional)
                                              const Text('item.trailingText2'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                    ],
                  ),
                )
                //
                ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: const Text(
            'Update Payment',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
            weight: 800,
          ),
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Adjust radius as needed
          ),
          onPressed: () {
            final memberModel =
        Provider.of<MemberListProvider>(context, listen: false);
    memberModel.getMemberIds();
    memberModel.fetchMemberDatas();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const PaymentUpdateButton()));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
