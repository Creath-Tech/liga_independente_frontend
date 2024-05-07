import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/services/auth_service.dart';

class LoginController {
  final TextEditingController loginEC = TextEditingController();
  final TextEditingController passwordEC = TextEditingController();
  final AuthService _authService = AuthService();

  void signIn() async {
    var loginSucess = await _authService.signIn(loginEC.text, passwordEC.text);

    print('LOGIN EFETUADO COM SUCESSO : ${loginSucess}');
  }
}
