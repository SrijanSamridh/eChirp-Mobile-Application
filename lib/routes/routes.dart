import 'package:flutter/material.dart';
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
import 'package:echirp/screens/group/components/create_group.dart';
import 'package:echirp/screens/group/components/group_detail.dart';
import 'package:echirp/screens/home/home.dart';
import 'package:echirp/screens/profile/settings/profile_settings.dart';
import 'package:echirp/screens/splash/splash.dart';

// Create a route map
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (_) => const SplashScreen(),
  AuthScreen.routeName: (_) => const AuthScreen(),
  BottomBar.routeName: (_) => BottomBar(page: 0), // Default page index
  HomeScreen.routeName: (_) => const HomeScreen(),
  EventsScreen.routeName: (_) => const EventsScreen(),
  CreateEventScreen.routeName: (_) => const CreateEventScreen(),
  EventCreateFrom.routeName: (_) =>
      const EventCreateFrom(category: '', subCategory: '', subSubCategory: ''),
  UploadStatusScreen.routeName: (_) => const UploadStatusScreen(eventType: ''),
  SearchScreen.routeName: (_) => const SearchScreen(query: ''),
  NotificationScreen.routeName: (_) => const NotificationScreen(),
  ProfileScreen.routeName: (_) => const ProfileScreen(),
  EditProfileScreen.routeName: (_) => const EditProfileScreen(),
  ProfileSettings.routeName: (_) => const ProfileSettings(id: ''),
  GroupInfoScreen.routeName: (_) => GroupInfoScreen(onPressed: () {}, index: 0),
  GroupDetailsPage.routeName: (_) =>
      const GroupDetailsPage(index: 0, myGroups: false),
  CreateGroupScreen.routeName: (_) => const CreateGroupScreen(),
  GroupFormScreen.routeName: (_) => const GroupFormScreen(),
  EventDetail.routeName: (_) => EventDetail(index: 0),
};

// Centralized route generator
Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case BottomBar.routeName:
      final int pageIndex = routeSettings.arguments as int;
      return MaterialPageRoute(
          builder: (_) => BottomBar(
                page: pageIndex,
              ));
    case EventCreateFrom.routeName:
      final args = routeSettings.arguments as Map<String, String>;
      return MaterialPageRoute(
        builder: (_) => EventCreateFrom(
          category: args['category'] ?? '',
          subCategory: args['subCategory'] ?? '',
          subSubCategory: args['subSubCategory'] ?? '',
        ),
      );
    case UploadStatusScreen.routeName:
      final eventType = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => UploadStatusScreen(eventType: eventType),
      );
    case SearchScreen.routeName:
      final query = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => SearchScreen(query: query),
      );
    case ProfileSettings.routeName:
      final id = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => ProfileSettings(id: id),
      );
    case GroupInfoScreen.routeName:
      final args = routeSettings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (_) => GroupInfoScreen(
          onPressed: args['onPressed'],
          index: args['index'],
        ),
      );
    case GroupDetailsPage.routeName:
      final args = routeSettings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (_) => GroupDetailsPage(
          index: args['index'],
          myGroups: args['myGroups'],
        ),
      );
    case EventDetail.routeName:
      final index = routeSettings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => EventDetail(index: index),
      );
    default:
      if (routes.containsKey(routeSettings.name)) {
        return MaterialPageRoute(builder: routes[routeSettings.name]!);
      }
      return MaterialPageRoute(builder: (_) => const SplashScreen());
  }
}
