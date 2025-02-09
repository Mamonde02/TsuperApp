import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/GlobalVar.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/BackNavigation.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/EmptyView.dart';
import 'package:tsuperdriver/Controller/Home/AcceptBooking/AcceptBooking.dart';
import 'package:tsuperdriver/Model/Account/AccoutModel.dart';

import '../../../Components/CommonFunc.dart';
import '../../../Model/BookingModel.dart';
import '../../../Server/Repo.dart';
import '../../1. CommonUI/CustomIcon.dart';
import '../../1. CommonUI/PromptModal.dart';
import '../Waiting For Driver/WaitingForDriver.dart';

part 'FindBooking_API_Related.dart';
part 'FindBooking_ListView.dart';
part 'FindBooking_BookButton.dart';

class FindBooking extends StatefulWidget {
  const FindBooking({super.key});

  @override
  State<FindBooking> createState() => _FindBooking();
}

class _FindBooking extends State<FindBooking> {
  List<FindBookingHistoryDataModel> allHistory = [];
  List<UserAccountDataModel> allAvailableUser = [];

  @override
  void initState() {
    findBookingList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      backgroundColor: gkGetColor(PickClr.gkBGStyle2),
      appBar: backNavigation(context, "Booking"),

      body: 
      ((pendingBookingInfo?.BookerID != null) && (pendingBookingInfo?.BookerID != "")) ? 
      WaitingForDriver(callback: refreshState) :
      findBookingListVIEW(),
    );
  }

  void refreshState() => setState(() {});
}