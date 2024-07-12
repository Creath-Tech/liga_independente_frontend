import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';
import 'package:liga_independente_frontend/src/controllers/select_sports_controller.dart';
import 'package:liga_independente_frontend/src/widgets/auth_message.dart';
import 'package:liga_independente_frontend/src/widgets/cloud_button.dart';
import 'package:liga_independente_frontend/src/widgets/primary_button.dart';

class SelectSports extends StatefulWidget {
  const SelectSports({super.key});

  @override
  _SelectSportsState createState() => _SelectSportsState();
}

class _SelectSportsState extends State<SelectSports> {
  late SelectSportsController selectSportsController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    selectSportsController = SelectSportsController();
    _initializeController();
  }

  Future<void> _initializeController() async {
    await selectSportsController.loadSports();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Quais esportes você prática?",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ValueListenableBuilder<bool>(
                  valueListenable: selectSportsController.showError,
                  builder: (context, showError, child) {
                    return AuthMessage(
                      text: "Por favor, selecione pelo menos um esporte.",
                      visible: showError,
                      context: context,
                      color: Colors.red,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.55,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ValueListenableBuilder<List<String>>(
                        valueListenable: selectSportsController.sports,
                        builder: (context, sports, child) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 5,
                              childAspectRatio: 3,
                            ),
                            itemCount: sports.length,
                            itemBuilder: (context, index) {
                              String sport = sports[index];
                              return ValueListenableBuilder<List<String>>(
                                valueListenable: selectSportsController.selectedSports,
                                builder: (context, selectedSports, child) {
                                  bool isSelected = selectedSports.contains(sport);
                                  return GestureDetector(
                                    onTap: () => selectSportsController.toggleSportSelection(sport),
                                    child: CloudButton(
                                      color: isSelected ? secondarycolor : boxColorHeader,
                                      child: Text(sport,
                                          style: TextStyle(
                                              color: isSelected ? Colors.black : Colors.white)),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: ValueListenableBuilder(
                  valueListenable: selectSportsController.showError,
                  builder: (context, showError, child) {
                    return PrimaryButton(
                        onPressed: showError
                            ? () {}
                            : () => selectSportsController.saveSports(context),
                        text: "CONTINUAR",
                        color: showError ? disableColor : secondarycolor);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
