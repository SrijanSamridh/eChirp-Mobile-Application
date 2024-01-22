import 'package:echirp/components/bottom_bar.dart';
import 'package:echirp/screens/auth/login.dart';
import 'package:echirp/screens/events/components/event_cerate_form.dart';
import 'package:echirp/screens/events/create_event.dart';
import 'package:echirp/screens/events/events.dart';
import 'package:flutter/material.dart';

import '../screens/home/home.dart';
import '../screens/splash/splash.dart';

onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      );
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(builder: (_) => const BottomBar());
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      );
    case EventsScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const EventsScreen(),
      );
    case CreateEventScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const CreateEventScreen(),
      );
    case EventCreateFrom.routeName:
    String category = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => EventCreateFrom(category: category),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      );
  }
}
