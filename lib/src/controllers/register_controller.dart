import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/services/auth_service.dart';

class RegisterController {
  final TextEditingController loginEC = TextEditingController();
  final TextEditingController nameEC = TextEditingController();
  final TextEditingController passwordEC = TextEditingController();
  final TextEditingController confirmPasswordEC = TextEditingController();
  final AuthService _authService;

  RegisterController(this._authService);

  Future<void> signUp(
      {required void Function(FirebaseAuthException e) onError,
      required void Function() onSucess}) async {
    try {
      final result =
          await _authService.signUp(loginEC.text, passwordEC.text, nameEC.text);
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
