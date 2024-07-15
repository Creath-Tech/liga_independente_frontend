import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/models/user_model.dart';
import 'package:liga_independente_frontend/src/services/auth_service.dart';

class UserService extends ChangeNotifier {
  static late UserService instance;
  late UserModel _userModel;
  late AuthService authService;

  UserModel get user => _userModel;

  UserService() {
    _userModel = UserModel();
    instance = this;
    authService = AuthService(FirebaseAuth.instance);
    loadUserData();
  }

  void updateUser(userModel){
    _userModel = userModel;
    notifyListeners();
  }

  void loadUserData() async{
    if (FirebaseAuth.instance.currentUser != null) {
      UserModel? userModel = await authService.getUser(FirebaseAuth.instance.currentUser!.uid);
      updateUser(userModel);
    }
  }
  
}