import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liga_independente_frontend/src/colors.dart';
import 'package:liga_independente_frontend/src/controllers/profile_controller.dart';
import 'package:liga_independente_frontend/src/widgets/cloud_button.dart';
import 'package:liga_independente_frontend/src/widgets/modal_bottom_widget.dart';
import 'package:liga_independente_frontend/src/widgets/primary_button.dart';
import 'package:liga_independente_frontend/src/widgets/profile_page/profile_box.dart';
import 'package:liga_independente_frontend/src/widgets/profile_page/profile_header.dart';
import 'package:liga_independente_frontend/src/widgets/profile_page/profile_modal_item.dart';
import 'package:liga_independente_frontend/src/widgets/profile_page/text_input_bio.dart';
import 'package:liga_independente_frontend/src/widgets/profile_page/rounded_text_input.dart';
import 'package:liga_independente_frontend/src/widgets/secondary_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    ProfileController profileController = ProfileController();
    var userService = profileController.userService;

    return Scaffold(
      backgroundColor: primarycolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: profileController.imageFile, 
                    builder: (context, imageFile, child) {
                      return ProfileHeader(
                        image: imageFile,
                        onPressed: () {
                        ModalBottomWidget.show(context,
                          Column(children: [
              
                            const SizedBox(height: 10,),
              
                            Container(
                              height: 4,
                              width: 50,
                              decoration: BoxDecoration(
                                color: bottomSheetCircleColor,
                                borderRadius: BorderRadius.circular(5)
                              ),
                            ),
              
                            const SizedBox(height: 20,),
              
                            Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ProfileModalItem(
                                onTap: () {
                                  profileController.pick(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                icon: Icons.camera_alt,
                                text: 'Câmera',
                              ),
                            
                              ProfileModalItem(
                                onTap: () {
                                  profileController.pick(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                icon: Icons.crop_original,
                                text: 'Galeria',
                              )         
                          ],)
                          ],)
                        );
                      },);
                    },
                  ),
              
                  const SizedBox(height: 20,),
              
                  Column(children: [
                    const Text('Jane Cooper', 
                    style: TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                      ),
                    ),
                    
                    const SizedBox(height: 25,),
              
                    ValueListenableBuilder(
                      valueListenable: profileController.inBioEditMode, 
                      builder: (context, inBioEditMode, child) {
                          return ValueListenableBuilder(
                            valueListenable: profileController.editMode,
                            builder: (context, editMode, _) {
                              return ProfileBox(
                                editMode: editMode,
                                onPressed: () => profileController.inEditMode('bio'),
                                color: boxColor,
                                title: 'Biografia',
                                child: inBioEditMode ? TextInputBio(controller: profileController.bioEC,) : Text(
                                    userService.user.bio ?? '', 
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400)
                                ),
                              );
                            }
                          );
                      },),
                    
                    const SizedBox(height: 10,),
              
                    ValueListenableBuilder(
                      valueListenable: profileController.editMode,
                      builder: (context, editMode, _) {
                        return ProfileBox(
                          editMode: editMode,
                          onPressed: () {
                                  
                                },
                          color: boxColor,
                          title: 'Esportes Praticados',
                          child: Row(children: [
                        
                            SizedBox(
                              height: 50,
                              width: 280,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: userService.user.sports!.length,
                                itemBuilder: (context, index) {
                                return CloudButton(
                                  color: boxColorHeader, 
                                  child: Text(userService.user.sports![index], 
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                    )
                                  );
                              },),
                            )
                            
                          ],)          
                        );
                      }
                    ),
              
                    const SizedBox(height: 10,),
              
                    ValueListenableBuilder(
                      valueListenable: profileController.inContactEditMode,
                      builder: (context, value, _) {
                        return ValueListenableBuilder(
                          valueListenable: profileController.editMode,
                          builder: (context, editMode, _) {
                            return ProfileBox(
                              editMode: editMode,
                              onPressed: () => profileController.inEditMode('contact'),
                              color: boxColor,
                              title: 'Contato',
                              child: value 
                              ?  
                              Column(children: [
                                RoundedTextInput(
                                  controller: profileController.whatsappEC,
                                  icon: 'whatsapp',),
                                const SizedBox(height: 15,),
                                RoundedTextInput(
                                  controller: profileController.facebookEC,
                                  icon: 'facebook',),
                                const SizedBox(height: 15,),
                                RoundedTextInput(
                                  controller: profileController.instagramEC,
                                  icon: 'instagram',),
                              ],)
                              
                              : Row(children: [
                                          
                                CloudButton(
                                color: boxColorHeader, 
                                child: Image.asset(
                                  'assets/icons/icon_whatsapp.png',
                                  height: 25,
                                  ),
                                ),
                                          
                                const SizedBox(width: 10,),
                                          
                                CloudButton(
                                color: boxColorHeader, 
                                child: Image.asset(
                                  'assets/icons/icon_facebook.png',
                                  height: 25,
                                  ),
                                ),
                                          
                                const SizedBox(width: 10,),
                                          
                                CloudButton(
                                color: boxColorHeader, 
                                child: Image.asset(
                                  'assets/icons/icon_instagram.png',
                                  height: 25,
                                  ),
                                )
                                          
                              ],)
                              );
                          }
                        );
                      }
                    ),
              
                      ValueListenableBuilder(
                        valueListenable: profileController.editMode, 
                        builder: (context, inBioEditMode, child) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 45, vertical: 25),
                            child: !inBioEditMode ? null : Column(
                              children: [
              
                                PrimaryButton(
                                  onPressed: profileController.updateLoggedUser, 
                                  text: 'CONFIRMAR', 
                                  color: secondarycolor),
              
                                const SizedBox(height: 15,),
              
                                SecondaryButton(
                                  onPressed: profileController.cancelAction, 
                                  text: 'CANCELAR', 
                                  color: disableColor),
              
                              ],
                            ),
                          );
                        },
                      )
              
                  ],)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}