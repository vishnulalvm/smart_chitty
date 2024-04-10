import 'package:flutter/material.dart';
import 'package:smart_chitty/pages/tabs/home.dart';
import 'package:smart_chitty/auth/login.dart';
import 'package:smart_chitty/pages/tabs/members.dart';
import 'package:smart_chitty/pages/tabs/profile.dart';
import 'package:smart_chitty/auth/splash.dart';

const saveKeyName = 'userLogin';

final Map<String, WidgetBuilder> routes = {
  '/splash': (context) => const SplashScreen(),
  '/home': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/member': (context) => const MembersScreen(),
};
