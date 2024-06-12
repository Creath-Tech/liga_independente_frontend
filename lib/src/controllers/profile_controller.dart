import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liga_independente_frontend/src/models/user_model.dart';
import 'package:liga_independente_frontend/src/services/user_service.dart';

class ProfileController {
  final imagePicker = ImagePicker();
  ValueNotifier<File?> imageFile = ValueNotifier(null);

  ValueNotifier<bool> editMode = ValueNotifier(false);
  ValueNotifier<bool> inBioEditMode = ValueNotifier(false);
  ValueNotifier<bool> inContactEditMode = ValueNotifier(false);

  UserService userService = UserService();
  TextEditingController bioEC = TextEditingController();
  TextEditingController whatsappEC = TextEditingController();
  TextEditingController facebookEC = TextEditingController();
  TextEditingController instagramEC = TextEditingController();

  List<TextEditingController> controllers = [];

  ProfileController(){
    controllers = [bioEC, whatsappEC, facebookEC, instagramEC];
  }

  void clearAllEC(){
    for(var controller in controllers) {
      controller.text = '';
    }
  }


  void pick(ImageSource source) async {
    final imagePicked = await imagePicker.pickImage(source: source);

    if(imagePicked != null) {
      imageFile.value = File(imagePicked.path);
    }
  }

  void updateLoggedUser() {
    UserModel updatedUser = userService.user;

    if (bioEC.text.isNotEmpty) {
      updatedUser.bio = bioEC.text;
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

    updatedUser.contacts = updatedContacts;
    userService.updateUser(updatedUser);

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
      whatsappEC.text = userService.user.contacts!['whatsapp'];
      facebookEC.text = userService.user.contacts!['facebook'];
      instagramEC.text = userService.user.contacts!['instagram'];
      editMode.value = !editMode.value;
    }

  }
}