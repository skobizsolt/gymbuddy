import 'package:flutter/material.dart';
import 'package:gymbuddy/widgets/utils/custom_text_button.dart';
import 'package:gymbuddy/widgets/utils/inputs/custom_text_input.dart';
import 'package:gymbuddy/widgets/utils/wide_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'lib/assets/images/logo.png',
                    cacheHeight: 144,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Join our community! ❤',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  // Email
                  CustomTextInput(
                    labelText: 'Email',
                    color: Theme.of(context).primaryColorDark,
                  ),
                  // Username
                  CustomTextInput(
                    labelText: 'Username',
                    color: Theme.of(context).primaryColorDark,
                  ),
                  // Password
                  CustomTextInput(
                    labelText: 'Password',
                    color: Theme.of(context).primaryColorDark,
                    isObscured: true,
                  ),
                  // Repeat password
                  CustomTextInput(
                    labelText: 'Password',
                    color: Theme.of(context).primaryColorDark,
                    isObscured: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  WideButton(
                    text: 'Register now!',
                    onPressed: () {},
                  ),
                  CustomTextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    text: 'Already a member? Log in',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
