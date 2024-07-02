import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';
import 'package:liga_independente_frontend/src/controllers/recovery_pass_controller.dart';
import 'package:liga_independente_frontend/src/pages/manager_pages.dart';
import 'package:liga_independente_frontend/src/services/auth_service.dart';
import 'package:liga_independente_frontend/src/utils/error_messages.dart';
import 'package:liga_independente_frontend/src/widgets/auth_message.dart';
import 'package:liga_independente_frontend/src/widgets/custom_input.dart';
import 'package:liga_independente_frontend/src/widgets/primary_button.dart';
import 'package:liga_independente_frontend/src/widgets/secondary_button.dart';

class RecoveryPassPage extends StatefulWidget {
  const RecoveryPassPage({super.key});

  @override
  State<RecoveryPassPage> createState() => _RecoveryPassPageState();
}

class _RecoveryPassPageState extends State<RecoveryPassPage> {
  final RecoveryPassController _recoveryPassController =
      RecoveryPassController(AuthService(FirebaseAuth.instance));

  bool visible = false;
  String errorMsg = "";
  Color color = errorColor;
  Color inputColor = const Color(0xFFf4ee35);
  @override
  void dispose() {
    _recoveryPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 50),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),

              // logo ligaapp
              Image.asset(
                'assets/logo.png',
                height: 160,
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  "Para iniciar o processo de redefinição de senha, insira seu endereço de e-mail.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              //input
              CustomInput(
                controller: _recoveryPassController.emailEC,
                hintText: 'email@example.com',
                color: inputColor,
              ),
              const SizedBox(
                height: 20,
              ),
              //error message
              AuthMessage(
                text: errorMsg,
                visible: visible,
                context: context,
                color: color,
              ),

              //Substituct
              Visibility(
                  visible: !visible,
                  child: const SizedBox(
                    height: 30,
                  )),

              const SizedBox(
                height: 180,
              ),

              //Enviar
              ValueListenableBuilder<int>(
                valueListenable: _recoveryPassController.countdownNotifier,
                builder: (context, countdown, child) {
                  return PrimaryButton(
                    color: countdown > 0 ? disableColor : secondarycolor,
                    text: countdown > 0
                        ? '00:${countdown.toString().padLeft(2, '0')}'
                        : 'ENVIAR',
                    onPressed: countdown > 0 ? () {} : () async {
                      final jsonString = await ErrorMessages().get(context);
                      final errorMessages = jsonDecode(jsonString);

                      if (_recoveryPassController.emailEC.text.isEmpty) {
                        setState(() {
                          color = errorColor;
                          inputColor = errorColor;
                          errorMsg = "INSIRA UM ENDEREÇO DE E-MAIL";
                          visible = true;
                        });
                      } else {
                        _recoveryPassController.recovery(onSucess: () {
                          setState(() {
                            color = sucessColor;
                            inputColor = sucessColor;
                            errorMsg = "E-MAIL ENVIADO";
                            visible = true;
                          });
                        }, onError: (e) {
                          if (errorMessages.containsKey(e.code)) {
                            setState(() {
                              color = errorColor;
                              inputColor = errorColor;
                              errorMsg = errorMessages[e.code];
                              visible = true;
                            });
                          }
                        });
                      }
                    },
                  );
                },
              ),

              const SizedBox(
                height: 10,
              ),

              //Voltar
              SecondaryButton(
                text: 'VOLTAR',
                color: secondarycolor,
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ManagerPages(),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
