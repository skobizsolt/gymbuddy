import 'package:flutter/material.dart';
import 'package:gymbuddy/screen/auth/login_screen.dart';
import 'package:gymbuddy/screen/auth/register_screen.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  const LoginOrRegisterScreen({super.key});

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
  bool isLoginScreen = true;

  void toggleScreens() {
    setState(() {
      isLoginScreen = !isLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoginScreen) {
      return LoginScreen(
        onPressed: toggleScreens,
      );
    }
    return RegisterScreen(
      onPressed: toggleScreens,
    );
  }
}
