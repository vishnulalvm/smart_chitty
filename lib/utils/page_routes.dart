import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_chitty/auth/login.dart';
import 'package:smart_chitty/auth/onboarding.dart';
import 'package:smart_chitty/auth/splash.dart';
import 'package:smart_chitty/main.dart';
import 'package:smart_chitty/pages/others/other_screens/all_transaction.dart';
import 'package:smart_chitty/pages/tabs/reminders.dart';
import 'package:smart_chitty/pages/tabs/home.dart';
import 'package:smart_chitty/pages/tabs/members.dart';
import 'package:smart_chitty/pages/tabs/statistics.dart';

final GoRouter router = GoRouter(
  initialLocation: initScreen == 0 || initScreen == null ? "/first" : "/splash",
  routes: <RouteBase>[
    GoRoute(
      path: '/first', 
      builder: (BuildContext context, GoRouterState state) =>
          const OnboardingScreen(), // Replace SplashScreen with your actual splash screen widget
    ),
    GoRoute(
      path: '/splash', 
      builder: (BuildContext context, GoRouterState state) =>
          const SplashScreen(), // Replace SplashScreen with your actual splash screen widget
    ),
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'transaction',
          builder: (BuildContext context, GoRouterState state) {
            return const TransactionScreen();
          },
        ),
        GoRoute(
          path: 'members',
          builder: (BuildContext context, GoRouterState state) {
            return const MembersScreen();
          },
        ),
        GoRoute(
          path: 'statistics',
          builder: (BuildContext context, GoRouterState state) {
            return const StatisticsScreen();
          },
        ),
        GoRoute(
          path: 'reminder',
          builder: (BuildContext context, GoRouterState state) =>
              const ReminderScreen(),
        ),
        GoRoute(
          path: 'login', // Add this line to define the "/login" route
          builder: (BuildContext context, GoRouterState state) =>
              const LoginScreen(), // Replace LoginScreen with your actual login screen widget
        ),
      ],
    ),
  ],
);
