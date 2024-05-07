import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/controllers/login_controller.dart';
import 'package:liga_independente_frontend/src/widgets/custom_input.dart';
import 'package:liga_independente_frontend/src/widgets/primary_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = LoginController();
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
            onPressed: loginController.signIn,
          ),
          // no have account ?

          // divider

          // social login buttons
        ],
      ),
    );
  }
}
