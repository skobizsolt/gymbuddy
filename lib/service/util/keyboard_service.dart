import 'package:flutter/material.dart';

class KeyboardService {
  static void unFocusKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
