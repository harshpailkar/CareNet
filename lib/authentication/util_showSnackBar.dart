import 'package:flutter/material.dart';

import '../Theming/customColors.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String text, Color color) {
    if (text == null) return;
    final snackBar = SnackBar(
      content: Text(
        text,
        style: TextStyle(fontFamily: 'Circular'),
      ),
      backgroundColor: color,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
