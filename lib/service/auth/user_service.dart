import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/models/auth/change_password_dto.dart';
import 'package:gymbuddy/service/util/keyboard_service.dart';

class UserService {
  passwordReset(final BuildContext context, final String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Navigator.pop(context);
      showSucessSnackBar(context, 'Password reset email sent!');
    } on FirebaseAuthException catch (e) {
      KeyboardService().closeKeyboard();
      showErrorSnackBar(context, e.message.toString());
    }
  }

  void changePassword(BuildContext context, ChangePasswordDto passwords) async {
    KeyboardService().closeKeyboard();
    if (!_isValidPasswords(context, passwords)) {
      return;
    }

    // Before pwd change, the user should be reauthenticated
    User? currentUser = FirebaseAuth.instance.currentUser;

    final AuthCredential credentials = EmailAuthProvider.credential(
        email: currentUser!.email!, password: passwords.oldPassword!);

    // Reauthenticate, then try to change password
    await currentUser
        .reauthenticateWithCredential(credentials)
        .then(
          (value) => _tryToChangePassword(currentUser, context, passwords),
        )
        .catchError((error) {
      showErrorSnackBar(context,
          'The given old password does not match with your current password');
    });
  }

  _isValidPasswords(BuildContext context, ChangePasswordDto passwords) {
    if (passwords.newPassword != passwords.newPasswordAgain) {
      showErrorSnackBar(context, 'Passwords not match!');
      return false;
    }

    if (passwords.oldPassword == passwords.newPassword) {
      showErrorSnackBar(context, 'Please give a new password!');
      return false;
    }
    return true;
  }

  _tryToChangePassword(User currentUser, BuildContext context,
      ChangePasswordDto passwords) async {
    return await currentUser
        .updatePassword(passwords.newPassword)
        .then((value) {
      showSucessSnackBar(context, 'Password changed successfully!');
      Navigator.of(context).pop();
    }).catchError((error) {
      showErrorSnackBar(context, 'Password change failed!');
    });
  }
}
