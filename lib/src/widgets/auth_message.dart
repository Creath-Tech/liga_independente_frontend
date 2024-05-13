import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';

class AuthMessage extends StatelessWidget {
  final String text;
  final bool visible;
  final BuildContext context;

  const AuthMessage(
      {super.key,
      required this.text,
      required this.visible,
      required this.context});

  @override
  Widget build(context) {
    return Visibility(
      visible: visible,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: errorboxcolor,
        ),
        alignment: Alignment.center,
        height: 30,
        width: 200,
        child: Text(
          text,
          style: const TextStyle(color: Colors.red, fontSize: 13),
        ),
      ),
    );
  }
}
