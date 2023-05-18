


import 'package:balghny/view/screen/community_screen.dart';
import 'package:balghny/view/screen/home_page.dart';
import 'package:balghny/view/screen/login_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/post.dart';



class auth extends StatelessWidget {
  const auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if(snapshot.hasData){

            return HomePage();
          }else{
            return Login();
            
          }
        }
        ), 
        ),
    );
  }
}