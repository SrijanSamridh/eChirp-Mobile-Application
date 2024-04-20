import 'package:echirp/components/bottom_bar.dart';
import 'package:echirp/screens/auth/auth.dart';
import 'package:echirp/screens/events/components/event_cerate_form.dart';
import 'package:echirp/screens/events/components/upload_status.dart';
import 'package:echirp/screens/events/create_event.dart';
import 'package:echirp/screens/events/event_detail.dart';
import 'package:echirp/screens/events/events.dart';
import 'package:echirp/screens/group/components/group_create_form.dart';
import 'package:echirp/screens/group/groupInfo.dart';
import 'package:echirp/screens/notification/notification.dart';
import 'package:echirp/screens/profile/profile.dart';
import 'package:echirp/screens/profile/settings/edit_profile.dart';
import 'package:echirp/screens/search/search.dart';
import 'package:flutter/material.dart';

import '../screens/group/components/create_group.dart';
import '../screens/group/components/group_detail.dart';
import '../screens/home/home.dart';
import '../screens/profile/settings/profile_settings.dart';
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
        builder: (_) => const ProfileScreen(),
      );
    
    case EditProfileScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const EditProfileScreen(),
      );

    case ProfileSettings.routeName:
     String id = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => ProfileSettings(id: id),
      );

    case GroupInfoScreen.routeName:
      var onPressed = routeSettings.arguments as VoidCallback;
      return MaterialPageRoute(
        builder: (_) => GroupInfoScreen(onPressed: onPressed),
      );
    case GroupDetailsPage.routeName:
      return MaterialPageRoute(
        builder: (_) => GroupDetailsPage(),
      );

    case CreateGroupScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const CreateGroupScreen(),
      );

    case GroupFormScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const GroupFormScreen(),
      );
    case EventDetail.routeName:
      int index = routeSettings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => EventDetail(index: index),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      );
  }
}
