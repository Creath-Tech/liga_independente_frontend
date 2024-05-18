import 'package:flutter/material.dart';

class SecondaryButton extends StatefulWidget {
  final Function() onPressed;
  final Color color;
  final String text;

  const SecondaryButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.color});

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: widget.onPressed,
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.transparent,
            side: BorderSide(color: widget.color),
            padding: const EdgeInsets.symmetric(vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        child: Text(
          widget.text,
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
