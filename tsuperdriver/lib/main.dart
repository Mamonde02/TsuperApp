import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tsuperdriver/Components/GlobalVar.dart';
import 'package:tsuperdriver/Controller/Login/LoginVC.dart';
import 'package:tsuperdriver/Model/Account/AccoutModel.dart';
import 'package:tsuperdriver/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Controller/HomeTabbar/HomeTabbarVC.dart';
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  String initialRoute = "/";
  typeOfApplication = "Driver";

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
  AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  if (sharedPref.containsKey("isAlreadyLoggin")){
    final sharedUserData = sharedPref.getString("isAlreadyLoggin");
    Map<String, dynamic> jsonData = jsonDecode(sharedUserData ?? "{}");
    userData = UserAccountDataModel.fromMap(jsonData);
    initialRoute = "HomeScreen";
  }
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  String initialRoute = "/";
  MyApp({
    super.key,
    required this.initialRoute
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: true,
      initialRoute: initialRoute,
      routes: {
        '/': (context) => const LoginVC(),
        'HomeScreen': (context) => const HomeTabbarVC(),
        // 'pdyHomeTab': (context) => PaydayHomeTabbar(),
      },
    );
  }
}