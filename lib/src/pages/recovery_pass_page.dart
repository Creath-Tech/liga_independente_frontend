import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';
import 'package:liga_independente_frontend/src/controllers/recovery_pass_controller.dart';
import 'package:liga_independente_frontend/src/pages/login_page.dart';
import 'package:liga_independente_frontend/src/services/auth_service.dart';
import 'package:liga_independente_frontend/src/utils/error_messages.dart';
import 'package:liga_independente_frontend/src/widgets/auth_message.dart';
import 'package:liga_independente_frontend/src/widgets/custom_input.dart';
import 'package:liga_independente_frontend/src/widgets/primary_button.dart';

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
  Color color = Colors.red;

  @override
  void dispose() {
    _recoveryPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomInput(
              controller: _recoveryPassController.emailEC,
              hintText: 'email@example.com',
            ),

            //error message
            AuthMessage(
              text: errorMsg,
              visible: visible,
              context: context,
              color: color,
            ),

            ValueListenableBuilder<int>(
              valueListenable: _recoveryPassController.countdownNotifier,
              builder: (context, countdown, child) {
                return PrimaryButton(
                  color: countdown > 0 ? Colors.grey : secondarycolor,
                  text: countdown > 0
                      ? '00:${countdown.toString().padLeft(2, '0')}'
                      : 'ENVIAR',
                  onPressed: countdown > 0
                      ? () {
                          setState(() {
                            color = Colors.green;
                            errorMsg =
                                "Caso exista uma conta com esse e-mail, será enviado um link para redefinir sua senha!";
                            visible = true;
                          });
                        }
                      : () async {
                          final jsonString = await ErrorMessages().get(context);
                          final errorMessages = jsonDecode(jsonString);

                          if (_recoveryPassController.emailEC.text.isEmpty) {
                            setState(() {
                              color = Colors.red;
                              errorMsg = "Prencha o e-mail";
                              visible = true;
                            });
                          } else {
                            _recoveryPassController.recovery(
                                onSucess: () {},
                                onError: (e) {
                                  if (errorMessages.containsKey(e.code)) {
                                    setState(() {
                                      color = Colors.red;
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

            PrimaryButton(
              text: 'Voltar',
              color: Colors.grey,
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
