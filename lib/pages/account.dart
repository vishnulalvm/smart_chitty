import 'package:flutter/material.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/contact_button.dart';
import 'package:smart_chitty/widgets/listtile_account.dart';
import 'package:smart_chitty/widgets/widget_gap.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Smart Chitty'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/smart kuri.jpeg'),
              radius: 22,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 500,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/background home.jpeg',
                  ),
                  fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                // Positioned(
                //   left: 22,
                //   top: 108,
                //   child: CircleAvatar(
                //     backgroundImage:
                //         AssetImage('assets/images/smart kuri.jpeg'),
                //     radius: 22,
                //   ),
                // ),
                Positioned(
                    top: 150,
                    right: 0,
                    left: 0,
                    child: Column(
                      children: [
                        contactButton(
                            buttonName: 'Call President', icon: Icons.call),
                        SizedBox(
                          height: 20,
                        ),
                        contactButton(
                            buttonName: 'Whatsapp Group', icon: Icons.chat),
                      ],
                    ))
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.63,
            minChildSize: 0.63,
            maxChildSize: 1,
            builder: (context, controller) => Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(199, 245, 245, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Column(
                    children: [
                      gap(height: 15),
                      ModifiedText(
                        text: 'More Features',
                        size: 20,
                        color: AppColor.fontColor,
                        fontWeight: FontWeight.w500,
                      ),
                      gap(height: 15),

                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              gap(height: 15),
                              customListTile(
                                  onTap: () {},
                                  title: 'Set Meet Time',
                                  leading: Icons.alarm),
                              customListTile(
                                  onTap: () {},
                                  title: 'Set Meet Time',
                                  leading: Icons.alarm),
                              customListTile(
                                  onTap: () {},
                                  title: 'Set Meet Time',
                                  leading: Icons.alarm),
                              customListTile(
                                  onTap: () {},
                                  title: 'Set Meet Time',
                                  leading: Icons.alarm),
                              customListTile(
                                  onTap: () {},
                                  title: 'Set Meet Time',
                                  leading: Icons.alarm),
                              customListTile(
                                  onTap: () {},
                                  title: 'Set Meet Time',
                                  leading: Icons.alarm),
                              gap(height: 15),
                              const Divider(
                                thickness: 1.5,
                                color: Colors.white,
                              ),
                              ExpansionTile(
                                shape: const Border(),
                                title: ModifiedText(
                                    text: 'privacy and policy',
                                    size: 16,
                                    color: AppColor.fontColor),
                                children: [
                                  customListTile(
                                      onTap: () {},
                                      title: 'Set Meet Time',
                                      leading: Icons.alarm),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20),
                                child: Row(
                                  
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ModifiedText(
                                        text: 'Logout',
                                        size: 16,
                                        color: AppColor.fontColor),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.logout,color: Colors.blue,))
                                  ],
                                ),
                              ),
                              gap(height: 50),
                              ModifiedText(text: 'version 1.0', size: 12, color: AppColor.fontColor),
                              gap(
                                height: 20
                              )
                            ],
                          ),
                        ),
                      ),
                      //
                    ],
                  ),
                )
                //
                ),
          ),
        ],
      ),
    );
  }
}
