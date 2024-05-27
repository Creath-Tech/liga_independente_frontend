import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/widgets/styled_components/custom_input_text_style.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: Colors.white,
            thickness: 0.6,
          ),
        ),
        SizedBox(width: 10),
        Text(
          'OU',
          style: CustomInputTextStyle.inputTextStyle,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Divider(
            color: Colors.white,
            thickness: 0.6,
            height: 10,
          ),
        )
      ],
    );
  }
}
