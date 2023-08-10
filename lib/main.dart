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

    // Color palette
    colorScheme: colorScheme,
    appBarTheme: AppBarTheme.of(context).copyWith(
      backgroundColor: discordBlack,
      foregroundColor: orange,
    ),

    // Bottom nav bar theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: discordBlack,
      selectedItemColor: orange,
      unselectedItemColor: discordWhite,
      type: BottomNavigationBarType.fixed,
    ),

    // Card theme
    cardTheme: CardTheme.of(context).copyWith(
      color: discordLightGray,
      surfaceTintColor: discordLightGray,
      elevation: 10,
    ),

    // Text themes
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      titleLarge: const TextStyle().copyWith(
        color: orange,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: const TextStyle().copyWith(
        color: orange,
        fontSize: 15,
      ),
      titleSmall: const TextStyle().copyWith(
        color: discordWhite,
        fontSize: 13,
      ),
      bodyLarge: const TextStyle().copyWith(
        color: orange,
      ),
      bodyMedium: const TextStyle().copyWith(
        color: orange,
      ),
      bodySmall: const TextStyle().copyWith(
        color: orange,
      ),
    ),

    // Dialog theme
    dialogTheme: DialogTheme.of(context).copyWith(
      backgroundColor: discordBlack,
      titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: orange,
          ),
      contentTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: orange,
          ),
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: discordLightGray,
        textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    ),

    // List tile theme
    listTileTheme: ListTileThemeData(
      titleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
      subtitleTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: discordWhite,
          ),
    ),
    searchBarTheme: SearchBarThemeData(
      textStyle: MaterialStatePropertyAll(
        const TextStyle().copyWith(color: orange),
      ),
      surfaceTintColor: const MaterialStatePropertyAll(discordBlack),
    ),
    bottomSheetTheme: const BottomSheetThemeData().copyWith(
        backgroundColor: colorScheme.primary,
        shape: Border.all(
          style: BorderStyle.none,
        ),
        elevation: 0),
  );
}
