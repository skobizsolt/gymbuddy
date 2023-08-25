import 'package:flutter/material.dart';
import 'package:gymbuddy/components/inputs/email_form_field.dart';
import 'package:gymbuddy/components/inputs/password_form_field.dart';
import 'package:gymbuddy/models/auth/auth_dto.dart';
import 'package:gymbuddy/screen/auth/forgot_password_screen.dart';
import 'package:gymbuddy/service/auth/email_auth_service.dart';
import 'package:gymbuddy/service/util/keyboard_service.dart';
import 'package:gymbuddy/widgets/utils/brand_icon.dart';
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
    AuthService()
        .signUserIn(context, _authDto)
        .then((value) => _isAuthenticating = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => KeyboardService().unFocusKeyboard(context),
      child: Scaffold(
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
                        const BrandIcon(),
                        const SizedBox(
                          height: 10,
                        ),

                        // Header
                        Text(
                          'Greetings!',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(
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
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordScreen(),
                                  )),
                              text: 'Forgot password?',
                              textStyle: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        // Log in the user
                        _isAuthenticating
                            ? const CircularProgressIndicator()
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
      ),
    );
  }
}
