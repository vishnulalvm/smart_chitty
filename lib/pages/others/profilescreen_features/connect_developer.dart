import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/appbar.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';
import 'package:url_launcher/url_launcher.dart';

String instagram = 'https://www.instagram.com/vishnulal_vm/';
String twitter = 'https://twitter.com/vishnulal_vm';
String github = 'https://github.com/vishnulalvm';
String linkedin = 'https://www.linkedin.com/in/vishnulal-v-m-b1015a1b9/';

class ConnectDeveloper extends StatelessWidget {
  const ConnectDeveloper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar:
          customAppBar(title: 'Connect With Developer', onpresed: (value) {}),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ModifiedText(
                    text: 'Social Profiles',
                    size: 25,
                    color: AppColor.fontColor,
                    fontWeight: FontWeight.w700,
                  ),
                  gap(height: 12),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: MediaQuery.of(context).size.width * 0.08,
                    runSpacing: MediaQuery.of(context).size.width * 0.08,
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => launchApps(instagram),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(12),
                          backgroundColor: Colors.blue,
                        ),
                        child: const Icon(
                          FontAwesomeIcons.instagram,
                          size: 28,
                          weight: 800,
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => launchApps(twitter),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(12),
                          backgroundColor: Colors.blue,
                        ),
                        child: const Icon(
                          FontAwesomeIcons.twitter,
                          size: 28,
                          weight: 800,
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => launchApps(github),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(12),
                          backgroundColor: Colors.blue,
                        ),
                        child: const Icon(
                          FontAwesomeIcons.github,
                          size: 28,
                          weight: 800,
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => launchApps(linkedin),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(12),
                          backgroundColor: Colors.blue,
                        ),
                        child: const Icon(
                          FontAwesomeIcons.linkedin,
                          size: 28,
                          weight: 800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            gap(height: 12),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.2,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(12),
                                backgroundColor: Colors.blue,
                              ),
                              child: const Icon(
                                Icons.email,
                                size: 28,
                                weight: 800,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'Email Me',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(12),
                                backgroundColor: Colors.blue,
                              ),
                              child: const Icon(
                                Icons.call,
                                size: 28,
                                weight: 800,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'Call Me',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> launchApps(String accountUrl) async {
    final Uri url = Uri.parse(accountUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
