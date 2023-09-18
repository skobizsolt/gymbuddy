import 'package:flutter/material.dart';

// Bottom navigation bar
enum BottomNavigationTab { home, stats, chats, me }

// Data management
enum CrudType { add, edit }

class GlobalValues {
  // Main navigation key
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
