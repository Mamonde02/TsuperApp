import 'package:flutter/material.dart';
import 'package:tsuperdriver/Model/Account/AccoutModel.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../Model/BookingModel.dart';
import '../Model/NotificationModal.dart';

UserAccountDataModel? userData;
late TabController homeTabbarCtrlr;
var typeOfApplication = "";

FindBookingHistoryDataModel? pendingBookingInfo;
DriverBookingQueueDataModel? pendingDriverBookingInfo;

FindBookingHistoryDataModel? specialPendingBookingInfo;
DriverBookingQueueDataModel? specialpendingDriverBookingInfo;
UserAccountDataModel? specialDriverBook;
double specialServiceFee = 0.0;

List<NotifListDataModel> allNotif = [];
final allNotifCount = ValueNotifier<int?>(0);
final allSpecialReq = ValueNotifier<int?>(0);

int starRating = 0;

List<String> declineMatching = [];

// const String apiLink = "http://192.168.0.106:8089/";
const String apiLink = kIsWeb ? "http://localhost:8089/" : "http://10.0.2.2:8089/";