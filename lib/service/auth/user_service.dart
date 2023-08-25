import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';

class UserService {
  passwordReset(final BuildContext context, final String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      FocusManager.instance.primaryFocus?.unfocus();
      showErrorSnackBar(context, e.message.toString());
    }
    Navigator.pop(context);
    showSucessSnackBar(context, 'Password reset email sent!');
  }
}
