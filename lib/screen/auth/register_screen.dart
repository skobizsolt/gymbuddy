import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/components/inputs/default_text_form_field.dart';
import 'package:gymbuddy/components/inputs/email_form_field.dart';
import 'package:gymbuddy/components/inputs/password_form_field.dart';
import 'package:gymbuddy/components/inputs/username_form_field.dart';
import 'package:gymbuddy/models/auth/auth_dto.dart';
import 'package:gymbuddy/models/auth/new_user_dto.dart';
import 'package:gymbuddy/providers/auth_provider.dart';
import 'package:gymbuddy/service/profile/profile_data_service.dart';
import 'package:gymbuddy/service/util/keyboard_service.dart';
import 'package:gymbuddy/widgets/utils/brand_icon.dart';
import 'package:gymbuddy/widgets/utils/custom_text_button.dart';
import 'package:gymbuddy/widgets/utils/wide_button.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  final void Function() onPressed;
  RegisterScreen({super.key, required this.onPressed});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final NewUserDto _newUser = NewUserDto();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool _isAuthenticating = false;

  Future<void> submitForm() async {
    var validForm = _form.currentState!.validate();

    if (!validForm) {
      return;
    }
    _form.currentState!.save();
    // Check if passwords not match
    if (_newUser.password != _newUser.passwordAgain) {
      showErrorSnackBar(context, "Passwords not match!");
      return;
    }
    // Check if username is unique
    bool isUniqueUsername = await ProfileDataService()
        .usernames
        .then((value) => !value.contains(_newUser.username));

    if (!isUniqueUsername) {
      showErrorSnackBar(context, 'Username is already taken!');
      return;
    }

    final AuthDto _authDto = AuthDto();
    _authDto.email = _newUser.email;
    _authDto.password = _newUser.password;
    setState(() {
      _isAuthenticating = true;
    });

    await ref
        .read(authProvider.notifier)
        .signUserUp(context, _authDto)
        .then((value) async =>
            await ProfileDataService().registerUserData(value, _newUser))
        .then((value) async => await ProfileDataService()
            .addUsernameToCollection(_newUser.username, _newUser.email));
    resetButton();
  }

  resetButton() {
    if (!mounted) {
      _isAuthenticating = false;
      return;
    }
    setState(() {
      _isAuthenticating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: KeyboardService.closeKeyboard,
      child: Scaffold(
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
                        // App Icon
                        const BrandIcon(),
                        const SizedBox(
                          height: 10,
                        ),

                        // Header
                        Text(
                          'Join our community! ❤',
                          style: Theme.of(context).textTheme.displaySmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 50,
                        ),

                        // First Name
                        DefaultTextFormField(
                          hintText: 'First Name',
                          onSaved: (newValue) {
                            _newUser.firstName = newValue!.trim();
                          },
                        ),

                        // Last name
                        DefaultTextFormField(
                          hintText: 'Last Name',
                          onSaved: (newValue) {
                            _newUser.lastName = newValue!.trim();
                          },
                        ),

                        // Email field
                        EmailFormField(
                          onSaved: (newValue) {
                            _newUser.email = newValue!.trim();
                          },
                        ),

                        // Username
                        UsernameFormField(
                          onSaved: (newValue) {
                            _newUser.username = newValue!.trim();
                          },
                        ),

                        // Password
                        PasswordFormField(
                          hintText: 'Password',
                          onsaved: (newValue) {
                            _newUser.password = newValue!.trim();
                          },
                        ),

                        // Repeat password
                        PasswordFormField(
                          hintText: 'Password again',
                          onsaved: (newValue) {
                            _newUser.passwordAgain = newValue!.trim();
                          },
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // Register a new user
                        _isAuthenticating
                            ? const CircularProgressIndicator()
                            : WideButton(
                                text: 'Register now!',
                                onPressed: submitForm,
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
        ),
      ),
    );
  }
}
