import 'dart:async';

import 'package:echirp/API/models/user.models.dart';
import 'package:echirp/API/provider/notification_provider.dart';
import 'package:echirp/API/provider/user_provider.dart';
import 'package:echirp/components/bottom_bar.dart';
import 'package:echirp/screens/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../API/provider/friend_provider.dart';
import '../../components/custom_btn.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loader = false;

  void checkAuth() async {
    Timer(
      const Duration(seconds: 3),
      () async {
        final prefs = await SharedPreferences.getInstance();
        if (prefs.containsKey('x-auth-token')) {
          _initProfileData();
          Navigator.pushNamedAndRemoveUntil(
              // ignore: use_build_context_synchronously
              context,
              BottomBar.routeName,
              arguments: 0,
              (route) => false);
        } else {
          setState(() {
            loader = true;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _initPotentialFriendList();
    initNotification();
    checkAuth();
  }

  Future<void> _initPotentialFriendList() async {
    await Provider.of<FriendProvider>(context, listen: false)
        .fetchPotentialFriends();
  }

  Future<void> _initProfileData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // ignore: use_build_context_synchronously
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchUserData(pref.getString("_id")!, true);
    User userData = User(
        message: "data feteced from the local storage",
        user: UserClass(
            id: pref.getString('_id'), username: pref.getString("username")));
    userProvider.setUserData(userData);
    print(pref.getString('x-auth-token'));
  }

  Future<void> initNotification() async {
    await NotificationProvider().fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: const AssetImage('assets/images/Group 75.png'),
            fit: BoxFit.cover,
            width: size.width,
            height: size.height,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.13),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image(
                    image: const AssetImage('assets/icons/echirp_logo.jpeg'),
                    height: size.height * 0.12,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Welcome to eChirp',
                  style: TextStyle(
                    fontSize: size.width * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.1),
                  child: CustomBtn(
                    size: size,
                    text: loader ? 'Get Started' : 'Processing..',
                    onPressed: () {
                      loader
                          ? Navigator.of(context).pushReplacementNamed(
                              AuthScreen.routeName,
                              arguments: 0)
                          : null;
                    },
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: Text(
                'Start Today, Celebrate Tomorrow!',
                style: TextStyle(
                  fontSize: size.width * 0.03,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
