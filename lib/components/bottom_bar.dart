import 'package:echirp/screens/events/events.dart';
import 'package:echirp/screens/group/group.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import '../API/provider/notification_provider.dart';
import '../screens/friends/friends.dart';
import '../screens/home/home.dart';
import '../screens/notification/notification.dart';
import '../utils/global_variables.dart';

// ignore: must_be_immutable
class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  BottomBar({super.key, required this.page});

  int page;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const EventsScreen(),
    const FriendsScreen(),
    const GroupScreen(),
    const NotificationScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      widget.page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final notificationCount = Provider.of<NotificationProvider>(context).newMessagesCount;

    return Scaffold(
      body: _screens[widget.page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.page,
        selectedItemColor: GlobalVariables.colors.selectedNavBar,
        unselectedItemColor: GlobalVariables.colors.unselectedNavBar,
        // backgroundColor: GlobalVariables.colors.background,
        onTap: updatePage,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 26,
        items: [
          // Home Page
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: '',
          ),
          // Events Page
          const BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            label: '',
          ),
          // Add Friends Page
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: '',
          ),
          // Groups Page
          const BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: '',
          ),
          // Notification Page
          BottomNavigationBarItem(
            icon: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -10, end: -10),
              showBadge: notificationCount != 0,
              badgeContent: Text(
                "$notificationCount",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
              badgeStyle: badges.BadgeStyle(
                badgeColor: GlobalVariables.colors.badgeColor,
              ),
              child: const Icon(Icons.notifications),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
