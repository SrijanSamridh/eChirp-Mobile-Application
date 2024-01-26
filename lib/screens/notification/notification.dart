import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  static const String routeName = '/notification';
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 20.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Notification',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.height * 0.02),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        const Image(image: AssetImage('assets/images/Push notifications-rafiki 1.png')),
        const Text('Nothing yet, but stay tuned'),
        const Text(textAlign: TextAlign.center,'You’ll get group updates, event reminders, and new recommendations here.'),
        SizedBox(height: size.height*0.2,)
      ]),
    );
  }
}
