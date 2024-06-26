import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/services/auth_service.dart';
import 'package:liga_independente_frontend/src/services/storage_service.dart';

class HomeController {
  AuthService authService = AuthService(FirebaseAuth.instance);
  StorageService storageService = StorageService();
  List<IconData> icons = [];
  ValueNotifier<List<String>> selectedSports = ValueNotifier<List<String>>([]);

  void updateSports(String sport) {
    if (selectedSports.value.contains(sport)) {
      selectedSports.value = List.from(selectedSports.value)..remove(sport);
    } else {
      selectedSports.value = List.from(selectedSports.value)..add(sport);
    }
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

  HomeController() {
    setIcons();
  }

  void setIcons() {
    icons = List.generate(esportes.length, (index) => Icons.circle_outlined);
  }
}
