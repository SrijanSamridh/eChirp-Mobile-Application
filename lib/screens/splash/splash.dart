import 'dart:async';

import 'package:echirp/components/bottom_bar.dart';
import 'package:echirp/screens/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          Navigator.pushNamedAndRemoveUntil(
              // ignore: use_build_context_synchronously
              context, BottomBar.routeName, arguments: 0, (route) => false);
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
    checkAuth();
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
                Image(
                  image: const AssetImage('assets/icons/echirp-logo.png'),
                  height: size.height * 0.12,
                ),
                const SizedBox(height: 16),
                Text(
                  'Welcome to EventChirp!',
                  style: TextStyle(
                    fontSize: size.width * 0.045,
                    fontWeight: FontWeight.w500,
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
