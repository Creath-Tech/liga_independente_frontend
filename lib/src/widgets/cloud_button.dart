import 'package:flutter/material.dart';

class CloudButton extends StatelessWidget {
  final Widget child;
  final Color color;
  const CloudButton({super.key, required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            margin: const EdgeInsets.only(
              right: 10,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18), color: color),
            child: child),
      ],
    );
  }
}
