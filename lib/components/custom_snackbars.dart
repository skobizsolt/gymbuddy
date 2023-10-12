import 'package:flutter/material.dart';

void showErrorSnackBar(final BuildContext context, final String message) {
  _showSnackbar(context, message,
      backgroundColor: Theme.of(context).colorScheme.error);
}

void showSuccessSnackBar(final BuildContext context, final String message) {
  _showSnackbar(context, message,
      backgroundColor: const Color.fromARGB(255, 105, 201, 108));
}

void _showSnackbar(final BuildContext context, final String message,
    {Color? backgroundColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle().copyWith(fontStyle: FontStyle.italic),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    ),
  );
}
