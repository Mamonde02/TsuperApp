import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tsuperadmin/Controller/Home/HomeVC.dart';
import 'package:tsuperadmin/Controller/Login/LoginVC.dart';
import 'package:tsuperdriver/Components/GlobalVar.dart';
import 'package:tsuperdriver/Model/Account/AccoutModel.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  String initialRoute = "/";

  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  if (sharedPref.containsKey("isAlreadyLoggin")){
    final sharedUserData = sharedPref.getString("isAlreadyLoggin");
    Map<String, dynamic> jsonData = jsonDecode(sharedUserData ?? "{}");
    userData = UserAccountDataModel.fromMap(jsonData);
    initialRoute = "HomeScreen";
  }

  runApp(MyApp(initialRoute: initialRoute));
}

// ignore: must_be_immutable
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
        '/': (context) => LoginVC(),
        'HomeScreen': (context) => HomeVC(),
      },
    );
  }
}