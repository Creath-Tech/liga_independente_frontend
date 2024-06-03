import 'package:flutter/material.dart';

class NoHaveAccount extends StatelessWidget {
  final String text;
  final String textButton;
  final Function() onPressed;

  const NoHaveAccount({super.key, required this.text, required this.textButton, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
          TextButton(
              onPressed: onPressed,
              child: Text(
                textButton, 
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationThickness: 2,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              )),
        ],
      ),
    );
  }
}
