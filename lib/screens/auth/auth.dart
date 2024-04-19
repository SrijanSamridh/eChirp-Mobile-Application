// ignore_for_file: use_build_context_synchronously

import 'package:echirp/API/controller/auth.controller.dart';
import 'package:echirp/API/models/user.models.dart';
import 'package:echirp/API/provider/user_provider.dart';
import 'package:echirp/API/services/auth_provider.dart';
import 'package:echirp/components/custom_btn.dart';
import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../API/services/socket_connection.dart';
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
  AuthProvider authProvider = AuthProvider();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool? showPasswordCheck = false;
  // ignore: prefer_typing_uninitialized_variables
  var _passwordError;
  Color errorTextColor = Colors.red;
  bool onLoad = false;

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
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUserData(user);
      debugPrint(
        "User : ${prefs.getString('username')}, From Provider:${userProvider.userData!.user?.username} \nlocal Storage : ${prefs.getString('x-auth-token')},",
      );
      SocketConnection().listenToSocketEvents(context); // socket connection

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

  bool validatePassword(String password) {
    // Please make sure you've a Strong password, includes Uppercase, Lowercase, Digits & special Characters.
    final RegExp hasUppercase = RegExp(r'[A-Z]');
    final RegExp hasLowercase = RegExp(r'[a-z]');
    final RegExp hasDigit = RegExp(r'\d');
    final RegExp hasSpecialChars = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    return password.length >= 8 && // Minimum length
        hasUppercase.hasMatch(password) && // At least one uppercase
        hasLowercase.hasMatch(password) && // At least one lowercase
        hasDigit.hasMatch(password) && // At least one digit
        hasSpecialChars.hasMatch(password); // At least one special character
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
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: const Image(
                      image: AssetImage('assets/icons/echirp_logo.jpeg'),
                      height: 100,
                    ),
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
                // height: size.height * 0.55,
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
                          Text(
                            ' Hello there, nice to see you...',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.height * 0.016),
                          ),
                          SizedBox(
                            height: size.height * 0.08,
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
                            obscureText: !showPasswordCheck!,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              border: InputBorder.none,
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text("Show Password "),
                              Checkbox(
                                checkColor: Colors.white,
                                value: showPasswordCheck,
                                onChanged: (bool? value) {
                                  setState(() {
                                    showPasswordCheck = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          CustomBtn(
                            text: onLoad ? 'Loading...' : 'Sign In ',
                            size: size,
                            width: size.width * 0.2,
                            onPressed: () {
                              setState(() {
                                onLoad = true;
                              });
                              signIn();
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
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          LoginViaSocialMedia(
                            onPressed: () async {
                              var credential = await authProvider.signInWithGoogle();
                              print(credential);
                            },
                          )
                        ],
                      )
                    : Column(
                        children: [
                          Text('New here?',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.height * 0.016)),
                          Text(
                              textAlign: TextAlign.center,
                              'Sign up to make new friends & attend fun happenings!',
                              style: TextStyle(fontSize: size.height * 0.012)),
                          SizedBox(
                            height: size.height * 0.008,
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
                              hintText: 'email',
                              border: InputBorder.none,
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          TextField(
                            obscureText: !showPasswordCheck!,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              border: InputBorder.none,
                            ),
                            onChanged: (password) {
                              final isValid = validatePassword(password);
                              setState(() {
                                _passwordError = isValid
                                    ? "Hurrey! you Got a Strong password!"
                                    : 'Please make sure you\'ve a 8 char Strong password, includes Uppercase, Lowercase, Digits & special Characters.';
                                if (isValid) {
                                  errorTextColor =
                                      const Color.fromARGB(255, 0, 220, 8);
                                } else {
                                  errorTextColor = Colors.red;
                                }
                              });
                            },
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          if (_passwordError != null)
                            Text(
                              _passwordError!,
                              style: TextStyle(
                                  color: errorTextColor, fontSize: 12.0),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text("Show Password "),
                              Checkbox(
                                checkColor: Colors.white,
                                value: showPasswordCheck,
                                onChanged: (bool? value) {
                                  setState(() {
                                    showPasswordCheck = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.00,
                          ),
                          CustomBtn(
                            text: 'Sign Up',
                            size: size,
                            width: size.width * 0.2,
                            onPressed: () {
                              if (validatePassword(_passwordController.text)) {
                                signUp();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Please make sure all the fields are filled and as per requirements!"),
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          const Text(
                            'or Sign Up Via',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                          LoginViaSocialMedia(
                            onPressed: () async {
                              var credential = await authProvider.signInWithGoogle();
                              print(credential);
                            }
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

class LoginViaSocialMedia extends StatelessWidget {
  final VoidCallback onPressed;
  const LoginViaSocialMedia({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              "assets/icons/facebook.png",
              height: 35,
            )),
        GestureDetector(
          onTap: onPressed,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                "assets/icons/google.png",
                height: 50,
              )),
        ),
        ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              "assets/icons/instagram.png",
              height: 48,
            )),
        ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              "assets/icons/apple.png",
              height: 60,
            )),
      ],
    );
  }
}
