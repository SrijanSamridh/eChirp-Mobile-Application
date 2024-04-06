// ignore_for_file: use_build_context_synchronously

import 'package:echirp/API/controller/auth.controller.dart';
import 'package:echirp/API/models/user.models.dart';
import 'package:echirp/components/custom_btn.dart';
import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/bottom_bar.dart';

enum AuthMode {
  signUp,
  signIn,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/login';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode _authMode = AuthMode.signIn; // for default option when screen loads
  final authController = AuthController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    User? user = await authController.signIn(
      _usernameController.text.trim().toLowerCase(),
      _passwordController.text.trim(),
    );

    if (user != null && user.user != null) {
      String? token = user.user!.token;
      prefs.setString("x-auth-token", token!);
      prefs.setString("username", user.user!.username!);
      prefs.setString("_id", user.user!.id!);

      debugPrint(
        "User : ${prefs.getString('username')}, \nlocal Storage : ${prefs.getString('x-auth-token')},",
      );

      Navigator.of(context)
          .pushReplacementNamed(BottomBar.routeName, arguments: 0);
    } else {
      // Handle invalid login credentials or other errors
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Error'),
          content:
              const Text('Invalid username or password. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void signUp() async {
    // ignore: no_leading_underscores_for_local_identifiers
    var _payload = {
      'username': _usernameController.text.trim().toLowerCase(),
      'password': _passwordController.text.trim(),
      'email': _emailController.text.trim().toLowerCase()
    };

    var user = await authController.signUp(context, _payload);
    // ignore: unnecessary_null_comparison
    if (user != null) {
      setState(() {
        _authMode = AuthMode.signIn;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: const AssetImage('assets/images/Sign in.png'),
            fit: BoxFit.cover,
            height: size.height,
            width: size.width,
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  // vertical: 20,
                ),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _authMode = AuthMode.signIn;
                        });
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: _authMode == AuthMode.signIn
                              ? GlobalVariables.kPrimaryColor
                              : Colors.grey,
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _authMode = AuthMode.signUp;
                        });
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: _authMode == AuthMode.signUp
                              ? GlobalVariables.kPrimaryColor
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height * 0.55,
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
                child: _authMode == AuthMode.signIn
                    ? Column(
                        children: [
                          const Text('Sign In and Dive into Event Magic!'),
                          SizedBox(
                            height: size.height * 0.1,
                          ),
                          TextField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              hintText: 'Username',
                              border: InputBorder.none,
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              border: InputBorder.none,
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: size.height * 0.08,
                          ),
                          CustomBtn(
                            text: 'Sign In ',
                            size: size,
                            width: size.width * 0.2,
                            onPressed: signIn,
                          ),
                          const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    "https://i.pinimg.com/564x/a7/26/b7/a726b78996d835c9b913932ad2a67059.jpg",
                                    height: 50,
                                  )),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    "https://i.pinimg.com/originals/8f/8f/b4/8f8fb43ce828a22c91c0b59f55fb91b3.png",
                                    height: 50,
                                  )),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    "https://imagedelivery.net/5MYSbk45M80qAwecrlKzdQ/598987ea-291d-4bdc-374b-61e9ff996800/thumbnail?v=2024022113",
                                    height: 50,
                                  )),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    "https://mir-s3-cdn-cf.behance.net/project_modules/hd/d2abd662597191.5a9589b09ddf5.jpg",
                                    height: 50,
                                  )),
                            ],
                          )
                        ],
                      )
                    : Column(
                        children: [
                          const Text(
                              'Register Today, Celebrate Tomorrow: Start Now!'),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          TextField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              hintText: 'Username',
                              border: InputBorder.none,
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              hintText: 'Email ID',
                              border: InputBorder.none,
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              border: InputBorder.none,
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          CustomBtn(
                            text: 'Sign Up',
                            size: size,
                            width: size.width * 0.2,
                            onPressed: signUp,
                          ),
                          const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    "https://i.pinimg.com/564x/a7/26/b7/a726b78996d835c9b913932ad2a67059.jpg",
                                    height: 50,
                                  )),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    "https://i.pinimg.com/originals/8f/8f/b4/8f8fb43ce828a22c91c0b59f55fb91b3.png",
                                    height: 50,
                                  )),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    "https://imagedelivery.net/5MYSbk45M80qAwecrlKzdQ/598987ea-291d-4bdc-374b-61e9ff996800/thumbnail?v=2024022113",
                                    height: 50,
                                  )),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    "https://mir-s3-cdn-cf.behance.net/project_modules/hd/d2abd662597191.5a9589b09ddf5.jpg",
                                    height: 50,
                                  )),
                            ],
                          )
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
