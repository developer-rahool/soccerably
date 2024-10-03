import 'package:flutter/material.dart';
import 'package:soccerably/const.dart';
import 'package:soccerably/screens/menu_pages/goal_score_by_matches.dart';
import 'package:soccerably/screens/menu_pages/matches_page.dart';

import 'menu_pages/Tournament_page.dart';
import 'menu_pages/countries_list_page.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  var selectIndex = 0;
  final List<Widget> _tabList = const [
    MatchesPage(),
    CountriesListPage(),
    TournamentPage(),
    GoalScorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabList[selectIndex],
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.shifting,
          selectedItemColor: redColor,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedItemColor: Colors.black54,
          currentIndex: selectIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.flag), label: "Country"),
            BottomNavigationBarItem(
                icon: Icon(Icons.military_tech_outlined), label: "Tournament"),
            BottomNavigationBarItem(
                icon: Icon(Icons.sports_soccer_outlined), label: "Goal"),
          ],
          onTap: (index) {
            setState(() {
              selectIndex = index;
            });
          }),
    );
  }
}
