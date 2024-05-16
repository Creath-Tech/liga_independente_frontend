import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/services/auth_service.dart';

class RecoveryPassController {
  final TextEditingController emailEC = TextEditingController();
  final AuthService _authService;
  final ValueNotifier<int> countdownNotifier = ValueNotifier<int>(0);
  Timer? _timer;

  RecoveryPassController(this._authService);

  Future<void> recovery(
      {required void Function(FirebaseAuthException e) onError,
      required void Function() onSucess}) async {
    try {
      final result = await _authService.recoveryPassword(emailEC.text);
      result.fold((e) {
        onError.call(e);
      }, (sucess) {
        onSucess.call();
        startTimer();
      });
    } catch (e) {
      rethrow;
    }
  }

  void startTimer() {
    countdownNotifier.value = 59;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdownNotifier.value > 0) {
        countdownNotifier.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void dispose() {
    _timer?.cancel();
    emailEC.dispose();
    countdownNotifier.dispose();
  }
}
