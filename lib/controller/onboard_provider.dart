import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soccerably/const.dart';
import 'package:soccerably/screens/home_screen.dart';
import 'package:soccerably/screens/menu_screen.dart';

class OnboardProvider with ChangeNotifier {
  int selectedPageIndex = 0;

  pageIndex(int value) {
    selectedPageIndex = value;
    notifyListeners();
  }

  var pageController = PageController();
  bool get islastpage => selectedPageIndex == onboardingPages.length - 1;

  forwardAction() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeInCirc);
  }

  skip(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("onboarding", true);
    nextPage(context, const MenuScreen());
  }

  List<OnboardingModel> onboardingPages = [
    OnboardingModel('assets/images/board11.png',
        'Experience the soccer like never before.'),
    OnboardingModel('assets/images/board22.png',
        'Get all the latest news, stats, and updates.'),
    OnboardingModel('assets/images/board33.png',
        'Discover everything about soccer, all in one place.')
  ];

  // splashfunc() {
  //   Timer(const Duration(seconds: 3), () {
  //     Get.to(Onboarding());
  //   });
  // }
}

class OnboardingModel {
  final String image;
  final String descript;

  OnboardingModel(this.image, this.descript);
}
