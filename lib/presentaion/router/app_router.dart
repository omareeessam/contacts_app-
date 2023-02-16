import 'package:flutter/material.dart';
import 'package:my_contacts_app/constants/screens.dart' as screens;
import 'package:my_contacts_app/presentaion/screens/home_layout.dart';
import 'package:my_contacts_app/presentaion/screens/splach_screen.dart';

class AppRouter {
  late Widget startScreen;

  Route? onGenerateRoute(RouteSettings settings){
    startScreen = SplachScreen();
  switch(settings.name){
    case '/':
      return MaterialPageRoute(builder: (_) => startScreen);
    case screens.homeLayout:
      return MaterialPageRoute(builder: (_) => HomeLayout());
    default:
      return null;
  }
  }
}