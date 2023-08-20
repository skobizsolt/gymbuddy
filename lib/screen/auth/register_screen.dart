import 'package:flutter/material.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/service/auth/email_auth_service.dart';
import 'package:gymbuddy/widgets/utils/custom_text_button.dart';
import 'package:gymbuddy/components/inputs/custom_text_input.dart';
import 'package:gymbuddy/widgets/utils/wide_button.dart';

class RegisterScreen extends StatefulWidget {
  final void Function() onPressed;
  RegisterScreen({super.key, required this.onPressed});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controllers = {
    "email": TextEditingController(),
    "username": TextEditingController(),
    "password": TextEditingController(),
    "passwordAgain": TextEditingController()
  };

  bool isPasswordsValid(final String password, final String passwordAgain) {
    if (password == passwordAgain) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      controller: controllers["email"],
                      labelText: 'Email',
                      color: Theme.of(context).primaryColorDark,
                    ),

                    // Username
                    CustomTextInput(
                      controller: controllers["username"],
                      labelText: 'Username',
                      color: Theme.of(context).primaryColorDark,
                    ),

                    // Password
                    CustomTextInput(
                      controller: controllers["password"],
                      labelText: 'Password',
                      color: Theme.of(context).primaryColorDark,
                      obscureText: true,
                    ),

                    // Repeat password
                    CustomTextInput(
                      controller: controllers["passwordAgain"],
                      labelText: 'Password again',
                      color: Theme.of(context).primaryColorDark,
                      obscureText: true,
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    // Register a new user
                    WideButton(
                      text: 'Register now!',
                      onPressed: () {
                        print("Called");
                        isPasswordsValid(
                          controllers["password"]!.text,
                          controllers["passwordAgain"]!.text,
                        )
                            ? signUserUp(context, controllers)
                            : showErrorSnackBar(
                                context, "Passwords not match!");
                      },
                    ),

                    // Switch back to login screen
                    CustomTextButton(
                      onPressed: widget.onPressed,
                      text: 'Already a member? Log in',
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
