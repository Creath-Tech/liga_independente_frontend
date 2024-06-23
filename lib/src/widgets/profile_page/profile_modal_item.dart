import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';

class ProfileModalItem extends StatelessWidget {
  final String text;
  final Function() onTap;
  final IconData icon;

  const ProfileModalItem({super.key, required this.onTap, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: bottomSheetCircleColor,
            radius: 30,
            child: Icon(icon, color: Colors.white, size: 35,),
            ),
          const SizedBox(height: 10,),
          Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),)
      ],),
    );
  }
}