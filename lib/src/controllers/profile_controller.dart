import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liga_independente_frontend/src/models/user_model.dart';
import 'package:liga_independente_frontend/src/services/auth_service.dart';
import 'package:liga_independente_frontend/src/services/storage_service.dart';
import 'package:liga_independente_frontend/src/services/user_service.dart';

class ProfileController {
  final imagePicker = ImagePicker();
  ValueNotifier<File?> imageFile = ValueNotifier(null);

  ValueNotifier<bool> editMode = ValueNotifier(false);
  ValueNotifier<bool> inBioEditMode = ValueNotifier(false);
  ValueNotifier<bool> inContactEditMode = ValueNotifier(false);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  UserService userService;
  TextEditingController bioEC = TextEditingController();
  TextEditingController whatsappEC = TextEditingController();
  TextEditingController facebookEC = TextEditingController();
  TextEditingController instagramEC = TextEditingController();

  List<TextEditingController> controllers = [];

  late UserModel? userModel;
  FirebaseAuth firebase = FirebaseAuth.instance;
  AuthService authService = AuthService(FirebaseAuth.instance);
  StorageService storageService = StorageService();

  ProfileController(this.userService){
    controllers = [bioEC, whatsappEC, facebookEC, instagramEC];
    updateUser();
  }

  void updateUser() async {
    isLoading.value = true;
    userModel = await authService.getUser(FirebaseAuth.instance.currentUser!.uid);
    if (userModel != null) {
      userService.updateUser(userModel);
      await updateImageFile();
    }
    isLoading.value = false;
  }

  void clearAllEC(){
    for(var controller in controllers) {
      controller.text = '';
    }
  }

  Future<void> updateImageFile() async {
    String url = await imageUrl();
    File file = await storageService.downloadImage(url);
    imageFile.value = file;
  }

  Future<String> imageUrl() {
    return storageService.getImage(FirebaseAuth.instance.currentUser!.uid);
  }

  void pick(ImageSource source) async {
    final imagePicked = await imagePicker.pickImage(source: source);

    if(imagePicked != null) {
      imageFile.value = File(imagePicked.path);

      if(userService.user.userId != null) {
        await storageService.uploadImage(imagePicked.path, FirebaseAuth.instance.currentUser!.uid);
        userService.user.imageUrl = "images/img_${FirebaseAuth.instance.currentUser!.uid}.jpg";
        updateLoggedUser();
      }
      
    }
  }

  void updateLoggedUser() {

    if (bioEC.text.isNotEmpty) {
      userModel!.bio = bioEC.text;
    }

    Map<String, String> updatedContacts = Map.from(userService.user.contacts ?? {});

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

    if(userModel != null) { authService.setUser(userModel!); }
    cancelAction();
  }

  void cancelAction(){
    clearAllEC();
    editMode.value = false;
    inBioEditMode.value = false;
    inContactEditMode.value = false;
  }

  void inEditMode(String mode){

    if(mode == 'bio') {
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