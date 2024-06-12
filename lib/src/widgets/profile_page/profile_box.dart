import 'package:flutter/material.dart';

class ProfileBox extends StatelessWidget {
  final Color color;
  final Widget child;
  final String title;
  final bool editMode;
  final Function() onPressed;

  const ProfileBox({super.key, required this.color, required this.child, required this.title, required this.onPressed, required this.editMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 33),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700,),),
              editMode ? Container() : IconButton(onPressed: onPressed, icon: const Icon(Icons.edit, color: Colors.white, size: 20,)),
            ],
          ),
          const SizedBox(height: 15,),
          child 
      ],)
    );
  }
}