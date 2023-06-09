import 'package:balghny/view/auth.dart';
import 'package:balghny/view/screen/EditProfileScreen.dart';
import 'package:balghny/view/screen/hospitals.dart';
import 'package:balghny/view/screen/Emergency.dart';
import 'package:balghny/view/screen/about_page.dart';
import 'package:balghny/view/screen/cam2_water_screen.dart';
import 'package:balghny/view/screen/cam3_infa_screen.dart';

import 'package:balghny/view/screen/cam4_accidents_screen.dart';
import 'package:balghny/view/screen/cam_fire_screen.dart';
import 'package:balghny/view/screen/com.dart';

import 'package:balghny/view/screen/contactUs_page.dart';
import 'package:balghny/view/screen/fag_page.dart';
import 'package:balghny/view/screen/home_page.dart';
import 'package:balghny/view/screen/login_screen.dart';
import 'package:balghny/view/screen/notification.dart';
import 'package:balghny/view/screen/profile.dart';
import 'package:balghny/view/screen/registration_screen.dart';

import 'package:balghny/l10n/app_localizations.dart';

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
        primarySwatch: Colors.green,
      ),
      //For Multi Languages
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: localeCallBack,

      routes: {
        "/": (context) => auth(),
        "login": (context) => Login(),
        "register": (context) => Registration(),
        "home": (context) => HomePage(),
        //    "cam" : (context) => Cam(),
        "Cam_Fire": (context) => Cam_Fire(result1: '',),
        "cam2": (context) => Cam2(result1: '',),
        "cam3": (context) => Cam3(result1: '',),
        "cam4": (context) => Cam4(result1: '',),
        //  "noti" : (context) => NotificationWidget(notification:  notification,),
        "editprofile": (context) => EditProfileScreen(),
        "ContactUs": (context) => ContactUs(),
        "AboutPage": (context) => AboutPage(),
        "AccordionPage": (context) => AccordionPage(),
//"Community" : (context) => Community(posts: [],),
        //  "r" : (context) => Res(img: '',),
        "post": (context) => PostListScreen(),
        "Emergency": (context) => Emergency(),
        "Hospitals": (context) => Hospitals(),
        "profile": (context) => ProfileScreen(),
        "notification": (context) => notification(),
      },
    );
  }
}

Locale localeCallBack(Locale? locale, Iterable<Locale> supportedLocales) {
  if (locale == null) {
    return supportedLocales.last;
  }

  for (var supportedLocale in supportedLocales) {
    if (locale.languageCode == supportedLocale.languageCode) {
      return supportedLocale;
    }
  }

  return supportedLocales.last;
}
