import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/services/auth_service.dart';

class LoginController {
  final TextEditingController loginEC = TextEditingController();
  final TextEditingController passwordEC = TextEditingController();
  final AuthService _authService;

  LoginController(this._authService);

  Future<void> signIn(
      {required void Function(FirebaseAuthException e) onError,
      required void Function() onSucess}) async {
    try {
      final result = await _authService.signIn(loginEC.text, passwordEC.text);
      result.fold((e) {
        onError.call(e);
      }, (sucess) {
        onSucess.call();
      });
    } catch (e) {
      rethrow;
    }
  }
}
