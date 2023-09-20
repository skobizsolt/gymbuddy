import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gymbuddy/global/global_variables.dart';
import 'package:gymbuddy/screen/auth/auth_screen.dart';
import 'package:gymbuddy/service/notification_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().setupPushNotifications();
  runApp(const ProviderScope(
    child: ProviderScope(
      child: App(),
    ),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kDarkTheme(context),
      locale: const Locale('hu', 'HU'),
      home: const AuthScreen(),
      navigatorKey: GlobalValues.navigatorKey,
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
      foregroundColor: colorScheme.primary,
    ),

    // Bottom nav bar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: discordBlack,
      selectedItemColor: colorScheme.primary,
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
        color: colorScheme.primary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: const TextStyle().copyWith(
        color: colorScheme.primary,
        fontSize: 15,
      ),
      titleSmall: const TextStyle().copyWith(
        color: discordWhite,
        fontSize: 13,
      ),
      bodyLarge: const TextStyle().copyWith(
        color: colorScheme.primary,
      ),
      bodyMedium: const TextStyle().copyWith(
        color: colorScheme.primary,
      ),
      bodySmall: const TextStyle().copyWith(
        color: colorScheme.primary,
      ),
      displayLarge: const TextStyle().copyWith(
        color: colorScheme.primary,
      ),
      displayMedium: const TextStyle().copyWith(
        color: colorScheme.primary,
      ),
      displaySmall: const TextStyle().copyWith(
        color: colorScheme.primary,
      ),
    ),

    // Dialog theme
    dialogTheme: DialogTheme.of(context).copyWith(
      titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: colorScheme.primary,
          ),
      contentTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: colorScheme.primary,
          ),
      surfaceTintColor: discordGray,
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

    // Filled button
    filledButtonTheme: FilledButtonThemeData(
      style: const ButtonStyle().copyWith(
        backgroundColor: const MaterialStatePropertyAll(discordBlack),
        foregroundColor: MaterialStatePropertyAll(colorScheme.primary),
        elevation: const MaterialStatePropertyAll(8),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(
      backgroundColor: Theme.of(context).primaryColorDark,
      foregroundColor: orange,
      extendedTextStyle: const TextStyle().copyWith(
        color: Colors.transparent,
        fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
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
        iconColor: colorScheme.primary),

    // Search bar theme
    searchBarTheme: SearchBarThemeData(
      textStyle: MaterialStatePropertyAll(
        const TextStyle().copyWith(color: colorScheme.primary),
      ),
      surfaceTintColor: const MaterialStatePropertyAll(discordBlack),
    ),

    // Bottom sheet theme
    bottomSheetTheme: const BottomSheetThemeData().copyWith(
      backgroundColor: colorScheme.background,
      shape: Border.all(
        style: BorderStyle.none,
      ),
      elevation: 0,
    ),

    // Text input decoration
    inputDecorationTheme: const InputDecorationTheme().copyWith(
      hintStyle: const TextStyle().copyWith(
        color: colorScheme.primary,
      ),
      labelStyle: const TextStyle().copyWith(
        color: colorScheme.primary,
      ),
    ),
  );
}
