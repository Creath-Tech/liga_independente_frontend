import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/services/auth_service.dart';
import 'package:liga_independente_frontend/src/widgets/custom_input.dart';
import 'package:liga_independente_frontend/src/widgets/primary_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController loginEC = TextEditingController();
  final TextEditingController passwordEC = TextEditingController();
  final AuthService _authService = AuthService();

  void signIn() async {
    var loginSucess = await _authService.signIn(loginEC.text, passwordEC.text);

    print('LOGIN EFETUADO COM SUCESSO : ${loginSucess}');
  }

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
          CustomInput(controller: loginEC, hintText: 'Digite seu login'),

          CustomInput(
            controller: passwordEC,
            hintText: 'Digite sua senha',
            obscureText: true,
          ),

          // forgot password

          // login button
          PrimaryButton(
            text: 'Entrar',
            onPressed: signIn,
          ),
          // no have account ?

          // divider

          // social login buttons
        ],
      ),
    );
  }
}
