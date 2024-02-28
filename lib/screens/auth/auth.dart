import 'dart:convert';

import 'package:echirp/API/controller/auth.controller.dart';
import 'package:echirp/API/models/user.models.dart';
import 'package:echirp/components/custom_btn.dart';
import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/bottom_bar.dart';
import 'package:http/http.dart' as http;

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

    authController
        .login(_usernameController.text.trim(), _passwordController.text.trim())
        .then((User? user) async {
      String? token = user?.user?.token;
      prefs.setString("x-auth-token", token!);
      prefs.setString("username", user!.user!.username!);

      debugPrint(
          "User : ${prefs.getString('username')}, \nloacl Storage : ${prefs.getString('x-auth-token')},");

      if (prefs.getString('x-auth-token') != null) {
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushReplacementNamed(BottomBar.routeName, arguments: 0);
      }
    });
  }

  void signUp() async {
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      var _payload = {
        'username': _usernameController.text.trim(),
        'password': _passwordController.text.trim(),
        'email': _emailController.text.trim()
      };

      debugPrint(_payload.toString());

      // Make the POST request
      var response = await http.post(
        Uri.parse('https://api.eventchirp.com/api/auth/signup/'),
        body: json.encode(_payload),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      debugPrint('Response: ${response.body}');

      // Check if the response has a successful status code
      if (response.statusCode == 200) {
        var res = json.decode(response.body);

        // Check if the user key exists in the response
        if (res.containsKey('body')) {
          Map<String, dynamic> userData = res['body'];

          // Access user data
          User user = User(
            message: res['message'],
            user: UserClass(
              id: userData['_id'],
              username: userData['username'],
              email: userData['email'],
            ),
          );

          debugPrint('User Registered: ${user.user?.username}');
          setState(() {
            _authMode = AuthMode.signIn;
          });
        } else {
          debugPrint('User key not found in the response.');
        }
      } else {
        debugPrint(
            'Error: ${response.statusCode}, ${response.reasonPhrase}, $response');
      }
    } catch (error) {
      debugPrint('Error: $error');
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
                            height: size.height * 0.1,
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
                            height: size.height * 0.05,
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
