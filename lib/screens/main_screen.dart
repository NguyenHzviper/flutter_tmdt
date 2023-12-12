// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:price_alert/controllers/mainscreen_provider.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'dashboard_screen.dart';
import 'package:price_alert/shared/bottom_nav.dart';

import 'profile_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Widget> pageList = const [
    Home(),
    DashBoard(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(builder: (context, notifier, child) {
      return Scaffold(
        body: pageList[notifier.pageIndex],
        bottomNavigationBar: const BottomNav(),
      );
    });
  }
}
