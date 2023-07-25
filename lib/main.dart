import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymbuddy/screen/tabs.dart';

void main() {
  runApp(const ProviderScope(
    child: App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kDarkTheme(context),
      home: const TabsScreen(),
    );
  }
}

ThemeData kDarkTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 242, 135, 5),
      background: const Color.fromARGB(255, 43, 45, 49),
    ),
    appBarTheme: AppBarTheme.of(context).copyWith(
      backgroundColor: const Color.fromARGB(255, 30, 31, 34),
      foregroundColor: const Color.fromARGB(255, 242, 135, 5),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 30, 31, 34),
      selectedItemColor: Color.fromARGB(255, 242, 135, 5),
      unselectedItemColor: Color.fromARGB(255, 169, 174, 181),
      type: BottomNavigationBarType.fixed,
    ),
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      titleLarge: const TextStyle(
        color: Color.fromARGB(255, 242, 135, 5),
      ),
    ),
  );
}
