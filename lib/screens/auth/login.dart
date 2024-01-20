import 'package:echirp/components/bottom_bar.dart';
import 'package:echirp/components/custom_btn.dart';
import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          const Image(
            image: AssetImage('assets/images/Sign in.png'),
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Image(
                    image: AssetImage('assets/icons/echirp-logo.png'),
                    height: 100,
                  ),
                ),
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 50,
                  // vertical: 20,
                ),
                child: Row(
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: GlobalVariables.kPrimaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height * 0.5,
                margin: const EdgeInsets.all(26),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(38),
                  border: Border.all(
                    color: const Color.fromARGB(255, 236, 135, 53),
                    width: 3,
                  ),
                ),
                child: Column(
                  children: [
                    const Text('Sign In and Dive into Event Magic!'),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Username',
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    CustomBtn(
                      text: 'Sign In',
                      size: size,
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(BottomBar.routeName);
                      },
                    ),
                    const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
