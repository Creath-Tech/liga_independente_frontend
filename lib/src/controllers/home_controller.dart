import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/services/auth_service.dart';
import 'package:liga_independente_frontend/src/services/location_service.dart';
import 'package:liga_independente_frontend/src/services/remote_config_service.dart';
import 'package:liga_independente_frontend/src/services/storage_service.dart';

class HomeController {
  AuthService authService = AuthService(FirebaseAuth.instance);
  StorageService storageService = StorageService();
  List<IconData> icons = [];
  ValueNotifier<List<String>> selectedSports = ValueNotifier<List<String>>([]);
  ValueNotifier<double> radius = ValueNotifier<double>(20);

  final LocationService locationService = LocationService();
  final RemoteConfigService remoteConfig = RemoteConfigService();

  Future<List<DocumentSnapshot>> getUsersWithinRadius() async {
    return await locationService.getUsersWithinRadius(radius.value);
  }

  Future<DocumentSnapshot> getCurrentUserDoc() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  void updateSports(String sport) {
    if (selectedSports.value.contains(sport)) {
      selectedSports.value = List.from(selectedSports.value)..remove(sport);
    } else {
      selectedSports.value = List.from(selectedSports.value)..add(sport);
    }
  }

  Future<String?> imageUrl() async {
    return await storageService
        .getImage(FirebaseAuth.instance.currentUser!.uid);
  }

  List<String> esportes = [];

   Future<void> loadSports() async {
    try {
      final sportsJson = await remoteConfig.getSports();
      esportes = _parseSportsFromJson(sportsJson);
    } catch (e) {
      print('Erro ao carregar os esportes: $e');
      esportes = [];
    }
  }

  List<String> _parseSportsFromJson(String sportsJson) {
    final Map<String, dynamic> decodedJson = json.decode(sportsJson);
    return List<String>.from(decodedJson['list_sports'] ?? []);
  }

  HomeController() {
    setIcons();
  }

  void setIcons() {
    icons = List.generate(esportes.length, (index) => Icons.circle_outlined);
  }
}
