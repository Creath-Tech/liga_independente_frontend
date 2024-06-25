import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/models/user_model.dart';
import 'package:liga_independente_frontend/src/pages/profile_page.dart';
import 'package:liga_independente_frontend/src/services/auth_service.dart';
import 'package:liga_independente_frontend/src/services/user_service.dart';

class SelectSportsController {
  UserService userService = UserService.instance;
  late UserModel? userModel;
  final AuthService authService = AuthService(FirebaseAuth.instance);
  
  List<String> sports = [
    'Futebol', 'Volei', "Basquete", "Handebol", "Futsal", "Beach Tenis", 
    'Natação', 'Canoa', 'Corrida', 'Ciclismo'
  ];

  ValueNotifier<List<String>> selectedSports = ValueNotifier<List<String>>([]);
  ValueNotifier<bool> showError = ValueNotifier<bool>(false);

  SelectSportsController() {
    selectedSports.value = userService.user.sports ?? [];
    userModel = userService.user;
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

      updateSelectedSports(selectedSports.value);

      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(),));
    }
  }

    void updateSelectedSports(List<String> selectedSports) {
    if (userModel != null) {
      userModel!.sports = selectedSports;
      userService.updateUser(userModel);
      print('user model ${userModel!.userId}');
      authService.setUser(userModel!);
    } 
  }
}
