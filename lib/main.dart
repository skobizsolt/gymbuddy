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
  const Color orange = Color.fromARGB(255, 242, 135, 5);
  const Color discordBlack = Color.fromARGB(255, 30, 31, 34);
  const Color discordGray = Color.fromARGB(255, 43, 45, 49);
  const Color discordLightGray = Color.fromARGB(255, 66, 71, 78);
  const Color discordWhite = Color.fromARGB(255, 169, 174, 181);

  ColorScheme colorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: orange,
    background: discordGray,
    onBackground: orange,
    primary: orange,
    secondary: discordWhite,
    tertiary: Colors.white,
  );

  return ThemeData(
    useMaterial3: true,
    primaryColor: discordGray,
    primaryColorDark: discordBlack,
    primaryColorLight: discordLightGray,
    colorScheme: colorScheme,
    appBarTheme: AppBarTheme.of(context).copyWith(
      backgroundColor: discordBlack,
      foregroundColor: orange,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: discordBlack,
      selectedItemColor: orange,
      unselectedItemColor: discordWhite,
      type: BottomNavigationBarType.fixed,
    ),
    cardTheme: CardTheme.of(context).copyWith(
      color: discordLightGray,
      surfaceTintColor: discordLightGray,
      elevation: 10,
    ),
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      titleLarge: const TextStyle(
        color: orange,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: const TextStyle(
        color: orange,
        fontSize: 15,
      ),
      titleSmall: const TextStyle(
        color: discordWhite,
        fontSize: 13,
      ),
    ),
    dialogTheme: DialogTheme.of(context).copyWith(
      backgroundColor: discordBlack,
      titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: orange,
          ),
      contentTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: orange,
          ),
    ),
  );
}
