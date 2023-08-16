import 'package:flutter/material.dart';
import 'package:gymbuddy/screen/auth/register_screen.dart';
import 'package:gymbuddy/service/auth/login_email_service.dart';
import 'package:gymbuddy/widgets/utils/custom_text_button.dart';
import 'package:gymbuddy/widgets/utils/inputs/custom_text_input.dart';
import 'package:gymbuddy/widgets/utils/wide_button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomTextButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          ),
                          text: 'Forgot password?',
                          textStyle: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    WideButton(
                      text: 'Login',
                      onPressed: () {
                        signUserIn(context, controllers);
                      },
                    ),
                    CustomTextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      ),
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
