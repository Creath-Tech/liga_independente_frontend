import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';

class HomeProfile extends StatelessWidget {
  final Function() filterOnTap;
  final Function() onTap;
  final String imageUrl;
  const HomeProfile(
      {super.key,
      required this.filterOnTap,
      required this.onTap,
      this.imageUrl =
          'https://icons.veryicon.com/png/o/file-type/linear-icon-2/user-132.png'});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: errorboxcolor,
      height: MediaQuery.of(context).size.height / 6,
      child: Stack(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onTap,
                child: Container(
                  margin: const EdgeInsets.only(top: 25, left: 20),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: const Center(
              child: Text(
                "Pessoas",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 30,
            child: Row(
              children: [
                GestureDetector(
                  onTap: filterOnTap,
                  child: const Icon(
                    Icons.filter_alt_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 8), // Add some spacing manually if needed
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
