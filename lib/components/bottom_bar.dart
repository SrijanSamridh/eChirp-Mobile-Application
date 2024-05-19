import 'package:echirp/screens/events/events.dart';
import 'package:echirp/screens/group/group.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import '../API/provider/notification_provider.dart';
import '../screens/friends/friends.dart';
import '../screens/home/home.dart';
import '../screens/notification/notification.dart';
import '../utils/global_variabes.dart';

// ignore: must_be_immutable
class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  BottomBar({super.key, required this.page});

  int page;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  double bottomBarHeight = 60;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

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
    return Scaffold(
      body: _screens[widget.page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.page,
        selectedItemColor: GlobalVariables.colors.selectedNavBar,
        unselectedItemColor: GlobalVariables.colors.unselectedNavBar,
        backgroundColor: GlobalVariables.colors.background,
        onTap: updatePage,
        iconSize: 28,
        items: [
          //? Home Page
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: widget.page == 0
                        ? GlobalVariables.colors.selectedNavBar
                        : GlobalVariables.colors.background,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
            label: 'Home',
          ),
          //? Events Page
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: widget.page == 1
                        ? GlobalVariables.colors.selectedNavBar
                        : GlobalVariables.colors.background,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 2.0),
                child: Icon(Icons.event_available),
              ),
            ),
            label: 'Events',
          ),
          //? Firends Page
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: widget.page == 2
                        ? GlobalVariables.colors.selectedNavBar
                        : GlobalVariables.colors.background,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.person_add),
            ),
            label: 'Add Friends',
          ),
          //? Groups Page
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: widget.page == 3
                        ? GlobalVariables.colors.selectedNavBar
                        : GlobalVariables.colors.background,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.group),
            ),
            label: 'Groups',
          ),
          //? Notification Page
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: widget.page == 4
                        ? GlobalVariables.colors.selectedNavBar
                        : GlobalVariables.colors.background,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: Provider.of<NotificationProvider>(context)
                      .newMessagesCount != 0
                  ? badges.Badge(
                      badgeContent: Text(
                        "${Provider.of<NotificationProvider>(context).newMessagesCount}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                      // badgeColor: GlobalVariables.secondaryColor,
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 2.0),
                          child: Icon(Icons.notifications_on_outlined),
                        ),
                      ),
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 2.0),
                        child: Icon(Icons.notifications_on_outlined),
                      ),
                    ),
            ),
            label: 'Notification',
          ),
        ],
      ),
    );
  }
}
