import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;

  const PrimaryButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(text));
  }
}
