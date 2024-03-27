import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_chitty/auth/splash.dart';
import 'package:smart_chitty/pages/others/other_screens/all_transaction.dart';
import 'package:smart_chitty/pages/tabs/home.dart';
import 'package:smart_chitty/pages/tabs/members.dart';
import 'package:smart_chitty/pages/tabs/statistics.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash', // Set the initial location to '/splash'
  routes: <RouteBase>[
    GoRoute(
      path: '/splash', // Define the splash screen route
      builder: (BuildContext context, GoRouterState state) => const SplashScreen(), // Replace SplashScreen with your actual splash screen widget
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
      ],
      
    ),
  ],
);