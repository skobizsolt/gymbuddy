import 'package:flutter/material.dart';

// Bottom navigation bar
enum BottomNavigationTab { home, stats, chats, me }

// Data management
enum CrudType { add, edit }

class GlobalValues {
  // Main navigation key
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Current route
  static const SERVER_URL = ANDROID_EMULATOR_URL;

  //android emulator url
  static const ANDROID_EMULATOR_URL = "10.0.2.2:8080";

  //ios emulator url
  static const IOS_EMAULATOR_URL = "localhost:8080";
}
