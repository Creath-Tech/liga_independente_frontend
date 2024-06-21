import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';

Widget customLoading() {
  return Center(
    child: CircularProgressIndicator(
      color: secondarycolor,
    ),
  );
}