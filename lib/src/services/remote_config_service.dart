import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigService() : _remoteConfig = FirebaseRemoteConfig.instance;

  Future<String> getSports() async {
    try {
      return _remoteConfig.getString("ligaapp_configs");
    } catch (e) {
      print("Erro ao obter os esportes: $e");
      return "{}"; 
    }
  }
}
