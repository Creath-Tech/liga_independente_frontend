import 'package:flutter/material.dart';

class ErrorMessages {
  Future<String> get(BuildContext context) async {
    final jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/error_messages.json');

    return jsonString;
  }
}
