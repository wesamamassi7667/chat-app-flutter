
import 'package:flutter/material.dart';

class Utilities {
  static bool isKeyboardShowing() {
    if (WidgetsBinding.instance != null) {
      return WidgetsBinding.instance!.window.viewInsets.bottom > 0;
    } else {
      return false;
    }
  }

  static closeKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
   // If you attempt to unfocus() a node that currently has the primary focus, Flutter will throw an
    print(currentFocus.hasPrimaryFocus);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}