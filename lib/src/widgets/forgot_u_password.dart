import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/widgets/styled_components/custom_input_text_style.dart';

class ForgotUPassword extends StatelessWidget {
  final Function() onTap;
  const ForgotUPassword({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(top: 15),
        child: const Text(
          "Esqueceu a senha?",
          style: CustomInputTextStyle.inputTextStyle,
        ),
      ),
    );
  }
}
