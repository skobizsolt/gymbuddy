import 'package:flutter/material.dart';

void showErrorSnackBar(final BuildContext context, final String message) {
  _showSnackbar(context, message,
      backgroundColor: Theme.of(context).colorScheme.error);
}

void showSucessSnackBar(final BuildContext context, final String message) {
  _showSnackbar(context, message,
      backgroundColor: const Color.fromARGB(255, 105, 201, 108));
}

void _showSnackbar(final BuildContext context, final String message,
    {Color? backgroundColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle().copyWith(fontStyle: FontStyle.italic),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    ),
  );
}
