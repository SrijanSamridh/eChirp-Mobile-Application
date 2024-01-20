import 'package:echirp/routes/routes.dart';
import 'package:echirp/screens/splash/splash.dart';
import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eChirp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: GlobalVariables.kPrimaryColor),
        useMaterial3: true,
      ),
      onGenerateRoute: (routeSettings) => onGenerateRoute(routeSettings),
      initialRoute: SplashScreen.routeName,
      debugShowCheckedModeBanner: false,

    );
  }
}


