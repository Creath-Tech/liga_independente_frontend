import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';
import 'package:liga_independente_frontend/src/utils/phone_input_formatter.dart';
import 'package:liga_independente_frontend/src/widgets/styled_components/custom_input_text_style.dart';

class RoundedTextInput extends StatelessWidget {
  final String icon;
  final TextEditingController controller;
  const RoundedTextInput({super.key, required this.icon, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: boxColorHeader,
        borderRadius: BorderRadius.circular(30)
      ),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset(
          'assets/icons/icon_$icon.png',
          height: 25,
          ),

          Expanded(
            child: TextField(
              inputFormatters: icon == 'whatsapp' ? [PhoneInputFormatter()] : [],
              keyboardType: icon == 'whatsapp' ? TextInputType.number : TextInputType.url,
              controller: controller,
              cursorColor: Colors.white,
               style: CustomInputTextStyle.bioInputTextStyle,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 5),
              hintStyle: const TextStyle(color: Colors.white60, fontSize: 14, fontWeight: FontWeight.w400),
              hintText: icon == 'whatsapp' ? '(xx) x xxxx-xxxx' : 'Insira a url do seu perfil',
              border: const OutlineInputBorder(
                borderSide: BorderSide.none
              ),
            ),
                    ),
          ),
      ],)
    );
  }
}