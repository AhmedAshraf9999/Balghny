import 'package:balghny/view/auth.dart';
import 'package:balghny/view/screen/EditProfileScreen.dart';
import 'package:balghny/view/screen/about_page.dart';
import 'package:balghny/view/screen/cam2_water_screen.dart';
import 'package:balghny/view/screen/cam3_infa_screen.dart';

import 'package:balghny/view/screen/cam4_accidents_screen.dart';
import 'package:balghny/view/screen/cam_fire_screen.dart';
import 'package:balghny/view/screen/com.dart';
import 'package:balghny/view/screen/community_screen.dart';
import 'package:balghny/view/screen/contactUs_page.dart';
import 'package:balghny/view/screen/fag_page.dart';
 import 'package:balghny/view/screen/home_page.dart';
import 'package:balghny/view/screen/login_screen.dart';
import 'package:balghny/view/screen/registration_screen.dart';
import 'package:balghny/view/screen/result.dart';
import 'package:balghny/view/screen/splash_screen.dart';
import 'package:balghny/view/screen/temp.dart';
import 'package:balghny/view/widget/notification_widget.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      
      routes: {
       "/" :(context) => auth(),
       "login" : (context) => Login(),
        "register" : (context) => Registration(),
        "home" : (context) => HomePage(),
         "cam" : (context) => Cam(),
        "Cam_Fire" : (context) => Cam_Fire(),
        "cam2" : (context) => Cam2(),
        "cam3" : (context) => Cam3(),
        "cam4" : (context) => Cam4(),
      //  "noti" : (context) => NotificationWidget(notification:  notification,),
        "editprofile" : (context) => EditProfileScreen(),
        "ContactUs" : (context) => ContactUs(),
        "AboutPage" : (context) => AboutPage(),
        "AccordionPage" : (context) => AccordionPage(),
//"Community" : (context) => Community(posts: [],),
      //  "r" : (context) => Res(img: '',),
       "post" : (context) => PostListScreen(),
       

      },
    );
  }
}

