import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/models/auth/auth_dto.dart';

enum AuthenticationType { login, register }

void signUserIn(final BuildContext context, final AuthDto request) {
  _authenticate(context, request, AuthenticationType.login);
}

void signUserUp(final BuildContext context, final AuthDto request) async {
  _authenticate(context, request, AuthenticationType.register);
  // username has to be stored (TODO)
}

void _authenticate(final BuildContext context, final AuthDto request,
    final AuthenticationType type) async {
  // show loading circle
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  // Try authentication
  try {
    // Case: login
    if (type == AuthenticationType.login) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
    }
    // Case: Sign up
    if (type == AuthenticationType.register) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
    }

    // Pop the loading circle
    Navigator.pop(context);
  } on FirebaseAuthException catch (e) {
    // Pop the loading circle
    Navigator.pop(context);
    FocusManager.instance.primaryFocus?.unfocus();
    // User not found
    if (e.code == 'invalid-email' || e.code == 'user-not-found') {
      showErrorSnackBar(context, 'Incorrect email');
    }

    // Incorrect password
    else if (e.code == 'wrong-password') {
      showErrorSnackBar(context, 'Incorrect password');
    }
  }
}
