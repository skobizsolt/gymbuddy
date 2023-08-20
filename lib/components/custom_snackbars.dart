import 'package:flutter/material.dart';

void showErrorSnackBar(final BuildContext context, final String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle().copyWith(fontStyle: FontStyle.italic),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Theme.of(context).colorScheme.error,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    ),
  );
}
