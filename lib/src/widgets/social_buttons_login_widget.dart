import 'package:flutter/material.dart';

class SocialButtonsLoginWidget extends StatelessWidget {
  const SocialButtonsLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          'assets/google.png',
          height: 56,
        ),
        Image.asset(
          'assets/facebook.png',
          height: 56,
        ),
        Image.asset(
          'assets/apple.png',
          height: 56,
        )
      ],
    );
  }
}
