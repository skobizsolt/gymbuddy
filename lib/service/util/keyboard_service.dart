import 'package:flutter/material.dart';

class KeyboardService {
  void unFocusKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
