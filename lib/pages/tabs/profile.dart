import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chitty/pages/others/other_screens/view_id_screen.dart';
import 'package:smart_chitty/pages/others/profilescreen_features/about_company.dart';
import 'package:smart_chitty/pages/others/profilescreen_features/connect_developer.dart';
import 'package:smart_chitty/pages/others/profilescreen_features/change_password.dart';
import 'package:smart_chitty/pages/others/profilescreen_features/help.dart';
import 'package:smart_chitty/pages/tabs/home.dart';
import 'package:smart_chitty/pages/tabs/reminders.dart';
import 'package:smart_chitty/services/db%20functions/registration_function.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/images.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/features/contact_button.dart';
import 'package:smart_chitty/widgets/global/list_tile_account.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';
import 'package:url_launcher/url_launcher.dart';

String companyName = '';
String presidentPhoneNumber = '8138946412';
String whatsappUrl = 'https://chat.whatsapp.com/GD9M49Vc4a8JiuAcHJXqww';
String privacy =
    'https://www.freeprivacypolicy.com/live/53660151-1c7f-4d0f-8659-3d9c49925043';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );
  BuildContext? _context;
  @override
  void initState() {
    super.initState();
    _context = context;
    initPackageInfo();
  }

  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    for (final company in companyDatas) {
      companyName = company.companyName;
      presidentPhoneNumber = company.phoneNumber;
      whatsappUrl = company.whatsappLink;
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                      padding: const EdgeInsets.only(bottom: 20),
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => ViewIdScreen(
                                          path: companyLogo,
                                        )));
                              },
                              child: CircleAvatar(
                                backgroundImage: FileImage(File(companyLogo)),
                                radius: 45,
                              ),
                            ),
                            gap(height: 10),
                            ModifiedText(
                                textOverflow: TextOverflow.ellipsis,
                                text: companyName,
                                size: 30,
                                color: Colors.white)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          contactButton(
                              buttonName: 'Customer Care',
                              icon: Icons.call,
                              buttonAction: () => makePhoneCall()),
                          gap(height: 20),
                          contactButton(
                            buttonName: 'Whatsapp Group',
                            icon: FontAwesomeIcons.whatsapp,
                            buttonAction: () => launchWhatsApp(whatsappUrl),
                          ),
                        ],
                      ),
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
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const AboutCompany()));
                                  },
                                  title: 'About Company',
                                  leading: Icons.info),
                              customListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const ReminderScreen()));
                                  },
                                  title: 'Reminders',
                                  leading: Icons.notifications_active),
                              customListTile(
                                  onTap: () {
                                    context.push('/members');
                                  },
                                  title: 'Members',
                                  leading: FontAwesomeIcons.userGroup),
                              customListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const ChangeUserPassword()));
                                  },
                                  title: 'Change Username & Password',
                                  leading: FontAwesomeIcons.userLock),
                              customListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const HelperScreen()));
                                  },
                                  title: 'Help',
                                  leading: Icons.help),
                              customListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const ConnectDeveloper()));
                                  },
                                  title: 'Connect to Developer',
                                  leading: Symbols.code),
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
                                      onTap: () => launchWhatsApp(privacy),
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
                              gap(height: 30),
                              ModifiedText(
                                  text:
                                      '${packageInfo.appName} : ${packageInfo.version}',
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
    context.pushReplacement('/login');
  }

  Future<void> makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: presidentPhoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> launchWhatsApp(String groupUrl) async {
    final Uri url = Uri.parse(groupUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
