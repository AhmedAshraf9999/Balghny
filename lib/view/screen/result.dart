

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Res extends StatelessWidget {
   // final   img;
  final File img;


  // Res({required this.img});
 const Res({ Key? key, required this.img }) : super(key: key);

 //final XFile img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          //  Navigator.of(context).pushNamed("home");
          }, icon: Icon(Icons.arrow_back_ios_sharp),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.file(img),
          ],
        ),
      ),
    );
  }
}
