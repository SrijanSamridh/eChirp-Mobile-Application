import 'package:echirp/screens/auth/login.dart';
import 'package:flutter/material.dart';

import '../../components/custom_btn.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        const Image(
          image: AssetImage('assets/images/Group 75.png'),
          fit: BoxFit.cover,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.1),
                child: const Column(
                  children: [
                    Image(
                      image: AssetImage('assets/icons/echirp-logo.png'),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Welcome to EventChirp!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        // color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.1),
              child: CustomBtn(
                size: size,
                text: 'Get Started',
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
              ),
            ),
          ],
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Start Today, Celebrate Tomorrow!',
              style: TextStyle(
                fontSize: 12,
                // fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
