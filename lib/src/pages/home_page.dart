import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';
import 'package:liga_independente_frontend/src/controllers/home_controller.dart';
import 'package:liga_independente_frontend/src/pages/profile_page.dart';
import 'package:liga_independente_frontend/src/widgets/custom_loading.dart';
import 'package:liga_independente_frontend/src/widgets/home_profile_widget.dart';
import 'package:liga_independente_frontend/src/widgets/recommended_users_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  double distance = 20;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    homeController = HomeController();
    _initializeController();
  }

  Future<void> _initializeController() async {
    await homeController.loadSports();
    setState(() {
      isLoading = false;
    });
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
                FutureBuilder<String?>(
                  future: homeController.imageUrl(),
                  builder: (context, snapshot) {
                    return HomeProfile(
                      filterOnTap: _openEndDrawer,
                      imageUrl: snapshot.hasError ||
                              snapshot.data == null ||
                              snapshot.data!.isEmpty
                          ? 'https://icons.veryicon.com/png/o/file-type/linear-icon-2/user-132.png'
                          : snapshot.data!,
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ),
                        );
                      },
                      settingsOnTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return Container(
                                  padding: const EdgeInsets.all(16.0),
                                  color: bottomSheetColor,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Ajuste a distância',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                          Text("${distance}km",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18))
                                        ],
                                      ),
                                      Slider(
                                        value: distance,
                                        activeColor: secondarycolor,
                                        onChanged: (newValue) {
                                          setState(() {
                                            distance = newValue;
                                            homeController.radius.value =
                                                newValue;
                                            homeController
                                                .getUsersWithinRadius();
                                          });
                                        },
                                        min: 0,
                                        max: 100,
                                        divisions: 10,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                Expanded(
                  child: isLoading
                      ? Center(child: customLoading())
                      : FutureBuilder<List<DocumentSnapshot>>(
                          future: homeController.getUsersWithinRadius(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: customLoading());
                            }

                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(
                                child: Text(
                                  'Nenhum usuário encontrado em uma distância de 20 km',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }

                            final data = snapshot.data!;

                            return ValueListenableBuilder<List<String>>(
                              valueListenable: homeController.selectedSports,
                              builder: (context, sports, _) {
                                List<DocumentSnapshot> filteredUsers =
                                    data.where((doc) {
                                  var userData =
                                      doc.data() as Map<String, dynamic>;
                                  if (sports.isEmpty) return true;
                                  return (userData['sports'] as List)
                                      .any((sport) => sports.contains(sport));
                                }).toList();

                                return ListView.builder(
                                  itemCount: filteredUsers.length,
                                  itemBuilder: (context, index) {
                                    final doc = filteredUsers[index];
                                    var userData =
                                        doc.data() as Map<String, dynamic>;
                                    final image = homeController.storageService
                                        .getImage(userData['userId']);
                                    return FutureBuilder<String?>(
                                      future: image,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(child: Container());
                                        } else if (userData['userId'] !=
                                            FirebaseAuth.instance.currentUser!
                                                .uid) {
                                          return Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProfilePage(
                                                              user: doc),
                                                    ),
                                                  );
                                                },
                                                child: RecommendedUser(
                                                  username: userData["name"]
                                                      as String,
                                                  esportes: userData["sports"]
                                                      as List,
                                                  url: snapshot.hasError ||
                                                          snapshot.data ==
                                                              null ||
                                                          snapshot.data!
                                                              .isEmpty
                                                      ? 'https://icons.veryicon.com/png/o/file-type/linear-icon-2/user-132.png'
                                                      : snapshot.data!,
                                                ),
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
                child: homeController.esportes.isEmpty
                    ? Center(
                        child: Text(
                          'Nenhum esporte encontrado',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          if (index >= homeController.esportes.length) {
                            return Container(); // Retorna um container vazio se o índice estiver fora do alcance
                          }
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
                                        if (index < homeController.icons.length &&
                                            homeController.icons[index] ==
                                                Icons.circle_outlined) {
                                          homeController.icons[index] =
                                              Icons.circle;
                                        } else if (index <
                                                homeController.icons.length &&
                                            homeController.icons[index] ==
                                                Icons.circle) {
                                          homeController.icons[index] =
                                              Icons.circle_outlined;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      index < homeController.icons.length
                                          ? homeController.icons[index]
                                          : Icons.circle_outlined,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      homeController.esportes[index],
                                      style:
                                          const TextStyle(color: Colors.white),
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
