import 'package:flutter/material.dart';

class ErrorMessage {
  static void show(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.red,
      ),
    );
  }
}
