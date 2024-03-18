import 'package:echirp/components/bottom_bar.dart';
import 'package:echirp/screens/auth/auth.dart';
import 'package:echirp/screens/events/components/event_cerate_form.dart';
import 'package:echirp/screens/events/components/upload_status.dart';
import 'package:echirp/screens/events/create_event.dart';
import 'package:echirp/screens/events/events.dart';
import 'package:echirp/screens/group/components/group_createForm.dart';
import 'package:echirp/screens/group/groupInfo.dart';
import 'package:echirp/screens/notification/notification.dart';
import 'package:echirp/screens/profile/profile.dart';
import 'package:echirp/screens/search/search.dart';
import 'package:flutter/material.dart';

import '../screens/group/components/create_group.dart';
import '../screens/home/home.dart';
import '../screens/splash/splash.dart';

onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      );
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AuthScreen(),
      );
    case BottomBar.routeName:
      int pageIndex = routeSettings.arguments as int;
      return MaterialPageRoute(
          builder: (_) => BottomBar(
                page: pageIndex,
              ));
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
      String subCategory = routeSettings.arguments as String;
      String subSubCategory = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => EventCreateFrom(
            category: category,
            subCategory: subCategory,
            subSubCategory: subSubCategory),
      );
    case UploadStatusScreen.routeName:
      String eventType = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => UploadStatusScreen(eventType: eventType),
      );
    case SearchScreen.routeName:
      String query = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => SearchScreen(query: query),
      );
    case NotificationScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const NotificationScreen(),
      );

    case ProfileScreen.routeName:
      return MaterialPageRoute(
        builder: (_) =>  ProfileScreen(),
      );

    case GroupInfoScreen.routeName:
      return MaterialPageRoute(
        builder: (_) =>  GroupInfoScreen(),
      );

      case CreateGroupScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const CreateGroupScreen(),
      );

      case GroupFormScreen.routeName:
      return MaterialPageRoute(
        builder: (_) =>  GroupFormScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      );
  }
}
