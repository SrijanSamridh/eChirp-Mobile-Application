import 'package:echirp/components/bottom_bar.dart';
import 'package:echirp/screens/auth/login.dart';
import 'package:echirp/screens/events/events.dart';
import 'package:flutter/material.dart';

import '../screens/home/home.dart';
import '../screens/splash/splash.dart';

onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(builder: (context) => const BottomBar());
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
    case EventsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const EventsScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
  }
}
