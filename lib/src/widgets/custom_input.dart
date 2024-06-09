import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/widgets/styled_components/custom_input_text_style.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String labelText;
  final Color color;

  const CustomInput({
    super.key,
    required this.controller,
    this.hintText = "",
    this.obscureText = false,
    this.labelText = "",
    this.color = const Color(0xFFf4ee35),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: CustomInputTextStyle.inputTextStyle,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            labelStyle: CustomInputTextStyle.inputTextStyle,
            hintStyle: CustomInputTextStyle.inputTextStyle,
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: color, width: 2)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: color, width: 2)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: color, width: 2)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10)),
      ),
    );
  }
}
