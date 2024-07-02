import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/pages/login_page.dart';
import 'package:liga_independente_frontend/src/pages/register_page.dart';

class ManagerPages extends StatefulWidget {
  const ManagerPages({super.key});

  @override
  State<ManagerPages> createState() => _ManagerPagesState();
}

class _ManagerPagesState extends State<ManagerPages> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoginPage
        ? LoginPage(onTap: togglePages)
        : RegisterPage(onTap: togglePages);
  }
}