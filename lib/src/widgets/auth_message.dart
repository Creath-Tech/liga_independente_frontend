import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';

class AuthMessage extends StatelessWidget {
  final String text;
  final bool visible;
  final Color color;
  final BuildContext context;
  final double height;

  const AuthMessage(
      {super.key,
      required this.text,
      required this.visible,
      required this.context,
      required this.color,
      this.height = 30});

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
        height: height,
        width: double.infinity,
        child: Text(
          text,
          style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
