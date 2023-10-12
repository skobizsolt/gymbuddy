import 'package:flutter/material.dart';

import 'package:gymbuddy/models/screens.dart';
import 'package:gymbuddy/screen/chats_screen.dart';
import 'package:gymbuddy/screen/home_screen.dart';
import 'package:gymbuddy/screen/profile_screen.dart';
import 'package:gymbuddy/screen/stats_screen.dart';
import 'package:gymbuddy/service/util/keyboard_service.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;
  List<Screen> screens = [
    Screen(
      body: HomeScreen(),
    ),
    Screen(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: const StatisticsSreen(),
    ),
    Screen(
      appBar: AppBar(
        title: const Text('My Buddies'),
      ),
      body: ChatsScreen(),
    ),
    Screen(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: const ProfileScreen(),
    ),
  ];

  void _selectPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Screen activeScreen = screens[_currentIndex];

    return GestureDetector(
      onTap: KeyboardService.closeKeyboard,
      child: Scaffold(
        appBar: activeScreen.appBar,
        body: activeScreen.body,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Stats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Me',
            ),
          ],
        ),
      ),
    );
  }
}
