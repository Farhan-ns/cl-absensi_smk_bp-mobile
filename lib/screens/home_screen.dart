import 'package:absensi_smk_bp/screens/tabs/history_tab.dart';
import 'package:absensi_smk_bp/screens/tabs/home_tab.dart';
import 'package:absensi_smk_bp/screens/tabs/profile_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PersistentTabController();
  }

  final List<Widget> _tabs = [
    const HomeTab(),
    const HistoryTab(),
    ProfileTab(),
  ];

  final List<PersistentBottomNavBarItem> _navbarItems = [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      title: 'Home',
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.assignment),
      title: 'History',
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person),
      title: 'Profil',
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _tabs,
      items: _navbarItems,
      confineInSafeArea: true,
      navBarStyle: NavBarStyle.style6,
    );
  }
}
