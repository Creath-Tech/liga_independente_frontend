import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';
import 'package:liga_independente_frontend/src/widgets/cloud_button.dart';

class RecommendedUser extends StatelessWidget {
  final String username;
  const RecommendedUser({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: const CircleAvatar(
            radius: 25,
          ),
        ),
        title: Container(
          margin: const EdgeInsets.only(bottom: 2),
          child: Text(
            username,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15),
        subtitle: CloudButton(
          color: boxColor,
          child: const Text(
            "Placeholder",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ));
  }
}
