import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soccerably/const.dart';
import 'package:soccerably/controller/Tournament_provider.dart';
import 'package:soccerably/controller/goal_scorer_provider.dart';
import 'package:soccerably/controller/matches_provider.dart';
import 'package:soccerably/controller/onboard_provider.dart';
import 'package:soccerably/controller/team_provider.dart';
import 'controller/tournament_country_provider.dart';
import 'package:provider/provider.dart';

import 'screens/splash_screen.dart';

bool? isOnBoarding;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pres = await SharedPreferences.getInstance();
  isOnBoarding = pres.getBool("onboarding") ?? false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MatchesProvider()),
        ChangeNotifierProvider(create: (context) => TeamProvider()),
        ChangeNotifierProvider(create: (context) => TournamentProvider()),
        ChangeNotifierProvider(create: (context) => GoalScorerProvider()),
        ChangeNotifierProvider(
            create: (context) => TournamentByCountryProvider()),
        ChangeNotifierProvider(create: (context) => OnboardProvider()),
      ],
      child: MaterialApp(
        title: 'Soccerably',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: midBlackColor,
          colorScheme: ColorScheme.fromSeed(seedColor: darkBlackColor),
          useMaterial3: true,
        ),
        //home: isOnBoarding == true ? HomeScreen() : Onboarding(),
        home: SplashScreen(),
      ),
    );
  }
}
