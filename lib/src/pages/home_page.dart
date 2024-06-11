import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';
import 'package:liga_independente_frontend/src/widgets/home_profile_widget.dart';
import 'package:liga_independente_frontend/src/widgets/recommended_users_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const HomeProfile(),
              const RecommendedUser(username: "Robert Fox"),
              Divider(
                color: boxColor,
                thickness: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
