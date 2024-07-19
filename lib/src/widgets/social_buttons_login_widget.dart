import 'package:flutter/material.dart';

class SocialButtonsLoginWidget extends StatelessWidget {
  final Function() onTap;
  final String social;
  const SocialButtonsLoginWidget(
      {super.key, required this.onTap, required this.social});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset('assets/$social.png', height: 56),
    );
  }
}
