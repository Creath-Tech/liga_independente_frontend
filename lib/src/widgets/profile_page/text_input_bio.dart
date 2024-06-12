import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';
import 'package:liga_independente_frontend/src/widgets/styled_components/custom_input_text_style.dart';

class TextInputBio extends StatelessWidget {
  final TextEditingController controller;
  const TextInputBio({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: CustomInputTextStyle.bioInputTextStyle,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: 'Descreva um pouco sobre você.',
        hintStyle: const TextStyle(color: Colors.white38),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(3)
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: secondarycolor, width: 1),
          borderRadius: BorderRadius.circular(3)
          )
        ),
    );
  }
}