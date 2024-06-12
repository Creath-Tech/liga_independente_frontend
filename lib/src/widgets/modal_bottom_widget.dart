import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';

class ModalBottomWidget {
  static void show(BuildContext context, Widget child){
    showModalBottomSheet(
      context: context, 
      backgroundColor: bottomSheetColor,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 20),
          height: 200,
          child: child,
        );
    },);
  }
}