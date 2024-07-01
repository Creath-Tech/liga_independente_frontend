import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';
import 'package:liga_independente_frontend/src/controllers/home_controller.dart';
import 'package:liga_independente_frontend/src/pages/profile_page.dart';
import 'package:liga_independente_frontend/src/widgets/home_profile_widget.dart';
import 'package:liga_independente_frontend/src/widgets/recommended_users_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

// Function to open the end drawer
void _openEndDrawer() {
  _scaffoldKey.currentState?.openEndDrawer();
}

class _HomePageState extends State<HomePage> {
  late HomeController homeController;

  @override
  void initState() {
    super.initState();
    homeController = HomeController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                FutureBuilder(
                  future: homeController.imageUrl(),
                  builder: (context, snapshot) {
                    return HomeProfile(
                      filterOnTap: _openEndDrawer,
                      imageUrl: snapshot.hasData
                          ? snapshot.data!
                          : 'https://icons.veryicon.com/png/o/file-type/linear-icon-2/user-132.png',
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          )),
                    );
                  },
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: homeController.authService.getUsers(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      final data = snapshot.requireData;

                      return ValueListenableBuilder(
                        valueListenable: homeController.selectedSports,
                        builder: (context, sports, _) {
                          List filteredUsers = data.docs.where((doc) {
                            if (sports.isEmpty) return true;
                            return doc['sports']
                                .any((sport) => sports.contains(sport));
                          }).toList();

                          return ListView.builder(
                            itemCount: filteredUsers.length,
                            itemBuilder: (context, index) {
                              final doc = filteredUsers[index];
                              return FutureBuilder<String?>(
                                future: homeController.storageService
                                    .getImage(doc.id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (doc.id !=
                                      FirebaseAuth.instance.currentUser!.uid) {
                                    return Column(
                                      children: [
                                        RecommendedUser(
                                          username: "${doc["name"]}",
                                          esportes: doc["sports"],
                                          url: snapshot.hasError ||
                                                  snapshot.data!.isEmpty ||
                                                  !snapshot.hasData
                                              ? 'https://icons.veryicon.com/png/o/file-type/linear-icon-2/user-132.png'
                                              : snapshot.data!,
                                        ),
                                        Divider(
                                          color: boxColor,
                                          thickness: 2,
                                        ),
                                      ],
                                    );
                                  }
                                  return Container();
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      endDrawer: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[900],
        ),
        child: Drawer(
          backgroundColor: Colors.grey[900],
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.filter_alt, color: Colors.white),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Filtrar',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop(); // Fecha o Drawer
                        },
                      ),
                    ],
                  )),
              Expanded(
                child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Container(
                          height: 30,
                          color: Colors.grey[900],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    homeController.updateSports(
                                        homeController.esportes[index]);
                                    if (homeController.icons[index] ==
                                        Icons.circle_outlined) {
                                      homeController.icons[index] =
                                          Icons.circle;
                                    } else {
                                      homeController.icons[index] =
                                          Icons.circle_outlined;
                                    }
                                  });
                                },
                                icon: Icon(
                                  homeController.icons[
                                      index], // Usar o ícone específico para este item
                                  color: Colors.yellow,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                child: Text(
                                  homeController.esportes[index],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ));
                    },
                    separatorBuilder: (context, index) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          child: Divider(
                            color: Colors.grey[800],
                            thickness: 2,
                          ),
                        ),
                    itemCount: homeController.esportes.length),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
