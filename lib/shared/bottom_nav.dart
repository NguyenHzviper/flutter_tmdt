// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:price_alert/controllers/mainscreen_provider.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          bottomNavigationBar: NavigationBar(
              height: 80,
              elevation: 0,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Ionicons.home_outline),
                  selectedIcon: Icon(Ionicons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Ionicons.terminal_outline),
                  selectedIcon: Icon(Ionicons.terminal),
                  label: 'Dashboard',
                ),
                NavigationDestination(
                  icon: Icon(Ionicons.person_outline),
                  selectedIcon: Icon(Ionicons.person),
                  label: 'Profile',
                ),
              ],
              selectedIndex: mainScreenNotifier.pageIndex,
              onDestinationSelected: (index) {
                mainScreenNotifier.setPageIndex(index);
              }),
        );
      },
    );
  }
}
