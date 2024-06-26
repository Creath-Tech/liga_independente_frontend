import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';
import 'package:liga_independente_frontend/src/widgets/cloud_button.dart';

class RecommendedUser extends StatelessWidget {
  final String username;
  final List esportes;
  final String url;
  const RecommendedUser(
      {super.key,
      required this.username,
      required this.esportes,
      this.url =
          "https://icons.veryicon.com/png/o/file-type/linear-icon-2/user-132.png"});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(url),
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
      subtitle: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: esportes.map((esporte) {
            return CloudButton(
              color: boxColor,
              child: Text(
                esporte,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
