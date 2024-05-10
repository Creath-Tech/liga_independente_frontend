import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/controllers/login_controller.dart';
import 'package:liga_independente_frontend/src/services/auth_service.dart';
import 'package:liga_independente_frontend/src/utils/error_messages.dart';
import 'package:liga_independente_frontend/src/widgets/custom_input.dart';
import 'package:liga_independente_frontend/src/widgets/primary_button.dart';
import 'package:liga_independente_frontend/src/widgets/error_message.dart';
import 'package:liga_independente_frontend/src/widgets/sucess_message.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController =
      LoginController(AuthService(FirebaseAuth.instance));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // logo ligaapp
          const Icon(
            Icons.person_4_outlined,
            size: 150,
          ),

          // text inputs
          CustomInput(
              controller: loginController.loginEC,
              hintText: 'Digite seu login'),

          CustomInput(
            controller: loginController.passwordEC,
            hintText: 'Digite sua senha',
            obscureText: true,
          ),

          // forgot password

          // login button
          PrimaryButton(
              text: 'Entrar',
              onPressed: () async {
                final jsonString = await ErrorMessages().get(context);
                final errorMessages = jsonDecode(jsonString);

                loginController.signIn(onSucess: () {
                  SucessMessage.show(context, 'Login efetuado com sucesso!');
                }, onError: (e) {
                  if (errorMessages.containsKey(e.code)) {
                    ErrorMessage.show(context, errorMessages[e.code]);
                  }
                });
              }),
          // no have account ?

          // divider

          // social login buttons
        ],
      ),
    );
  }
}
