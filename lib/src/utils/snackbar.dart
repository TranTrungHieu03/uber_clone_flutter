import 'package:flutter/material.dart';
import 'package:uber_clone/src/utils/colors.dart' as utils;

class SnackBarCustom {
  static void showSnackBar(BuildContext context,
      GlobalKey<ScaffoldMessengerState> key, String text) {
    if (key.currentState == null) return;
    FocusScope.of(context).requestFocus(FocusNode());
    key.currentState?.clearSnackBars();
    key.currentState?.showSnackBar(SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      backgroundColor: utils.Colors.uberColor,
      duration: const Duration(seconds: 3),
    ));
  }
}
