import 'package:flutter/material.dart';
import 'package:gymbuddy/service/auth/email_auth_service.dart';
import 'package:gymbuddy/widgets/utils/custom_text_button.dart';
import 'package:gymbuddy/components/inputs/custom_text_input.dart';
import 'package:gymbuddy/widgets/utils/wide_button.dart';

class LoginScreen extends StatefulWidget {
  final void Function() onPressed;
  LoginScreen({
    super.key,
    required this.onPressed,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Map<String, TextEditingController> controllers = {
    "email": TextEditingController(),
    "password": TextEditingController()
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Headers
                    Image.asset(
                      'lib/assets/images/logo.png',
                      cacheHeight: 144,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Greetings!',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    SizedBox(
                      height: 50,
                    ),

                    // Email field
                    CustomTextInput(
                      controller: controllers["email"],
                      labelText: 'Email',
                      color: Theme.of(context).primaryColorDark,
                    ),

                    // Password
                    CustomTextInput(
                      controller: controllers["password"],
                      labelText: 'Password',
                      color: Theme.of(context).primaryColorDark,
                      obscureText: true,
                    ),

                    // Forgot password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomTextButton(
                          onPressed: () {},
                          text: 'Forgot password?',
                          textStyle: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    // Log in the user
                    WideButton(
                      text: 'Login',
                      onPressed: () {
                        signUserIn(context, controllers);
                      },
                    ),

                    // Switch to register
                    CustomTextButton(
                      onPressed: widget.onPressed,
                      text: 'New here? Register a new account',
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
