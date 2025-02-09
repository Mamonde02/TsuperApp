import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/GlobalVar.dart';
import 'package:tsuperdriver/Model/Account/AccoutModel.dart';

import '../../../Components/CommonFunc.dart';
import '../../../Model/BookingModel.dart';
import '../../../Server/Repo.dart';
import '../../1. CommonUI/BackNavigation.dart';
import '../../1. CommonUI/CustomIcon.dart';
import '../../1. CommonUI/EmptyView.dart';
import '../../1. CommonUI/PromptModal.dart';
import '../../Booking/BookingVC.dart';
import '../Driver Reviews/DriverReviewsVC.dart';

part 'FindBooking_API_Related.dart';
part 'FindBooking_ListView.dart';
part 'FindBooking_BookButton.dart';
part 'FindBooking_Req_ListView.dart';

class FindBooking extends StatefulWidget {
  const FindBooking({super.key});

  @override
  State<FindBooking> createState() => _FindBooking();
}

class _FindBooking extends State<FindBooking> {
  List<UserAccountDataModel?> allAvailableUser = [];
  List<FindBookingHistoryDataModel> allHistory = [];

  @override
  void initState() {
    if ((userData?.MemberType ?? "") == "Driver") {
      specialBookingList();
    } else {
      // fetchAllUsers();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: backNavigation(context, userData?.MemberType == "Driver" ? "Find a Client" : "Find a Driver"),
      backgroundColor: gkGetColor(PickClr.gkBGStyle2),

      body: 
      userData?.MemberType != "Driver" ?
      findBookingListVIEW() :
      requestBookingListVIEW()
    );
  }

  void refreshState() => setState(() {});
}