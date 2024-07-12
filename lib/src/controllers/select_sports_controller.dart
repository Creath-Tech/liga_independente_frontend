import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:liga_independente_frontend/src/models/user_model.dart';
import 'package:liga_independente_frontend/src/pages/profile_page.dart';
import 'package:liga_independente_frontend/src/services/auth_service.dart';
import 'package:liga_independente_frontend/src/services/remote_config_service.dart';
import 'package:liga_independente_frontend/src/services/user_service.dart';
import 'package:flutter/material.dart';

class SelectSportsController {
  final UserService userService = UserService.instance;
  late UserModel? userModel;
  final AuthService authService = AuthService(FirebaseAuth.instance);
  final RemoteConfigService remoteConfig = RemoteConfigService();

  ValueNotifier<List<String>> sports = ValueNotifier<List<String>>([]);
  ValueNotifier<List<String>> selectedSports = ValueNotifier<List<String>>([]);
  ValueNotifier<bool> showError = ValueNotifier<bool>(false);

  SelectSportsController() {
    userModel = userService.user;
    selectedSports.value = userModel?.sports ?? [];
  }

  Future<void> loadSports() async {
    try {
      final sportsJson = await remoteConfig.getSports();
      sports.value = _parseSportsFromJson(sportsJson);
    } catch (e) {
      print('Erro ao carregar os esportes: $e');
      sports.value = [];
    }
  }

  List<String> _parseSportsFromJson(String sportsJson) {
    final Map<String, dynamic> decodedJson = json.decode(sportsJson);
    return List<String>.from(decodedJson['list_sports'] ?? []);
  }

  void toggleSportSelection(String sport) {
    if (selectedSports.value.contains(sport)) {
      selectedSports.value = List.from(selectedSports.value)..remove(sport);
    } else {
      selectedSports.value = List.from(selectedSports.value)..add(sport);
      showError.value = false;
    }
  }

  void saveSports(BuildContext context) {
    if (selectedSports.value.isEmpty) {
      showError.value = true;
    } else {
      showError.value = false;
      updateSelectedSports(selectedSports.value);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(),
        ),
      );
    }
  }

  void updateSelectedSports(List<String> selectedSports) {
    if (userModel != null) {
      userModel!.sports = selectedSports;
      userService.updateUser(userModel);
      authService.setUser(userModel!);
    }
  }
}
