import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/controllers/profile_controller.dart';
import 'package:liga_independente_frontend/src/pages/profile_page.dart';

class SelectSportsController {
  late ProfileController profileController;
  
  List<String> sports = [
    'Futebol', 'Volei', "Basquete", "Handebol", "Futsal", "Beach Tenis", 
    'Natação', 'Canoa', 'Corrida', 'Ciclismo'
  ];

  ValueNotifier<List<String>> selectedSports = ValueNotifier<List<String>>([]);
  ValueNotifier<bool> showError = ValueNotifier<bool>(false);

  SelectSportsController(this.profileController) {
    selectedSports.value = profileController.userService.user.sports ?? [];
  }
  
  void toggleSportSelection(String sport) {
    if (selectedSports.value.contains(sport)) {
      selectedSports.value = List.from(selectedSports.value)..remove(sport);
    } else {
      selectedSports.value = List.from(selectedSports.value)..add(sport);
       showError.value = false;
    }
  }

  void saveSports(context) {
    if (selectedSports.value.isEmpty) {
      showError.value = true;
    } else {
      showError.value = false;

      profileController.updateSelectedSports(selectedSports.value);

      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(),));
    }
  }
}
