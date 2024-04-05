import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:smart_chitty/pages/tabs/home.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/appbar.dart';
import 'package:smart_chitty/widgets/global/row_text.dart';
import 'package:smart_chitty/widgets/global/textfieldwidget.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';

class AboutCompany extends StatefulWidget {
  const AboutCompany({super.key});

  @override
  State<AboutCompany> createState() => _AboutCompanyState();
}

class _AboutCompanyState extends State<AboutCompany> {
  final newUserIdController = TextEditingController();
  final newPasswordController = TextEditingController();
  int? openExpansionTileIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar:
          customAppBar(title: 'About', onpresed: (vlaue) {}, showMenu: false),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: ExpansionTile(
                collapsedBackgroundColor: Colors.white,
                enableFeedback: true,
                subtitle: const ModifiedText(
                  text: 'Company Details',
                  size: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                shape: const Border(),
                title: ModifiedText(
                  text: 'About',
                  size: 16,
                  color: AppColor.fontColor,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: FileImage(File(companyLogo)),
                            radius: 25,
                          ),
                          rowText(
                              firstText: 'Company Name',
                              secoundText: companyName),
                          gap(height: 12),
                          const AutoSizeText(
                            "The word 'Chit' suggests the origin of Chit Funds. 'Chit' means a written note on a small piece of paper. The Malayalam equivalent for the word 'chitty' is 'Kuri,' which has been derived from 'Kurippu' (a piece of writing or script). The term 'Chitty' or 'Kuri' is derived from the root word 'lot.' The foreman (person who operates chitties) writes the names of each subscriber on separate pieces of paper and folds them in such a way that the name written on the paper is not visible to the assembled people there.",
                            style: TextStyle(fontSize: 16.0),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            gap(height: 12),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: ExpansionTile(
                collapsedBackgroundColor: Colors.white,
                enableFeedback: true,
                subtitle: const ModifiedText(
                  text: 'Option for forgot password',
                  size: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                shape: const Border(),
                title: ModifiedText(
                  text: 'Change Password',
                  size: 16,
                  color: AppColor.fontColor,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textField(
                              hintText: 'New User Id',
                              icons: Icons.person,
                              controller: newUserIdController,
                              validator: (name) => name!.length < 3
                                  ? 'Name should be 3 character'
                                  : null),
                          gap(height: 20),
                          textField(
                              hintText: 'New Password',
                              icons: Icons.lock,
                              controller: newUserIdController,
                              validator: (name) => name!.length < 3
                                  ? 'Name should be 3 character'
                                  : null),
                          gap(height: 10),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue),
                              child: const Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            gap(height: 12),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: ExpansionTile(
                collapsedBackgroundColor: Colors.white,
                enableFeedback: true,
                subtitle: const ModifiedText(
                  text: 'For Deleta All Data',
                  size: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                shape: const Border(),
                title: ModifiedText(
                  text: 'Delete All Datas',
                  size: 16,
                  color: AppColor.fontColor,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ModifiedText(
                                text: 'Delete All Datas :',
                                size: 16,
                                color: AppColor.fontColor,fontWeight: FontWeight.w600,),
                            ElevatedButton(
                                onPressed: () {

                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
