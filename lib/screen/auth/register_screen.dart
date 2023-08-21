import 'package:flutter/material.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/layout/input_layout.dart';
import 'package:gymbuddy/models/auth/auth_dto.dart';
import 'package:gymbuddy/models/auth/new_user_dto.dart';
import 'package:gymbuddy/service/auth/email_auth_service.dart';
import 'package:gymbuddy/service/auth/validators.dart';
import 'package:gymbuddy/widgets/utils/custom_text_button.dart';
import 'package:gymbuddy/widgets/utils/wide_button.dart';

class RegisterScreen extends StatefulWidget {
  final void Function() onPressed;
  RegisterScreen({super.key, required this.onPressed});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final NewUserDto _newUser = NewUserDto();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  void submitForm() {
    var validForm = _form.currentState!.validate();

    if (validForm) {
      return;
    }
    _form.currentState!.save();
    // Check if passwords not match
    if (_newUser.password != _newUser.passwordAgain) {
      showErrorSnackBar(context, "Passwords not match!");
      return;
    }
    final AuthDto _authDto = AuthDto();
    _authDto.email = _newUser.email;
    _authDto.password = _newUser.password;
    signUserUp(context, _authDto);
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
                child: Form(
                  key: _form,
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

                      // First and last name
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: InputLayout(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'First name',
                                  ),
                                  validator: (value) {
                                    return InputValidator()
                                        .validateUsername(value);
                                  },
                                  onSaved: (newValue) {
                                    _newUser.firstName = newValue!;
                                  },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InputLayout(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'Last name',
                                  ),
                                  validator: (value) {
                                    return InputValidator()
                                        .validateUsername(value);
                                  },
                                  onSaved: (newValue) {
                                    _newUser.lastName = newValue!;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
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
                              _newUser.email = newValue!;
                            },
                          ),
                        ),
                      ),

                      // Username
                      InputLayout(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration.collapsed(
                              hintText: 'Username',
                            ),
                            validator: (value) {
                              return InputValidator().validateUsername(value);
                            },
                            onSaved: (newValue) {
                              _newUser.username = newValue!;
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
                              _newUser.password = newValue!;
                            },
                          ),
                        ),
                      ),

                      // Repeat password
                      InputLayout(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration.collapsed(
                              hintText: 'Password again',
                            ),
                            obscureText: true,
                            validator: (value) {
                              return InputValidator().validatePassword(value);
                            },
                            onSaved: (newValue) {
                              _newUser.passwordAgain = newValue!;
                            },
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      // Register a new user
                      WideButton(text: 'Register now!', onPressed: submitForm),

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
      ),
    );
  }
}
