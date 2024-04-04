import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smart_chitty/pages/others/homescreen_features/payment_update_button.dart';
import 'package:smart_chitty/pages/others/memberscreen_features/member_details.dart';
import 'package:smart_chitty/services/db%20functions/payment_function.dart';
import 'package:smart_chitty/services/models/addmember_model.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';

class CustomSearchDelegate extends SearchDelegate<MemberModel> {
  final List<MemberModel> memberList;

  CustomSearchDelegate(this.memberList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<MemberModel> searchResults = memberList
        .where((member) =>
            member.memberName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final data = searchResults[index];
        return Padding(
          padding: const EdgeInsets.only(left: 6, right: 6, bottom: 4),
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
                        transitionDuration: const Duration(milliseconds: 400),
                        pageBuilder: (context, animation, secondaryAnimation) =>
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
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          final tween = Tween<Offset>(
                              begin: const Offset(1.0, 0.0), end: Offset.zero);
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<MemberModel> searchResults = memberList
        .where((student) =>
            student.memberName.toLowerCase().contains(query.toLowerCase()))
        .toList();
    // You can provide suggestions as users type
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final data = searchResults[index];
        return Padding(
          padding: const EdgeInsets.only(left: 6, right: 6, bottom: 4),
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
                        transitionDuration: const Duration(milliseconds: 400),
                        pageBuilder: (context, animation, secondaryAnimation) =>
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
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          final tween = Tween<Offset>(
                              begin: const Offset(1.0, 0.0), end: Offset.zero);
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
    );
  }
}
