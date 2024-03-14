import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:smart_chitty/pages/account.dart';
import 'package:smart_chitty/pages/members.dart';
import 'package:smart_chitty/pages/scheme.dart';
import 'package:smart_chitty/pages/update_button.dart';
import 'package:smart_chitty/widgets/icon_button.dart';
import 'package:text_scroll/text_scroll.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
       
        actions: [
     Padding(
       padding: const EdgeInsets.only(right: 12),
       child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AccountScreen()));
                      },
                      child: const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/smart kuri.jpeg'),
                        radius: 22,
                      ),
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
              
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 190,
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Updates:',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                        TextScroll(
                          fadeBorderSide: FadeBorderSide.both,
                          'New Chitty Scheme is start on \'january\' ,Start saving Money!!  ',
                          mode: TextScrollMode.endless,
                          velocity: Velocity(pixelsPerSecond: Offset(70, 0)),
                          delayBefore: Duration(milliseconds: 100),
                          numberOfReps: 100,
                          pauseBetween: Duration(seconds: 1),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.right,
                          selectable: true,
                        ),
                      ],
                    ),
                  )),
                ),
                Positioned(
                  top: 240,
                  left: 25,
                  right: 25,
                  bottom: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircularIconhome(
                        icontype: Symbols.finance,
                        buttonpress: () {},
                        iconname: 'Statistics',
                      ),
                      CircularIconhome(
                        icontype: Symbols.keyboard_command_key,
                        buttonpress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const SchemeButtonHome()));
                        },
                        iconname: 'Scheme',
                      ),
                      CircularIconhome(
                        icontype: Symbols.group,
                        buttonpress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const MembersScreen()));
                        },
                        iconname: 'Members',
                      ),
                      CircularIconhome(
                        icontype: Symbols.alarm,
                        buttonpress: () {},
                        iconname: 'Reminder',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.63,
            minChildSize: 0.63,
            maxChildSize: 0.88,
            builder: (context, controller) => Container(
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(199, 245, 245, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Notification',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(29, 27, 32, 1)),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'See All',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(29, 27, 32, 1)),
                              )),
                        ],
                      ),

                      Expanded(
                        child: ListView.builder(
                          controller: controller,
                          itemCount: 15,
                          itemBuilder: (context, index) {
                            return const Padding(
                              padding:
                                  EdgeInsets.only(left: 6, right: 6, bottom: 4),
                              child: Card(
                                elevation: 0,
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 20,
                                      // backgroundImage: AssetImage(item.imagePath), // Use your image path
                                    ),
                                    title: Text("item.title"),
                                    subtitle: Text('item.subtitle'),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text('item.trailingText1'),
                                        SizedBox(
                                            height:
                                                15), // Add some spacing between text widgets (optional)
                                        Text('item.trailingText2'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
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
      floatingActionButton: FloatingActionButton.extended(
          label: const Text(
            'Update',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
            weight: 800,
          ),
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Adjust radius as needed
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const UpdateButton()));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
