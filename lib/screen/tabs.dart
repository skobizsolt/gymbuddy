import 'package:flutter/material.dart';

import 'package:gymbuddy/models/screens.dart';
import 'package:gymbuddy/screen/chats_screen.dart';
import 'package:gymbuddy/screen/home_screen.dart';
import 'package:gymbuddy/screen/profile_screen.dart';
import 'package:gymbuddy/screen/stats_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Screen> screens = [
    Screen(
      body: const HomeScreen(),
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
      body: const ChatsScreen(),
    ),
    Screen(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: const ProfileScreen(),
    ),
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Screen activeScreen = screens[_selectedPageIndex];

    return Scaffold(
      appBar: activeScreen.appBar,
      body: activeScreen.body,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
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
    );
  }
}
