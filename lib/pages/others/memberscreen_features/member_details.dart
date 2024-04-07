import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_chitty/pages/others/memberscreen_features/call_chitty.dart';
import 'package:smart_chitty/pages/others/memberscreen_features/edit_member.dart';
import 'package:smart_chitty/pages/others/other_screens/view_id_screen.dart';
import 'package:smart_chitty/pages/tabs/members.dart';
import 'package:smart_chitty/services/db%20functions/payment_function.dart';
import 'package:smart_chitty/services/models/addmember_model.dart';
import 'package:smart_chitty/services/models/payment_details_model.dart';
import 'package:smart_chitty/services/providers/filter_member_provider.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/images.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/row_text.dart';
import 'package:smart_chitty/widgets/global/scroll_to_hide.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';

int? installmentcount;

class MemberDetails extends StatefulWidget {
  final String memberName;
  final String scheme;
  final String installment;
  final String memberId;
  final String memberage;
  final String contact;
  final String address;
  final String avatar;
  final String idFront;
  final String idBack;
  final String pool;

  const MemberDetails(
      {super.key,
      required this.memberName,
      required this.scheme,
      required this.installment,
      required this.memberId,
      required this.memberage,
      required this.contact,
      required this.address,
      required this.avatar,
      required this.idFront,
      required this.idBack,
      required this.pool});

  @override
  State<MemberDetails> createState() => _MemberDetailsState();
}

class _MemberDetailsState extends State<MemberDetails> {
  BuildContext? _context;
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _context = context;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            centerTitle: false,
            backgroundColor: const Color.fromRGBO(1, 82, 136, 1),
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: ModifiedText(
                  text: widget.memberName, size: 20, color: Colors.white),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    backgroundImage,
                    fit: BoxFit.cover,
                  ),
                  // Center Circle Avatar
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => ViewIdScreen(
                                  path: widget.avatar,
                                )));
                      },
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: FileImage(
                          File(
                            widget.avatar,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              PopupMenuButton<int>(
                onSelected: (value) {
                  if (value == 1) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => EditMemberScreen(
                              address: widget.address,
                              avatar: widget.avatar,
                              contact: widget.contact,
                              idBack: widget.idBack,
                              idFront: widget.idFront,
                              installment: widget.installment,
                              memberId: widget.memberId,
                              memberName: widget.memberName,
                              memberage: widget.memberage,
                              pool: widget.pool,
                              scheme: widget.scheme,
                            )));
                  } else {
                    showLogoutDialog();
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text('Edit'),
                  ),
                  const PopupMenuItem<int>(
                    value: 2,
                    child: Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Column(
                children: [
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
                  gap(height: 12),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    // padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        rowText(
                            firstText: 'Scheme :',
                            secoundText: widget.memberId),
                        rowText(
                            firstText: 'Pool Amount :',
                            secoundText: widget.pool),
                        rowText(
                            firstText: 'Total Installment :',
                            secoundText:
                                '$installmentcount/${widget.installment}'),
                        rowText(
                            firstText: 'Member id :',
                            secoundText: widget.memberId),
                      ],
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
                        color: Colors.white,
                      ),
                      child: Center(
                        child: BoldText(
                          text: 'Member Details',
                          size: 20,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ),
                  ),
                  gap(height: 12),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 430,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    // padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        rowText(
                            firstText: 'Name :',
                            secoundText: widget.memberName),
                        rowText(
                            firstText: 'Age :', secoundText: widget.memberage),
                        rowText(
                            firstText: 'Contact Number :',
                            secoundText: widget.contact),
                        rowText(
                            firstText: 'Address :',
                            secoundText: widget.address),
                        rowText(firstText: 'Id Proof :', secoundText: ''),
                        gap(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                ModifiedText(
                                    text: 'Front Side',
                                    size: 16,
                                    color: AppColor.fontColor),
                                gap(height: 10),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (ctx) => ViewIdScreen(
                                                  path: widget.idFront,
                                                )));
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              FileImage(File(widget.idFront)),
                                          fit: BoxFit.cover),
                                      color: AppColor.primaryColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            gap(width: 50),
                            Column(
                              children: [
                                ModifiedText(
                                    text: 'Back Side',
                                    size: 16,
                                    color: AppColor.fontColor),
                                gap(height: 12),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (ctx) => ViewIdScreen(
                                                  path: widget.idBack,
                                                )));
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(File(widget.idBack)),
                                          fit: BoxFit.cover),
                                      color: AppColor.primaryColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
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
                        color: Colors.white,
                      ),
                      child: Center(
                        child: BoldText(
                          text: 'Transations',
                          size: 20,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ),
                  ),
                  gap(height: 12),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ValueListenableBuilder(
              valueListenable: allPaymentData,
              builder: (BuildContext context, List<PaymentModel> paymentData,
                  Widget? child) {
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 100),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: paymentData.length,
                  itemBuilder: (BuildContext context, int index) {
                    final payment = paymentData[index];
                    String formattedDateTime = DateFormat('dd-MMM-yy h:mm a')
                        .format(payment.paymentDate!);
                    installmentcount = payment.installmentCount;
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 6, right: 6, bottom: 4),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
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
          ),
        ],
      ),
      floatingActionButton: ScrollToHide(
        
        height: 60,
        hideDirection: Axis.vertical,
        scrollController: scrollController,

        child: FloatingActionButton.extended(
            label: const Text(
              '   Call Chitty   ',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(30), // Adjust radius as needed
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => CallChitty(
                        memberId: widget.scheme,
                        schemeId: widget.memberId,
                      )));
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
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
                final box = await Hive.openBox<MemberModel>('members');
                box.delete(widget.memberId);
                final memberModel =
                    Provider.of<FilterMemberProvider>(_context!, listen: false);
                memberModel.getMemberCredentials(null);
                Navigator.of(_context!).push(
                    MaterialPageRoute(builder: (ctx) => const MembersScreen()));
              },
              child: const Text('delete'),
            ),
          ],
        );
      },
    );
  }
}
