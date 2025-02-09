import 'package:flutter/material.dart';
import 'package:tsuperdriver/Components/AssetStore.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';
import 'package:tsuperdriver/Components/GlobalVar.dart';
import 'package:tsuperdriver/Controller/Home/FindBooking/FindBooking.dart';
import 'package:tsuperdriver/Controller/Home/Match/MatchVC.dart';

import '../../main.dart';
import 'Chat List/ChatListVC.dart';
import 'Notification/Notif.dart';
import 'Notification/Notification.dart';

part 'Home_HeaderView.dart';
part 'Home_MenuService.dart';

class HomeVC extends StatefulWidget {
  const HomeVC({super.key});


  @override
  State<HomeVC> createState() => _HomeVC();
}

class _HomeVC extends State<HomeVC> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      backgroundColor: gkGetColor(PickClr.gkBGStyle1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          headerTitleView(),

          const Spacer(),
          homeMenuServices(),
          const Spacer(),
        ],
      ),
    );
  }

  void refreshState(){
    setState(() {});
  }
}