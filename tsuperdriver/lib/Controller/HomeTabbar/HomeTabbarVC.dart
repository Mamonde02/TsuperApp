import 'package:flutter/material.dart';
import 'package:tsuperdriver/Components/GlobalVar.dart';
import 'package:tsuperdriver/Controller/Account/AccountVC.dart';
import 'package:tsuperdriver/Controller/Booking/BookingVC.dart';
import 'package:tsuperdriver/Controller/History/HistoryVC.dart';
import 'package:tsuperdriver/Controller/Home/HomeVC.dart';

import '../../Components/Colors-Design.dart';
import '../../Model/BookingModel.dart';
import '../../Model/NotificationModal.dart';
import '../../Server/Repo.dart';
import '../../main.dart';
import '../1. CommonUI/PromptModal.dart';
import '../Booking/Booking List View/FindBooking.dart';
import '../Home/Notification/Notif.dart';

part 'HomeTabbar_Menu_List.dart';
part 'HomeTabbar_API_Related.dart';

class HomeTabbarVC extends StatefulWidget {
  const HomeTabbarVC({super.key});


  @override
  State<HomeTabbarVC> createState() => _HomeTabbarVC();
}

class _HomeTabbarVC extends State<HomeTabbarVC> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;

  @override
  void initState() {
    Notif.initialize(flutterLocalNotificationsPlugin);
    
    // Create TabController for getting the index of current tab
    homeTabbarCtrlr = TabController(length: 4, vsync: this, initialIndex: 0);
    homeTabbarCtrlr.addListener(() {
      setState(() {
        selectedIndex = homeTabbarCtrlr.index;
        if (selectedIndex == 1){
          specialDriverBook = null;
          userData?.MemberType == "Driver" ?
          findPendingDriverBookingQueue(
            "${userData?.FirstName ?? ""} ${userData?.LastName ?? ""}", 
            (userData?.ID ?? 0).toString()
          ) :
          findPendingBooking(
            "${userData?.FirstName ?? ""} ${userData?.LastName ?? ""}", 
            (userData?.ID ?? 0).toString()
          );
        }
      });
    });

    fetchNotif();

    if ((userData?.MemberType ?? "") == "Driver") {
      countSpecialReqBooking();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
    tsuperHomeTabBar();
  }
  
  Widget tsuperHomeTabBar(){
    return 
    DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: gkGetColor(PickClr.tsuperTheme),
        ),
        bottomNavigationBar: tabBottomMenu(),
        body: 
        TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: homeTabbarCtrlr,
          children: [
            const HomeVC(),
            (userData?.MemberType != "Driver") ?
            BookingVC(
              homeTabbarCtrlr: homeTabbarCtrlr,
            ) : 
            const FindBooking(),

            const HistoryVC(),
            const AccountVC(),
          ]
        )
      )
    );
  }
}
