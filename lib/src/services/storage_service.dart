import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;


  Future<void> uploadImage(String path, String uid) async {

    File file = File(path);
    String ref = 'images/img_$uid.jpg';

    try {

      await storage.ref(ref).putFile(file);

    } on FirebaseException catch(e) {

      throw Exception('Ocorreu algum erro ao fazer upload da imagem: ${e.code}');
      
    }
  }

  Future<String?> getImage(String uid) async {
    String ref = 'images/img_$uid.jpg';
    
    try {
      String downloadURL = await storage.ref(ref).getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      if (e.code == 'object-not-found') {
        return '';
      } else {
        throw Exception('Ocorreu algum erro ao pegar a URL da imagem: ${e.code}');
      }
    }
  }

  Future<File?> downloadImage(String url) async {
    try {
      final http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Directory tempDir = await getTemporaryDirectory();
        final String tempPath = '${tempDir.path}/${DateTime.now()}.jpg';
        final File file = File(tempPath);
        await file.writeAsBytes(response.bodyBytes);
        return file;
      } else {
        throw Exception('Erro ao baixar a imagem: ${response.statusCode}');
      }
    } catch (e) {
      return null;
    }
  }

}