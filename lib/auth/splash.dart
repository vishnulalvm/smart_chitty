import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/constants.dart';
import 'package:smart_chitty/utils/text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLoglogin();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/smartkuri.jpeg',
              width: 250,
            ),
            BoldText(text: 'SMART CHITS', size: 45, color: AppColor.fontColor)
          ],
        ),
      ),
    );
  }

  Future<void> gotohomeScreen() async {
   context.pushReplacement('/login');
  }

  Future<void> checkLoglogin() async {
    final sharedpref = await SharedPreferences.getInstance();
    final userloged = sharedpref.getBool(saveKeyName);
    Timer(const Duration(seconds: 2), () {
      if (userloged == null || userloged == false) {
        gotohomeScreen();
      } else {
        context.pushReplacement('/');
      }
    });
  }
}
