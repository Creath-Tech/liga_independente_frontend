import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liga_independente_frontend/src/colors.dart';
import 'package:liga_independente_frontend/src/controllers/profile_controller.dart';
import 'package:liga_independente_frontend/src/pages/manager_pages.dart';
import 'package:liga_independente_frontend/src/pages/home_page.dart';
import 'package:liga_independente_frontend/src/pages/select_sports.dart';
import 'package:liga_independente_frontend/src/widgets/cloud_button.dart';
import 'package:liga_independente_frontend/src/widgets/custom_loading.dart';
import 'package:liga_independente_frontend/src/widgets/modal_bottom_widget.dart';
import 'package:liga_independente_frontend/src/widgets/primary_button.dart';
import 'package:liga_independente_frontend/src/widgets/profile_page/profile_box.dart';
import 'package:liga_independente_frontend/src/widgets/profile_page/profile_header.dart';
import 'package:liga_independente_frontend/src/widgets/profile_page/profile_modal_item.dart';
import 'package:liga_independente_frontend/src/widgets/profile_page/text_input_bio.dart';
import 'package:liga_independente_frontend/src/widgets/profile_page/rounded_text_input.dart';
import 'package:liga_independente_frontend/src/widgets/secondary_button.dart';
import 'package:liga_independente_frontend/src/widgets/warning_message.dart';

class ProfilePage extends StatefulWidget {
  final DocumentSnapshot? user;
  final bool userCheck;
  final Future<String?>? image;

  ProfilePage({super.key, this.user, this.userCheck = false, this.image});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileController profileController =
      ProfileController(widget.user?["userId"]);

  bool get userCheck {
    return widget.user == null || !widget.user!.exists;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: profileController.isLoading,
          builder: (context, isLoading, _) {
            return isLoading
                ? customLoading()
                : Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ValueListenableBuilder(
                              valueListenable: profileController.imageFile,
                              builder: (context, imageFile, child) {
                                return ProfileHeader(
                                  userCheck: userCheck,
                                  backButton: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      )),
                                  loggoutButton: () {
                                    profileController.authService.loggout();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ManagerPages(),
                                      ),
                                    );
                                  },
                                  image: imageFile,
                                  onPressed: () {
                                    ModalBottomWidget.show(
                                      context,
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 4,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: bottomSheetCircleColor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              ProfileModalItem(
                                                onTap: () {
                                                  profileController
                                                      .pick(ImageSource.camera);
                                                  Navigator.pop(context);
                                                },
                                                icon: Icons.camera_alt,
                                                text: 'Câmera',
                                              ),
                                              ProfileModalItem(
                                                onTap: () {
                                                  profileController.pick(
                                                      ImageSource.gallery);
                                                  Navigator.pop(context);
                                                },
                                                icon: Icons.crop_original,
                                                text: 'Galeria',
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Text(
                                  userCheck
                                      ? profileController
                                              .userService.user.name ??
                                          ''
                                      : "${widget.user!["name"]}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                ValueListenableBuilder(
                                  valueListenable:
                                      profileController.inBioEditMode,
                                  builder: (context, inBioEditMode, child) {
                                    return ValueListenableBuilder(
                                      valueListenable:
                                          profileController.editMode,
                                      builder: (context, editMode, _) {
                                        return ProfileBox(
                                          userCheck: userCheck,
                                          editMode: editMode,
                                          onPressed: () => profileController
                                              .inEditMode('bio'),
                                          color: boxColor,
                                          title: 'Biografia',
                                          icon: Icons.edit,
                                          child: inBioEditMode
                                              ? TextInputBio(
                                                  controller:
                                                      profileController.bioEC,
                                                )
                                              : Text(
                                                  userCheck
                                                      ? profileController
                                                              .userService
                                                              .user
                                                              .bio ??
                                                          ''
                                                      : "${widget.user!["bio"]}",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ValueListenableBuilder(
                                  valueListenable: profileController.editMode,
                                  builder: (context, editMode, _) {
                                    return ProfileBox(
                                      userCheck: userCheck,
                                      icon: Icons.edit,
                                      editMode: editMode,
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SelectSports(),
                                        ),
                                      ),
                                      color: boxColor,
                                      title: 'Esportes Praticados',
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: 280,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: userCheck
                                                  ? profileController
                                                      .userService
                                                      .user
                                                      .sports!
                                                      .length
                                                  : widget
                                                      .user!["sports"].length,
                                              itemBuilder: (context, index) {
                                                return CloudButton(
                                                  color: boxColorHeader,
                                                  child: Text(
                                                    userCheck
                                                        ? profileController
                                                            .userService
                                                            .user
                                                            .sports![index]
                                                        : widget.user!["sports"]
                                                            [index],
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ValueListenableBuilder(
                                  valueListenable:
                                      profileController.inContactEditMode,
                                  builder: (context, value, _) {
                                    return ValueListenableBuilder(
                                      valueListenable:
                                          profileController.editMode,
                                      builder: (context, editMode, _) {
                                        return ProfileBox(
                                          userCheck: userCheck,
                                          editMode: editMode,
                                          onPressed: () => profileController
                                              .inEditMode('contact'),
                                          color: boxColor,
                                          title: 'Contato',
                                          icon: userCheck ? Icons.edit : null,
                                          child: value
                                              ? Column(
                                                  children: [
                                                    RoundedTextInput(
                                                      controller:
                                                          profileController
                                                              .whatsappEC,
                                                      icon: 'whatsapp',
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    RoundedTextInput(
                                                      controller:
                                                          profileController
                                                              .facebookEC,
                                                      icon: 'facebook',
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    RoundedTextInput(
                                                      controller:
                                                          profileController
                                                              .instagramEC,
                                                      icon: 'instagram',
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    Visibility(
                                                      visible: userCheck
                                                          ? profileController
                                                              .socialCheck(null,
                                                                  'whatsapp')
                                                          : profileController
                                                              .socialCheck(
                                                                  widget.user,
                                                                  'whatsapp'),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          profileController.abrirWhatsApp(userCheck
                                                              ? profileController
                                                                      .userService
                                                                      .user
                                                                      .contacts![
                                                                  'whatsapp']
                                                              : widget.user![
                                                                      'contacts']
                                                                  ['whatsapp']);
                                                        },
                                                        child: CloudButton(
                                                          color: boxColorHeader,
                                                          child: Image.asset(
                                                            'assets/icons/icon_whatsapp.png',
                                                            height: 25,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: userCheck
                                                          ? profileController
                                                              .socialCheck(null,
                                                                  'facebook')
                                                          : profileController
                                                              .socialCheck(
                                                                  widget.user,
                                                                  'facebook'),
                                                      child: GestureDetector(
                                                        onTap: () => profileController
                                                            .launchInBrowser(Uri.parse(userCheck
                                                                ? profileController
                                                                        .userService
                                                                        .user
                                                                        .contacts![
                                                                    'facebook']
                                                                : widget.user![
                                                                        'contacts']
                                                                    [
                                                                    'facebook'])),
                                                        child: CloudButton(
                                                          color: boxColorHeader,
                                                          child: Image.asset(
                                                            'assets/icons/icon_facebook.png',
                                                            height: 25,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: userCheck
                                                          ? profileController
                                                              .socialCheck(null,
                                                                  'instagram')
                                                          : profileController
                                                              .socialCheck(
                                                                  widget.user,
                                                                  'instagram'),
                                                      child: GestureDetector(
                                                        onTap: () => profileController
                                                            .launchInBrowser(Uri.parse(userCheck
                                                                ? profileController
                                                                        .userService
                                                                        .user
                                                                        .contacts![
                                                                    'instagram']
                                                                : widget.user![
                                                                        'contacts']
                                                                    [
                                                                    'instagram'])),
                                                        child: CloudButton(
                                                          color: boxColorHeader,
                                                          child: Image.asset(
                                                            'assets/icons/icon_instagram.png',
                                                            height: 25,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                ValueListenableBuilder(
                                  valueListenable: profileController.editMode,
                                  builder: (context, inBioEditMode, child) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 45, vertical: 25),
                                      child: !inBioEditMode
                                          ? null
                                          : Column(
                                              children: [
                                                PrimaryButton(
                                                  onPressed: () {
                                                    // Valida as URLs quando o botão é pressionado
                                                    if (profileController
                                                        .urlValidate(
                                                      profileController
                                                          .instagramEC.text,
                                                      profileController
                                                          .facebookEC.text,
                                                    )) {
                                                      // Se as URLs forem válidas, atualiza o usuário logado
                                                      profileController
                                                          .updateLoggedUser();
                                                    } else {
                                                      // Se as URLs não forem válidas, mostra uma mensagem de erro
                                                      WarningMessage.show(
                                                          context,
                                                          "Link inválido");
                                                    }
                                                  },
                                                  text: 'CONFIRMAR',
                                                  color: secondarycolor,
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                SecondaryButton(
                                                  onPressed: profileController
                                                      .cancelAction,
                                                  text: 'CANCELAR',
                                                  color: secondarycolor,
                                                ),
                                              ],
                                            ),
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
