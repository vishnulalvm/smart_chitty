import 'package:flutter/material.dart';
import 'package:smart_chitty/pages/home.dart';
import 'package:smart_chitty/pages/login.dart';
import 'package:smart_chitty/pages/members.dart';
import 'package:smart_chitty/pages/profile.dart';
import 'package:smart_chitty/pages/splash.dart';

const saveKeyName = 'userLogin';

final Map<String, WidgetBuilder> routes = {
  '/splash': (context) => const SplashScreen(),
  '/home': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/members': (context) => const MembersScreen(),
};
