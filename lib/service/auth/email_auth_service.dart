import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';

enum _AuthenticationType { login, register }

void signUserIn(final BuildContext context,
    final Map<String, TextEditingController> controllers) {
  _authenticate(context, controllers, _AuthenticationType.login);
}

void signUserUp(final BuildContext context,
    final Map<String, TextEditingController> controllers) async {
  _authenticate(context, controllers, _AuthenticationType.register);
  // username has to be stored (TODO)
}

void _authenticate(
    final BuildContext context,
    final Map<String, TextEditingController> controllers,
    final _AuthenticationType type) async {
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
    if (type == _AuthenticationType.login) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: controllers["email"]!.text,
        password: controllers["password"]!.text,
      );
    }
    // Case: Sign up
    if (type == _AuthenticationType.register) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: controllers["email"]!.text,
        password: controllers["password"]!.text,
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
