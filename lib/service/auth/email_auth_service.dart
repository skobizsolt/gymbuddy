import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/models/auth/auth_dto.dart';

enum AuthenticationType { login, register }

Future<UserCredential?> signUserIn(
    final BuildContext context, final AuthDto request) {
  return _authenticate(context, request, AuthenticationType.login);
}

Future<UserCredential?> signUserUp(
    final BuildContext context, final AuthDto request) async {
  return _authenticate(context, request, AuthenticationType.register);
}

Future<UserCredential?> _authenticate(final BuildContext context,
    final AuthDto request, final AuthenticationType type) async {
  // Try authentication
  try {
    // Case: login
    if (type == AuthenticationType.login) {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
    }
    // Case: Sign up
    if (type == AuthenticationType.register) {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
    }
  } on FirebaseAuthException catch (e) {
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
  return null;
}
