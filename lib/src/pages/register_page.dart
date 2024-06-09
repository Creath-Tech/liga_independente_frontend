import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';
import 'package:liga_independente_frontend/src/controllers/register_controller.dart';
import 'package:liga_independente_frontend/src/pages/login_page.dart';
import 'package:liga_independente_frontend/src/services/auth_service.dart';
import 'package:liga_independente_frontend/src/utils/error_messages.dart';
import 'package:liga_independente_frontend/src/widgets/auth_message.dart';
import 'package:liga_independente_frontend/src/widgets/custom_input.dart';
import 'package:liga_independente_frontend/src/widgets/switch_auth_action.dart';
import 'package:liga_independente_frontend/src/widgets/or_widget.dart';
import 'package:liga_independente_frontend/src/widgets/primary_button.dart';
import 'package:liga_independente_frontend/src/widgets/social_buttons_login_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController registerController =
      RegisterController(AuthService(FirebaseAuth.instance));

  bool visible = false;
  String errorMsg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 43),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // spacing
              const SizedBox(
                width: double.infinity,
                height: 50,
              ),
              // logo ligaapp
              Image.asset(
                'assets/logo.png',
                height: 160,
              ),

              //error message
              AuthMessage(
                text: errorMsg, 
                visible: visible,
                color: errorColor,
                context: context),
              // text inputs

              CustomInput(
                controller: registerController.nameEC,
                labelText: 'Nome',
              ),

              CustomInput(
                controller: registerController.loginEC,
                hintText: 'user@example.com',
                labelText: "E-mail",
              ),

              CustomInput(
                controller: registerController.passwordEC,
                labelText: 'Senha',
                obscureText: true,
              ),

              CustomInput(
                controller: registerController.confirmPasswordEC,
                labelText: 'Confirme sua senha',
                obscureText: true,
              ),

              // spacing
              const SizedBox(
                height: 50,
              ),

              // login button
              PrimaryButton(
                  color: secondarycolor,
                  text: 'CADASTRAR',
                  onPressed: () async {
                    final jsonString = await ErrorMessages().get(context);
                    final errorMessages = jsonDecode(jsonString);
                    if (registerController.loginEC.text.isEmpty ||
                        registerController.passwordEC.text.isEmpty) {
                      setState(() {
                        errorMsg = "PREENCHA OS CAMPOS";
                        visible = true;
                      });
                    } else if (registerController.passwordEC.text !=
                        registerController.confirmPasswordEC.text) {
                      setState(() {
                        errorMsg = "SENHAS NÃO CONFEREM";
                        visible = true;
                      });
                    } else {
                      registerController.signUp(
                          onSucess: () {},
                          onError: (e) {
                            if (errorMessages.containsKey(e.code)) {
                              setState(() {
                                errorMsg = errorMessages[e.code];
                                visible = true;
                              });
                            }
                          });
                    }
                  }),
              // no have account ?
              SwitchAuthAction(
                  text: "Já possui conta?",
                  textButton: "Entrar",
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ))),

              // divider
              const OrWidget(),

              //spacing
              const SizedBox(
                height: 20,
              ),
              // social login buttons
              const SocialButtonsLoginWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
