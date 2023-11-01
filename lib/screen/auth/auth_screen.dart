import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/providers/auth_provider.dart';
import 'package:gymbuddy/providers/chat_provider.dart';
import 'package:gymbuddy/providers/user_provider.dart';
import 'package:gymbuddy/providers/workout_provider.dart';
import 'package:gymbuddy/providers/workout_runner_provider.dart';
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
            _invalidateProviders(ref);

            return const TabsScreen();
          }
          // user is not logged in
          return const LoginOrRegisterScreen();
        },
      ),
    );
  }

  void _invalidateProviders(WidgetRef ref) {
    ref.invalidate(userProvider);
    ref.invalidate(chatsProvider);
    ref.invalidate(workoutStateProvider);
    ref.invalidate(workoutRunnerStateProvider);
  }
}
