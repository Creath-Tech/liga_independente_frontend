import 'dart:io';

import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';

class ProfileHeader extends StatelessWidget {
  final void Function() onPressed;
  final File? image;

  const ProfileHeader({super.key, required this.onPressed, this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height / 7,
            color: boxColorHeader,
            ),
          
          Positioned(
            top: 7,
            left: 7,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.white,
              ), 
              onPressed: () {},)
            ),

          Container(
            margin: const EdgeInsets.only(top: 40),
            child: Stack(children: [
              CircleAvatar(
                backgroundColor: circleProfile, 
                radius: 70,
                backgroundImage: image != null ? FileImage(image!) : null,
                child: image == null ? const Icon(Icons.person, color: Colors.white, size: 100,) : null,
            ),
            
            Positioned(
              bottom: 9,
              right: 0,
              child: CircleAvatar(
                radius: 17,
                backgroundColor: secondarycolor, 
                child: IconButton(onPressed: onPressed, icon: const Icon(Icons.camera_alt, color: Colors.black,), iconSize: 20,),)
            )
            ],),
          )
      ],);
  }
}