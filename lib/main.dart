// ignore_for_file: avoid_print

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:echirp/API/controller/notification.controller.dart';
import 'package:echirp/API/provider/chat_provider.dart';
import 'package:echirp/API/provider/event_provider.dart';
import 'package:echirp/API/provider/friend_provider.dart';
import 'package:echirp/API/provider/group_provider.dart';
import 'package:echirp/API/provider/user_provider.dart';
import 'package:echirp/API/services/socket_connection.dart';
import 'package:echirp/firebase_options.dart';
import 'package:echirp/routes/routes.dart';
import 'package:echirp/screens/splash/splash.dart';
import 'package:echirp/utils/global_variabes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'API/provider/notification_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // Initialize Awesome Notifications with default icon
  AwesomeNotifications().initialize(
    'resource://drawable/res_ic_notification',
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'eChirp Notification',
        channelDescription: 'eChirp Notification channel',
      )
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'Basic Group',
      )
    ],
  );

  // Ensure permission to send notifications
  final isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<FriendProvider>(
        create: (context) => FriendProvider(),
      ),
      ChangeNotifierProvider<GroupProvider>(
        create: (context) => GroupProvider(),
      ),
      ChangeNotifierProvider<EventsProvider>(
        create: (context) => EventsProvider(),
      ),
      ChangeNotifierProvider<UserProvider>(
        create: (context) => UserProvider(),
      ),
      ChangeNotifierProvider<ChatProvider>(
        create: (context) => ChatProvider(),
      ),
      ChangeNotifierProvider<NotificationProvider>(
        create: (_) => NotificationProvider(),
      ),
    ],
    child: const MyApp(),
  ));
  // Establish socket connection
  SocketConnection.establishConnection();
  SocketConnection().listenToSocketEvents(); // socket connection
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod,
        onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eChirp',
      theme: ThemeData.light().copyWith(
        colorScheme:
        ColorScheme.fromSeed(seedColor: GlobalVariables.colors.primary),
      ),
      onGenerateRoute: (routeSettings) => onGenerateRoute(routeSettings),
      initialRoute: SplashScreen.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}
