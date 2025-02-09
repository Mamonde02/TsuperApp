import 'package:flutter/material.dart';
import 'package:tsuperadmin/Controller/Booking/BookingVC.dart';
import 'package:tsuperdriver/Components/AssetStore.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';
import 'package:tsuperdriver/Components/GlobalVar.dart';

import '../../Components/GlobalVar.dart' as mainGlobal;
import '../Booking/Generate Report/GenerateReportVC.dart';
import '../Chat/ChatVC.dart';
import '../Users/UsersVC.dart';

part 'Home_NavMenu.dart';

class HomeVC extends StatefulWidget{
  @override
  State<HomeVC> createState() => _HomeVC();
}

class _HomeVC extends State<HomeVC> {
  @override
  Widget build(BuildContext context) {
    const style1 = TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white);
    const style2 = TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white);

    return
    Scaffold(
      appBar: AppBar(
                backgroundColor: gkGetColor(PickClr.tsuperTheme),
                surfaceTintColor: gkGetColor(PickClr.tsuperTheme),
                automaticallyImplyLeading: false,
                toolbarHeight: 70,
                title: Row(
                  children: [
                    Image.asset(
                      AssetStoreImage.tsuperRiderLogo,
                      width: 35,
                      height: 35,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(width: 15),
                    const Text("Tsuper Admin", style: style1),

                    const Spacer(),
                    Text("Welcome ${userData?.FirstName ?? ""}"),
                    
                    const SizedBox(width: 15),
                    InkWell(
                      onTap: (){
                        appLogout(context, mounted);
                      },
                      child: const Icon(Icons.logout_outlined, color: Colors.white, size: 35),
                    )
                  ],
                ),
              ),

      body:
      Row(
        children: [
          HomeNavigationBar(),
          Expanded(child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
            child: viewDisplay(),
          ))
        ],
      ),
    );
  }

  Widget viewDisplay(){
    switch (mainGlobal.displayType) {
    case "Users":
      return UsersVC();
    case "Booking":
      return BookingVC();
    default:
      return ChatVC();
    }
  }

  void refreshState() => setState(() {});
}