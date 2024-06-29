import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/pages/home_page.dart';
import 'package:liga_independente_frontend/src/pages/manager_pages.dart';

class AuthGateService extends StatelessWidget {
  const AuthGateService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot) {
          return snapshot.hasData ? const HomePage() : const ManagerPages();
        },),
    );
  }
}