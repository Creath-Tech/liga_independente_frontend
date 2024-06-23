import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/models/user_model.dart';

class UserService extends ChangeNotifier {
  late UserModel _userModel;

  UserModel get user => _userModel;

  UserService() {
    _userModel = UserModel();
  }

  void updateUser(userModel){
    _userModel = userModel;
    notifyListeners();
  }
  
}