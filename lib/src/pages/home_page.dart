import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';
import 'package:liga_independente_frontend/src/widgets/home_profile_widget.dart';
import 'package:liga_independente_frontend/src/widgets/recommended_users_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<IconData> icons = [];
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

// Function to open the end drawer
void _openEndDrawer() {
  _scaffoldKey.currentState?.openEndDrawer();
}

List<String> esportes = [
  'Atletismo',
  'Baseball',
  'Basquete',
  'Beach Tênis',
  'Bocha',
  'Boliche',
  'Boxe',
  'Canoagem',
  'Capoeira',
  'Ciclismo',
  'Corrida',
  'Crossfit',
  'Dama',
  'Dança',
  'Dardos',
  'Dominó',
  'Escalada',
  'Esgrima',
  'Futebol',
  'Futsal',
  'Ginástica',
  'Golfe',
  'Handball',
  'Hipismo',
  'Jiu-Jitsu',
  'Judô',
  'Jump',
  'Karatê',
  'Muay Thai',
  'Natação',
  'Paintball',
  'Pebolin',
  'Pesca',
  'Peteca',
  'Queimada',
  'Rafting',
  'Rodeio',
  'Rugby',
  'Sinuca',
  'Skate',
  'Sumô',
  'Surf',
  'Tênis',
  'Vôlei',
  'Xadrez',
  'Yoga',
  'Zumba'
];

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Inicializar a lista com ícones padrão (por exemplo, ícones não selecionados)
    icons = List.generate(esportes.length, (index) => Icons.circle_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      key: _scaffoldKey,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const HomeProfile(
                filterOnTap: _openEndDrawer,
              ),
              const RecommendedUser(username: "Robert Fox"),
              Divider(
                color: boxColor,
                thickness: 2,
              ),
            ],
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
                                    if (icons[index] == Icons.circle_outlined) {
                                      icons[index] = Icons.circle;
                                    } else {
                                      icons[index] = Icons.circle_outlined;
                                    }
                                  });
                                },
                                icon: Icon(
                                  icons[
                                      index], // Usar o ícone específico para este item
                                  color: Colors.yellow,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                child: Text(
                                  esportes[index],
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
                    itemCount: esportes.length),
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
