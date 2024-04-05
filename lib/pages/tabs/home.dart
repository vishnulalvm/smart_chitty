import 'dart:io';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chitty/pages/others/memberscreen_features/member_details.dart';
import 'package:smart_chitty/pages/others/other_screens/view_transaction.dart';
import 'package:smart_chitty/pages/tabs/reminders.dart';
import 'package:smart_chitty/services/db%20functions/registration_function.dart';
import 'package:smart_chitty/services/db%20functions/schemedata_function.dart';
import 'package:smart_chitty/services/db%20functions/transctiondata_function.dart';
import 'package:smart_chitty/pages/tabs/profile.dart';
import 'package:smart_chitty/pages/tabs/members.dart';
import 'package:smart_chitty/pages/tabs/scheme.dart';
import 'package:smart_chitty/pages/others/homescreen_features/payment_update_button.dart';
import 'package:smart_chitty/services/providers/filter_member_provider.dart';
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
import 'package:auto_size_text/auto_size_text.dart';

String companyLogo = '';
String companyName = '';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BuildContext? _context;
  var newupdates = '';
  ScrollController scrollController = ScrollController();
  final newupdateController = TextEditingController();
  @override
  void initState() {
    _context = context;
    getNewUpdate();
    super.initState();
    if (schemeListNotifer.value.isNotEmpty) {
      selectedId = schemeListNotifer.value.first.schemeId;
      final memberModel =
          Provider.of<FilterMemberProvider>(_context!, listen: false);
      memberModel.getMemberCredentials(null);
    } else {
      selectedId = '';
    }
    final reminderModel =
        Provider.of<ReminderListProvider>(_context!, listen: false);
    reminderModel.getReminders();
    final schemeIdModel =
        Provider.of<SchemeIdListProvider>(_context!, listen: false);
    schemeIdModel.getSchemeIds();

    final schemeSlider =
        Provider.of<SchemeListProvider>(_context!, listen: false);
    schemeSlider.getSchemeCredentials();

    final memberModel =
        Provider.of<MemberListProvider>(_context!, listen: false);
    memberModel.getMemberIds();
    memberModel.fetchMemberDatas();

    final paymentHistory =
        Provider.of<TransactionHistoryProvider>(_context!, listen: false);
    paymentHistory.fetchMemberDatas();
    fetchMemberDatas();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (final company in companyDatas) {
      companyLogo = company.imagePath;
      companyName =company.companyName;
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
            child: OpenContainer(
              transitionDuration: Durations.long2,
              transitionType: ContainerTransitionType
                  .fade, // Adjust the transition type as needed
              openBuilder: (BuildContext context, VoidCallback _) {
                return const ProfileScreen();
              },
              closedElevation: 6.0,
              closedShape: const CircleBorder(),
              closedColor: Colors.transparent,
              closedBuilder:
                  (BuildContext context, VoidCallback openContainer) {
                return InkWell(
                  onTap: openContainer,
                  child: CircleAvatar(
                    backgroundImage: FileImage(File(companyLogo)),
                    radius: 22,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    backgroundImage,
                  ),
                  fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Center(
                      child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 30, left: 12, right: 12),
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Updates:',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700),
                          ),
                          InkWell(
                            onDoubleTap: () => showLogoutDialog(context),
                            child: TextScroll(
                              fadeBorderSide: FadeBorderSide.both,
                              newupdates.toString(),
                              mode: TextScrollMode.endless,
                              velocity: const Velocity(
                                  pixelsPerSecond: Offset(70, 0)),
                              delayBefore: const Duration(milliseconds: 100),
                              numberOfReps: 100,
                              pauseBetween: const Duration(seconds: 1),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.right,
                              selectable: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 40,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Wrap(
                      spacing: MediaQuery.of(context).size.width * 0.08,
                      runSpacing: MediaQuery.of(context).size.width * 0.08,
                      alignment: WrapAlignment.center,
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
                          iconname: 'New Chits',
                        ),
                        CircularIconhome(
                          icontype: Symbols.group,
                          buttonpress: () {
                            final memberModel =
                                Provider.of<FilterMemberProvider>(context,
                                    listen: false);
                            memberModel.getMemberCredentials(null);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const MembersScreen()));
                          },
                          iconname: 'Members',
                        ),
                        CircularIconhome(
                          icontype: Symbols.note_stack_add_rounded,
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
                    physics: const ScrollPhysics(),
                    padding: EdgeInsets.zero,
                    controller: scrollControllers,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Reminder Notes',
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
// !Notification start here...
                      Consumer<ReminderListProvider>(
                          builder: (context, reminderdata, child) {
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            controller: scrollControllers,
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
                                  DateFormat('dd-MMM-yy h:mm a')
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
                                        size: 16,
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      subtitle: ModifiedText(
                                        text:
                                            'Installment: ${payment.installmentCount}', // Replace with the actual member ID field from PaymentModel
                                        size: 12,
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
                        height: MediaQuery.of(context).size.height * 0.16,
                        child: Consumer<SchemeListProvider>(
                            builder: (context, schemeData, child) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 15, top: 12, bottom: 12),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                controller: scrollControllers,
                                itemCount: schemeData.latestSchemes.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final scheme =
                                      schemeData.latestSchemes[index];

                                  return Padding(
                                      padding: const EdgeInsets.only(
                                        left: 12,
                                      ),
                                      child: SizedBox(
                                          child: FrostedGlassBox(
                                        theChild: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AutoSizeText(
                                              '${scheme.poolAmount} Chitty Started',
                                              maxLines: 1,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            AutoSizeText(
                                              'Monthly ${scheme.subscription}Only!!',
                                              maxLines: 1,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            AutoSizeText(
                                              'Propose Date on \n ${scheme.proposeDate != null ? DateFormat('dd-MM-yyyy').format(scheme.proposeDate!) : ''}',
                                              maxLines: 2,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        theHeight: 120,
                                        theWidth: 200,
                                      )));
                                }),
                          );
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
                                final memberModel =
                                    Provider.of<FilterMemberProvider>(context,
                                        listen: false);
                                memberModel.getMemberCredentials(null);
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
// ! New members Start here
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
                      gap(height: 100)
                    ],
                  ),
                )
                //
                ),
          ),
        ],
      ),
      floatingActionButton: OpenContainer(
        transitionDuration: Durations.long2,
        transitionType: ContainerTransitionType
            .fadeThrough, // Adjust the transition type as needed
        openBuilder: (BuildContext context, VoidCallback _) {
          return const PaymentUpdateButton();
        },
        closedElevation: 6.0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        closedColor: Colors.blue,
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return FloatingActionButton.extended(
            label: const Text(
              'Update Payment',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              weight: 800,
            ),
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: () {
              final memberModel =
                  Provider.of<MemberListProvider>(context, listen: false);
              memberModel.getMemberIds();
              memberModel.fetchMemberDatas();
              openContainer();
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Update'),
          content: SizedBox(
            width: 100,
            child: TextFormField(
              maxLines: 2,
              controller: newupdateController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Add new update',
                hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
                filled: true,
                fillColor: Colors.white, // Background color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // Rounded border
                  borderSide: BorderSide.none, // No border side
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // Rounded border
                  borderSide:
                      const BorderSide(color: Colors.blue), // Border color
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                String update = newupdateController.text;
                saveNewUpdate(update);
                getNewUpdate();
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> saveNewUpdate(String update) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('newUpdate', update);
  }

  Future<void> getNewUpdate() async {
    final prefs = await SharedPreferences.getInstance();
    final updates = prefs.getString('newUpdate') ?? 'No New Update';
    setState(() {
      newupdates = updates;
    });
  }
}
