import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';
import 'package:liga_independente_frontend/src/controllers/login_controller.dart';
import 'package:liga_independente_frontend/src/pages/register_page.dart';
import 'package:liga_independente_frontend/src/services/auth_service.dart';
import 'package:liga_independente_frontend/src/utils/error_messages.dart';
import 'package:liga_independente_frontend/src/widgets/auth_message.dart';
import 'package:liga_independente_frontend/src/widgets/custom_input.dart';
import 'package:liga_independente_frontend/src/widgets/forgot_u_password.dart';
import 'package:liga_independente_frontend/src/widgets/switch_auth_action.dart';
import 'package:liga_independente_frontend/src/widgets/or_widget.dart';
import 'package:liga_independente_frontend/src/widgets/primary_button.dart';
import 'package:liga_independente_frontend/src/widgets/social_buttons_login_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController =
      LoginController(AuthService(FirebaseAuth.instance));

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
              AuthMessage(text: errorMsg, visible: visible, context: context),
              // text inputs
              CustomInput(
                controller: loginController.loginEC,
                hintText: 'user@example.com',
                labelText: "E-mail",
              ),

              CustomInput(
                controller: loginController.passwordEC,
                labelText: 'Senha',
                obscureText: true,
              ),

              // forgot password
              const ForgotUPassword(),

              // spacing
              const SizedBox(
                height: 50,
              ),

              // login button
              PrimaryButton(
                  text: 'ENTRAR',
                  onPressed: () async {
                    final jsonString = await ErrorMessages().get(context);
                    final errorMessages = jsonDecode(jsonString);
                    if (loginController.loginEC.text.isEmpty ||
                        loginController.passwordEC.text.isEmpty) {
                      setState(() {
                        errorMsg = "PREENCHA OS CAMPOS";
                        visible = true;
                      });
                    } else {
                      loginController.signIn(
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
                text: "Não possui conta?",
                textButton: "Cadastrar",
                onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage(),)),
              ),

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
