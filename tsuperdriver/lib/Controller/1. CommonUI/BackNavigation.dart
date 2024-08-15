import 'package:flutter/material.dart';

import '../../Components/Colors-Design.dart';

AppBar backNavigation(BuildContext context, String title){
  const style1 = TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700);
  return
  AppBar(
    backgroundColor:gkGetColor(PickClr.tsuperTheme),
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.white, size: 30),
    title: Text(title),
    titleTextStyle: style1,
  );
}