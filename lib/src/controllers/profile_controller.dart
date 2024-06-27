import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liga_independente_frontend/src/models/user_model.dart';
import 'package:liga_independente_frontend/src/services/auth_service.dart';
import 'package:liga_independente_frontend/src/services/storage_service.dart';
import 'package:liga_independente_frontend/src/services/user_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController {
  final imagePicker = ImagePicker();
  ValueNotifier<File?> imageFile = ValueNotifier(null);

  ValueNotifier<bool> editMode = ValueNotifier(false);
  ValueNotifier<bool> inBioEditMode = ValueNotifier(false);
  ValueNotifier<bool> inContactEditMode = ValueNotifier(false);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  UserService userService = UserService.instance;
  TextEditingController bioEC = TextEditingController();
  TextEditingController whatsappEC = TextEditingController();
  TextEditingController facebookEC = TextEditingController();
  TextEditingController instagramEC = TextEditingController();

  List<TextEditingController> controllers = [];

  FirebaseAuth firebase = FirebaseAuth.instance;
  AuthService authService = AuthService(FirebaseAuth.instance);
  StorageService storageService = StorageService();
  late UserModel? userModel;

  ProfileController() {
    controllers = [bioEC, whatsappEC, facebookEC, instagramEC];
    userModel = userService.user;
    updateImageFile();
  }

  void clearAllEC() {
    for (var controller in controllers) {
      controller.text = '';
    }
  }

  Future<void> updateImageFile() async {
    isLoading.value = true;
    try {
      String? url = await imageUrl();
      if (url != null) {
        File? file = await storageService.downloadImage(url);
        if (file != null) {
          imageFile.value = file;
        }
      }
    } catch (e) {
      imageFile.value = null;
    }
    isLoading.value = false;
  }

  Future<String?> imageUrl() async {
    return await storageService
        .getImage(FirebaseAuth.instance.currentUser!.uid);
  }

  void pick(ImageSource source) async {
    final imagePicked = await imagePicker.pickImage(source: source);

    if (imagePicked != null) {
      imageFile.value = File(imagePicked.path);

      if (userService.user.userId != null) {
        await storageService.uploadImage(
            imagePicked.path, FirebaseAuth.instance.currentUser!.uid);
        userService.user.imageUrl =
            "images/img_${FirebaseAuth.instance.currentUser!.uid}.jpg";
        updateLoggedUser();
      }
    }
  }

  launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  void updateLoggedUser() {
    if (bioEC.text.isNotEmpty) {
      userModel!.bio = bioEC.text;
    }

    Map<String, String> updatedContacts =
        Map.from(userService.user.contacts ?? {});

    if (whatsappEC.text.isNotEmpty) {
      updatedContacts['whatsapp'] = whatsappEC.text;
    }

    if (facebookEC.text.isNotEmpty) {
      updatedContacts['facebook'] = facebookEC.text;
    }

    if (instagramEC.text.isNotEmpty) {
      updatedContacts['instagram'] = instagramEC.text;
    }

    userModel!.contacts = updatedContacts;
    userService.updateUser(userModel);

    if (userModel != null) {
      authService.setUser(userModel!);
    }
    cancelAction();
  }

  void cancelAction() {
    clearAllEC();
    editMode.value = false;
    inBioEditMode.value = false;
    inContactEditMode.value = false;
  }

  bool isValidInstagramUrl(String url) {
    final RegExp regex = RegExp(
      r'^(https?:\/\/)?(www\.)?instagram\.com\/[a-zA-Z0-9(_)?]{1,15}\/?$',
      caseSensitive: false,
    );
    if (url.isNotEmpty) {
      print("INSTAGRAM: ${regex.hasMatch(url)}");
      return regex.hasMatch(url);
    }
    return true;
  }

  bool isValidFacebookUrl(String url) {
    final RegExp regex = RegExp(
      r'^(https?:\/\/)?(www\.)?facebook\.com\/[a-zA-Z0-9._]{1,50}\/?$',
      caseSensitive: false,
    );
    if (url.isNotEmpty) {
      print("FACEBOOK: ${regex.hasMatch(url)}");
      return regex.hasMatch(url);
    }
    print("FACEBOOK: ${regex.hasMatch(url)}");
    return true;
  }

  void abrirWhatsApp(String number) async {
    var whatsappUrl = "whatsapp://send?phone=55$number&text=Olá,tudo bem ?";

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }

  bool urlValidate(String instagramV, String facebookV) {
    if (isValidFacebookUrl(facebookV) && isValidInstagramUrl(instagramV)) {
      return true;
    }
    return false;
  }

  void inEditMode(String mode) {
    if (mode == 'bio') {
      inBioEditMode.value = !inBioEditMode.value;
      bioEC.text = userService.user.bio!;
      editMode.value = !editMode.value;
    } else {
      inContactEditMode.value = !inContactEditMode.value;
      whatsappEC.text = userService.user.contacts?['whatsapp'] ?? "";
      facebookEC.text = userService.user.contacts?['facebook'] ?? "";
      instagramEC.text = userService.user.contacts?['instagram'] ?? "";
      editMode.value = !editMode.value;
    }
  }
}
