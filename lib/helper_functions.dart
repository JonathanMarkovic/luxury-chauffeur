import 'package:flutter/material.dart';

class HelperFunctions {
  static void showSnackBar(BuildContext context, String message, {Duration? duration}) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) {
      // print to see if it fails
      print("No ScaffoldMessenger in context: $message");
      return;
    }
    messenger.showSnackBar(
      SnackBar(content: Text(message), duration: duration ?? Duration(seconds: 3)),
    );
  }
}
