import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/firebase_options.dart';
import 'package:liga_independente_frontend/src/services/user_service.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserService(),
      child: const App()
    ));
}
