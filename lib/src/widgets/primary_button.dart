import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onPressed;
  final Color color;
  final String text;

  const PrimaryButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
