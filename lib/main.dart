import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
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

  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 10),
        minimumFetchInterval: Duration(hours: 1),
      ));
  
  await FirebaseRemoteConfig.instance.fetchAndActivate();

  UserService userService = UserService();
  runApp(
    ChangeNotifierProvider(
      create: (context) => userService,
      child: const App()
    ));
}
