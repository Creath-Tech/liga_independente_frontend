import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/pages/login_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Inter'),
        home: const LoginPage(),
      ),
    );
  }
}
