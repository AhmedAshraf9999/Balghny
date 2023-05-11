import 'dart:io';

import 'package:balghny/model/post.dart';
import 'package:balghny/view/screen/community_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Add_post extends StatefulWidget {


  final File img;
  const Add_post({Key? key,required this.img}) : super(key: key);

  @override
  State<Add_post> createState() => _Add_postState();
}

class _Add_postState extends State<Add_post> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text('Create New Post'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Center(
                child: Stack(
                  children: [

                    Center(child: Image.file(widget.img,width: 200, height: 200, fit:BoxFit.fill),

                 //       Image.asset("assets/images/my.jpg",width: 150, height: 150, fit:BoxFit.fill,)
                    )

                   /* Container(
                        margin: EdgeInsets.only(left: 45,top: 70),
                        child: IconButton(onPressed: (){},
                        icon: Icon(Icons.add,color: Colors.green),)),
                    Container(
                        margin: EdgeInsets.only(left: 33,top: 40),
                        child: Image.asset("assets/images/Add photo.png")),
                    Image.asset("assets/images/Rectangle 1027.png"),*/
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Column(
                children: [
                  Row(
                    children: [
                       Container(
                           margin: EdgeInsets.only(left: 20),
                           child: Text("Title",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                    ],
                  ),
                  SizedBox(height: 5),
                  SizedBox(width: 350,
                    child:  Text("Fire-Disaster",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text("Description",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
                    ],
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 350,height: 100,
                    child: TextFormField(

                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 60),
                            border: OutlineInputBorder()),

                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                       },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)))),
                    child: Text(
                      'Post',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
