import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:smart_chitty/pages/others/memberscreen_features/member_details.dart';
import 'package:smart_chitty/pages/others/other_screens/view_transaction.dart';
import 'package:smart_chitty/pages/tabs/reminders.dart';
import 'package:smart_chitty/services/db%20functions/memberdata_fuction.dart';
import 'package:smart_chitty/services/db%20functions/registration_function.dart';
import 'package:smart_chitty/services/db%20functions/schemedata_function.dart';
import 'package:smart_chitty/services/db%20functions/transctiondata_function.dart';
import 'package:smart_chitty/pages/tabs/profile.dart';
import 'package:smart_chitty/pages/tabs/members.dart';
import 'package:smart_chitty/pages/tabs/scheme.dart';
import 'package:smart_chitty/pages/others/homescreen_features/payment_update_button.dart';
import 'package:smart_chitty/services/providers/memberid_provider.dart';
import 'package:smart_chitty/services/providers/reminderdata_provider.dart';
import 'package:smart_chitty/services/providers/schemedata_provider.dart';
import 'package:smart_chitty/services/providers/schemeid_provider.dart';
import 'package:smart_chitty/services/providers/transaction.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/images.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/features/choice_chips.dart';
import 'package:smart_chitty/widgets/global/glasseffect.dart';
import 'package:smart_chitty/widgets/global/icon_button.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';
import 'package:text_scroll/text_scroll.dart';
String companyLogo='' ;
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
    final reminderModel =
        Provider.of<ReminderListProvider>(context, listen: false);
    reminderModel.getReminders();
    final schemeIdModel =
        Provider.of<SchemeIdListProvider>(context, listen: false);
    schemeIdModel.getSchemeIds();

    final schemeSlider =
        Provider.of<SchemeListProvider>(context, listen: false);
    schemeSlider.getSchemeCredentials();

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
     for (final company in companyDatas) {
    companyLogo =  company.imagePath;
     }
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
                backgroundImage: FileImage(File(companyLogo)),
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
                          context.push('/statistics');
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
                        buttonpress: () {
                          final reminderModel =
                              Provider.of<ReminderListProvider>(context,
                                  listen: false);
                          reminderModel.getReminders();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const ReminderScreen()));
                        },
                        iconname: 'Reminders',
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
// !Notification start here...
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
                              onPressed: () {
                                final reminderModel =
                                    Provider.of<ReminderListProvider>(context,
                                        listen: false);
                                reminderModel.getReminders();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => const ReminderScreen()));
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
                      Consumer<ReminderListProvider>(
                          builder: (context, reminderdata, child) {
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            controller: scrollController,
                            itemCount: reminderdata.lastFourReminders.length,
                            itemBuilder: (BuildContext context, int index) {
                              final reminder =
                                  reminderdata.lastFourReminders[index];
                              // isChecked =reminder.isChecked;
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 12,
                                ),
                                child: Container(
                                  width: double.maxFinite,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(28, 167, 190, 1),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(
                                          Icons.alarm,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 280,
                                          child: RichText(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(
                                              text:
                                                  '${reminder.reminderNote} @ ${reminder.reminderTime} ${reminder.reminderDate}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            reminderdata.deleteReminder(index);
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),

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
                                context.push('/transaction');
                              },
                              child: const Text(
                                'See All',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(29, 27, 32, 1)),
                              )),
                        ],
// ! transations start here..
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
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    ViewTransaction(
                                                      index: index,
                                                      treansProvider:
                                                          paymentData,
                                                      paymentModel: payment,
                                                    )));
                                      },
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
// ! New scheme start here
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/Header.jpg',
                                ),
                                fit: BoxFit.cover)),
                        height: 140,
                        child: Consumer<SchemeListProvider>(
                            builder: (context, schemeData, child) {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              controller: scrollController,
                              itemCount: schemeData.latestSchemes.length,
                              itemBuilder: (BuildContext context, int index) {
                                final scheme = schemeData.latestSchemes[index];

                                return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, top: 10, bottom: 10),
                                    child: FrostedGlassBox(
                                      theChild: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ModifiedText(
                                                text:
                                                    '${scheme.poolAmount} Chitty Started',
                                                size: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              ModifiedText(
                                                  text:
                                                      'Monthly ${scheme.subscription}Only!!',
                                                  size: 14,
                                                  color: Colors.white),
                                              ModifiedText(
                                                  text:
                                                      'Propose Date on \n ${scheme.proposeDate != null ? DateFormat('dd-MM-yyyy').format(scheme.proposeDate!) : ''}',
                                                  size: 16,
                                                  color: Colors.white),
                                            ],
                                          )),
                                      theHeight: 120,
                                      theWidth: 200,
                                    ));
                              });
                        }),
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
                                context.push('/members');
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
                      // ! New members
                      Consumer<MemberListProvider>(
                          builder: (context, membersModel, child) {
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          controller: scrollController,
                          itemCount: membersModel.lastFourmember.length,
                          itemBuilder: (context, index) {
                            final data = membersModel.lastFourmember[index];
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
                                      backgroundImage:
                                          FileImage(File(data.avatar)),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        gap(height: 2),
                                        ModifiedText(
                                          text:
                                              '₹${data.schemeModel.poolAmount}',
                                          size: 18,
                                          color: AppColor.fontColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        gap(
                                            height:
                                                4), // Add some spacing between text widgets (optional)
                                        ModifiedText(
                                            text:
                                                'Installment : 0/${data.schemeModel.installment}',
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
