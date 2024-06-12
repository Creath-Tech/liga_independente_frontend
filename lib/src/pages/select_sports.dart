import 'package:flutter/material.dart';
import 'package:liga_independente_frontend/src/colors.dart';
import 'package:liga_independente_frontend/src/widgets/cloud_button.dart';
import 'package:liga_independente_frontend/src/widgets/primary_button.dart';


class SelectSports extends StatelessWidget {
  const SelectSports({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ 
             
              const SizedBox(height: 50,),
             
              const Text("Quais esportes você prática?", 
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 20, 
                  fontWeight: FontWeight.w700),),
              
              const SizedBox(height: 50,),
              
              SizedBox(
                width: 320, 
                height: 480,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, 
                    crossAxisSpacing: 10, 
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.5
                  ),
                  itemCount: 40,
                  itemBuilder: (context, index) {
                    return CloudButton(child: Text("futzin $index", style: TextStyle(color: Colors.white)), color: boxColorHeader);
                  },
                ),
              ),
              const SizedBox(height: 50,),

              Padding(
                
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: PrimaryButton(onPressed: () {}, text: "CONTINUAR", color: secondarycolor),
              ),
          ],),
        ),
      ),
    );
    
  }
}