import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void signUserIn(final BuildContext context,
    final Map<String, TextEditingController> controllers) async {
  // show loading circle
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  // Try sign in
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: controllers["email"]!.text,
      password: controllers["password"]!.text,
    );
    // Pop the loading circle
    Navigator.pop(context);
  } on FirebaseAuthException catch (e) {
    // Pop the loading circle
    Navigator.pop(context);
    print(e.code);
    // User not found
    if (e.code == 'invalid-email' || e.code == 'user-not-found') {
      wrongEmailMessagePopUp(context);
    }

    // Incorrect password
    else if (e.code == 'wrong-password') {
      wrongPasswordMessagePopUp(context);
    }
  }
}

void wrongEmailMessagePopUp(final BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    getSnackBar(context, 'Incorrect email'),
  );
}

void wrongPasswordMessagePopUp(final BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    getSnackBar(context, 'Incorrect password'),
  );
}

getSnackBar(BuildContext context, final String label) {
  FocusManager.instance.primaryFocus?.unfocus();
  return SnackBar(
    content: Text(
      label,
      style: TextStyle().copyWith(fontStyle: FontStyle.italic),
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Theme.of(context).colorScheme.error,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12))),
  );
}
