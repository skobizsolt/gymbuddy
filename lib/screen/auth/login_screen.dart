import 'package:flutter/material.dart';
import 'package:gymbuddy/components/inputs/email_form_field.dart';
import 'package:gymbuddy/components/inputs/password_form_field.dart';
import 'package:gymbuddy/models/auth/auth_dto.dart';
import 'package:gymbuddy/service/auth/email_auth_service.dart';
import 'package:gymbuddy/widgets/utils/custom_text_button.dart';
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
  final AuthDto _authDto = AuthDto();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  static bool _isAuthenticating = false;

  void submitForm() {
    var validForm = _form.currentState!.validate();

    if (!validForm) {
      return;
    }
    _form.currentState!.save();
    // setState(() {
    //   _isAuthenticating = true;
    // });
    signUserIn(context, _authDto).then((value) => _isAuthenticating = false);
  }

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
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // App icon
                      Image.asset(
                        'lib/assets/images/logo.png',
                        cacheHeight: 144,
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      // Header
                      Text(
                        'Greetings!',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(
                        height: 50,
                      ),

                      // Email field
                      EmailFormField(
                        onSaved: (newValue) {
                          _authDto.email = newValue!;
                        },
                      ),

                      // Password
                      PasswordFormField(
                        hintText: 'Password',
                        onsaved: (newValue) {
                          _authDto.password = newValue!;
                        },
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
                      _isAuthenticating
                          ? CircularProgressIndicator()
                          : WideButton(
                              text: 'Login',
                              onPressed: submitForm,
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
      ),
    );
  }
}
