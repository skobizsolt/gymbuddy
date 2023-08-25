import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/components/inputs/default_text_form_field.dart';
import 'package:gymbuddy/components/inputs/email_form_field.dart';
import 'package:gymbuddy/components/inputs/password_form_field.dart';
import 'package:gymbuddy/components/inputs/username_form_field.dart';
import 'package:gymbuddy/global/user_data.dart';
import 'package:gymbuddy/models/auth/auth_dto.dart';
import 'package:gymbuddy/models/auth/new_user_dto.dart';
import 'package:gymbuddy/service/auth/email_auth_service.dart';
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
  bool _isAuthenticating = false;

  void submitForm() {
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
    final AuthDto _authDto = AuthDto();
    _authDto.email = _newUser.email;
    _authDto.password = _newUser.password;
    // setState(() {
    //   _isAuthenticating = true;
    // });
    AuthService()
        .signUserUp(context, _authDto)
        .then((value) => registerUserData(value));
  }

  void registerUserData(UserCredential? value) async {
    if (value == null || value.user == null) {
      return;
    }
    await FirebaseFirestore.instance
        .collection(FIRESTORE_USER_COLLECTION)
        .doc(value.user!.uid)
        .set({
      'email': value.user!.email,
      'username': _newUser.username,
      'first_name': _newUser.firstName,
      'last_name': _newUser.lastName
    });
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
                      // App Icon
                      Image.asset(
                        'lib/assets/images/logo.png',
                        cacheHeight: 144,
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      // Header
                      Text(
                        'Join our community! ❤',
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 50,
                      ),

                      // First Name
                      DefaultTextFormField(
                        hintText: 'First Name',
                        onSaved: (newValue) {
                          _newUser.firstName = newValue!;
                        },
                      ),

                      // Last name
                      DefaultTextFormField(
                        hintText: 'Last Name',
                        onSaved: (newValue) {
                          _newUser.lastName = newValue!;
                        },
                      ),

                      // Email field
                      EmailFormField(
                        onSaved: (newValue) {
                          _newUser.email = newValue!;
                        },
                      ),

                      // Username
                      UsernameFormField(
                        onSaved: (newValue) {
                          _newUser.username = newValue!;
                        },
                      ),

                      // Password
                      PasswordFormField(
                        hintText: 'Password',
                        onsaved: (newValue) {
                          _newUser.password = newValue!;
                        },
                      ),

                      // Repeat password
                      PasswordFormField(
                        hintText: 'Password again',
                        onsaved: (newValue) {
                          _newUser.passwordAgain = newValue!;
                        },
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      // Register a new user
                      _isAuthenticating
                          ? CircularProgressIndicator()
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
    );
  }
}
