import 'package:flutter/material.dart';
import 'package:gymbuddy/layout/input_layout.dart';
import 'package:gymbuddy/models/auth/auth_dto.dart';
import 'package:gymbuddy/service/auth/email_auth_service.dart';
import 'package:gymbuddy/service/auth/validators.dart';
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

  void submitForm() {
    var validForm = _form.currentState!.validate();

    if (validForm) {
      return;
    }
    _form.currentState!.save();
    signUserIn(context, _authDto);
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
                      InputLayout(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration.collapsed(
                              hintText: 'Email',
                            ),
                            validator: (value) {
                              return InputValidator().validateEmail(value);
                            },
                            onSaved: (newValue) {
                              _authDto.email = newValue!;
                            },
                          ),
                        ),
                      ),

                      // Password
                      InputLayout(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration.collapsed(
                              hintText: 'Password',
                            ),
                            obscureText: true,
                            validator: (value) {
                              return InputValidator().validatePassword(value);
                            },
                            onSaved: (newValue) {
                              _authDto.password = newValue!;
                            },
                          ),
                        ),
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
