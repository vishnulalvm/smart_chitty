import 'package:flutter/material.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/appbar.dart';
import 'package:smart_chitty/widgets/global/row_text.dart';

class AboutCompany extends StatefulWidget {
  const AboutCompany({super.key});

  @override
  State<AboutCompany> createState() => _AboutCompanyState();
}

class _AboutCompanyState extends State<AboutCompany> {
  int? openExpansionTileIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: customAppBar(title: 'About', onpresed: (vlaue) {}),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ExpansionTile(
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
                  child: Column(
                    children: [
                      rowText(
                          firstText: 'Company Name',
                          secoundText: 'secoundText'),
                      rowText(
                          firstText: 'Company Name',
                          secoundText: 'secoundText'),
                      rowText(
                          firstText: 'Company Name',
                          secoundText: 'secoundText'),
                      rowText(
                          firstText: 'Company Name',
                          secoundText: 'secoundText'),
                    ],
                  ),
                )
              ],
            ),
                 ExpansionTile(
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
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      rowText(
                          firstText: 'Company Name',
                          secoundText: 'secoundText'),
                      rowText(
                          firstText: 'Company Name',
                          secoundText: 'secoundText'),
                      rowText(
                          firstText: 'Company Name',
                          secoundText: 'secoundText'),
                      rowText(
                          firstText: 'Company Name',
                          secoundText: 'secoundText'),
                    ],
                  ),
                )
              ],
            ),
                 ExpansionTile(
              shape: const Border(),
              title: ModifiedText(
                text: 'Delete All Data',
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
                  child: Column(
                    children: [
                      rowText(
                          firstText: 'Company Name',
                          secoundText: 'secoundText'),
                      rowText(
                          firstText: 'Company Name',
                          secoundText: 'secoundText'),
                      rowText(
                          firstText: 'Company Name',
                          secoundText: 'secoundText'),
                      rowText(
                          firstText: 'Company Name',
                          secoundText: 'secoundText'),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
