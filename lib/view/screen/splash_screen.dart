import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:balghny/view/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset(
        "assets/images/logo.jpg",
        height: 700,
        width: 500,


      ),
      nextScreen: const Login(),
      splashIconSize: 300,
      duration: 4000,
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.rightToLeft,
    );
  }
}
