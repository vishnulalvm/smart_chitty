import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chitty/pages/others/memberscreen_features/addmembers.dart';
import 'package:smart_chitty/widgets/features/search_feature.dart';
import 'package:smart_chitty/services/db%20functions/payment_function.dart';
import 'package:smart_chitty/pages/others/memberscreen_features/member_details.dart';
import 'package:smart_chitty/services/providers/filter_member_provider.dart';
import 'package:smart_chitty/services/providers/memberdata_provider.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/appbar.dart';
import 'package:smart_chitty/widgets/features/choice_chips.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';

String installment = '';
String memberId = '';

class MembersScreen extends StatefulWidget {
  const MembersScreen({
    super.key,
  });

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  ScrollController scrollController = ScrollController();
  void handleChipSelection(String? newSelectedId) {
    setState(() {
      selectedId = newSelectedId;
    });
  }

  @override
  void initState() {
    super.initState();
    final schemeIdModel =
        Provider.of<MemberDataProvider>(context, listen: false);
    schemeIdModel.getSchemeIds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: customAppBar(title: 'Members', onpresed: (value) {}),
      body:
          Consumer<FilterMemberProvider>(builder: (context, memberdata, child) {
        // if (memberdata.memberDataListNotifer.isEmpty) {
        //   return const Text('No data available');
        // }
        return Column(
          children: [
            gap(height: 5),
            MemberFillter(onChipSelected: handleChipSelection),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                        cursorWidth: 0,
                        cursorHeight: 0,
                          onTap: () async {
                            await showSearch(
                              context: context,
                              delegate: CustomSearchDelegate(
                                  memberdata.memberDataListNotifer),
                            );
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                size: 20,
                              ),
                              border: InputBorder.none,
                              hintText: 'Search Members',
      
                              hintStyle: TextStyle()),
                        ),
                      ),
                      Text(
                        'Total: ${memberdata.memberDataListNotifer.length.toString()}',
                        style: TextStyle(
                          color: AppColor.fontColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            gap(height: 12),
            Expanded(
              child:
                  ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: memberdata.memberDataListNotifer.length,
                itemBuilder: (context, index) {
                  final data = memberdata.memberDataListNotifer[index];
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
                              getPaymentCredentials(data.memberId);
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
                                    installment: data.schemeModel.installment,
                                    memberId: data.memberId,
                                    memberName: data.memberName,
                                    memberage: data.memberAge,
                                    scheme: data.schemeId ?? '',
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
                                ),
                              );
                            },
                            leading: CircleAvatar(
                              backgroundImage: FileImage(File(data.avatar)),
                              radius: 25,
                              backgroundColor: Colors.blue,
                            ),
                            title: ModifiedText(
                              text: data.memberName,
                              size: 16,
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w500,
                            ),
                            subtitle: ModifiedText(
                              text: 'Member Id : ${data.memberId}',
                              size: 12,
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w500,
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                gap(height: 5),
                                ModifiedText(
                                  text: '₹${data.schemeModel.poolAmount}',
                                  size: 14,
                                  color: AppColor.fontColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                gap(
                                    height:
                                        2), // Add some spacing between text widgets (optional)
                                ModifiedText(
                                    text:
                                        'Installment : $installment/${data.schemeModel.installment}',
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
      // resizeToAvoidBottomInset: false
    );
  }

  void getInstallmentCounts() async {
    installment = getInstallmentCount(memberId).toString();
  }

  Future<int> getInstallmentCount(String memberId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('installment_$memberId') ?? 0;
  }
}
