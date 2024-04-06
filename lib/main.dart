import 'package:echirp/API/provider/friend_provider.dart';
import 'package:echirp/API/provider/user_provider.dart';
import 'package:echirp/routes/routes.dart';
import 'package:echirp/screens/splash/splash.dart';
import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'API/provider/event_provider.dart';
import 'API/provider/group_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
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
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eChirp',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: GlobalVariables.kPrimaryColor),
        useMaterial3: true,
      ),
      onGenerateRoute: (routeSettings) => onGenerateRoute(routeSettings),
      initialRoute: SplashScreen.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}
