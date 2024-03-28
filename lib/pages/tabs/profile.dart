import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/images.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/features/contact_button.dart';
import 'package:smart_chitty/widgets/global/list_tile_account.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  BuildContext? _context;
  @override
  void initState() {
    super.initState();
    _context = context; // Store context in state variable
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Smart Chitty'),
        actions:  [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundImage: AssetImage(appLogo),
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
            decoration:  BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    backgroundImage,
                  ),
                  fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                Positioned(
                    top: 150,
                    right: 0,
                    left: 0,
                    child: Column(
                      children: [
                        contactButton(
                            buttonName: 'Call President', icon: Icons.call),
                        gap(height: 20),
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
                                  title: 'Notifications',
                                  leading: Icons.notifications_active),
                              customListTile(
                                  onTap: () {},
                                  title: 'Convert to Excel Sheet',
                                  leading: Icons.picture_as_pdf),
                              customListTile(
                                  onTap: () {},
                                  title: 'Change Username & Password',
                                  leading: Symbols.encrypted_rounded),
                              customListTile(
                                  onTap: () {},
                                  title: 'Help',
                                  leading: Icons.help),
                              customListTile(
                                  onTap: () {},
                                  title: 'Connect to Developer',
                                  leading: Symbols.exclamation),
                              gap(height: 15),
                              const Divider(
                                thickness: 1.5,
                                color: Colors.white,
                              ),
                              ExpansionTile(
                                shape: const Border(),
                                title: ModifiedText(
                                  text: 'Privacy and Policy',
                                  size: 16,
                                  color: AppColor.fontColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: [
                                  customListTile(
                                      onTap: () {},
                                      title: 'Privacy and Policy',
                                      leading: Icons.privacy_tip),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ModifiedText(
                                      text: 'Logout',
                                      size: 16,
                                      color: AppColor.fontColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    Container(
                                      width: 80,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: IconButton(
                                          onPressed: () {
                                            showLogoutDialog();
                                            // logout fuction
                                          },
                                          icon: const Icon(
                                            Icons.logout,
                                            color: Colors.red,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              gap(height: 50),
                              ModifiedText(
                                  text: 'version 1.0',
                                  size: 12,
                                  color: AppColor.fontColor),
                              gap(height: 20)
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

  void showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final sharedPre = await SharedPreferences.getInstance();
                await sharedPre.clear();
                Navigator.of(_context!).pop(); // Close the dialog
                _performLogout(_context!); // Perform logout logic
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _performLogout(BuildContext context) {
    // Perform logout logic

    context.pushReplacement('/login');
  }
}
