import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/providers/auth_provider.dart';
import 'package:gymbuddy/screen/auth/login_or_register_screen.dart';
import 'package:gymbuddy/screen/tabs.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var stream = ref.read(authStateChangeProvider);
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: stream,
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            ref.invalidate(authStateChangeProvider);
            return const TabsScreen();
          }
          // user is not logged in
          return const LoginOrRegisterScreen();
        },
      ),
    );
  }
}
