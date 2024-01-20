import 'package:echirp/screens/events/events.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import '../screens/home/home.dart';
import '../utils/global_variabes.dart';


class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarHeight = 60;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  final List<Widget> _screens = [
    const HomeScreen(),
    const EventsScreen(),
    const Center(child: Text('Add Friends')),
    const Center(child: Text('Join Groups')),
    const Center(child: Text('Notification')),
  ];
  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
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
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
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
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
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
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
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
                    color: _page == 3
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
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
                    color: _page == 4
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const badges.Badge(
                badgeContent: Text(
                  '2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                // badgeColor: GlobalVariables.secondaryColor,
                child: Center(child: Padding(
                  padding: EdgeInsets.only(top: 2.0),
                  child: Icon(Icons.notifications_on_outlined),
                )),
              ),
              ),
            label: 'Notification',
            ),
        ],
      ),
    );
  }
}
