// ignore_for_file: unused_import, avoid_web_libraries_in_flutter

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soccerably/screens/home_screen.dart';
import 'package:soccerably/screens/menu_screen.dart';
import 'package:soccerably/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? isOnBoarding;
  @override
  initState() {
    load();
    super.initState();
  }

  load() async {
    final pres = await SharedPreferences.getInstance();
    isOnBoarding = pres.getBool("onboarding") ?? false;
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  isOnBoarding == true ? const MenuScreen() : Onboarding()));
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 280,
              width: 280,
              child: Image.asset("assets/images/main_logo.png"),
            ),
          ),
        ],
      ),
    );
  }
}
