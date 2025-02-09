import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tsuperdriver/Controller/Login/LoginVC.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'GlobalVar.dart';

Widget spacer(double height){
  return
  SizedBox(height: height);
}

Route createRoute(Widget page, {bool isOpaue = true}) {
  const begin = Offset(1.0, 0.0);
  const end = Offset.zero;
  const curve = Curves.ease;
  return PageRouteBuilder(
    opaque: isOpaue,
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}

String getDateFromNOW(String dateFormat) {
  return DateFormat(dateFormat).format(DateTime.now());
}

void appLogout(BuildContext context, bool mounted) async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  pendingBookingInfo = null;
  pendingDriverBookingInfo = null;
  sharedPref.remove("isAlreadyLoggin");

  if (typeOfApplication == "Driver") {
    if (mounted) {
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
        builder: (BuildContext context1) => const LoginVC()),
      (route) => false);
    }
  } else {
    if (mounted) {
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
        builder: (BuildContext context1) => const LoginVC()),
      (route) => false);
    }
  }
}

String convertCurrencyNoSymbol(double amount) {
  var numFormat = NumberFormat("#,##0", "en_US");
  return numFormat.format(amount);
}

String formatDateTimeFromDatePicker(String dateFormat, DateTime date) {
  var outputDate = "";
  var outputFormat = DateFormat(dateFormat);
  outputDate = outputFormat.format(date);

  return outputDate;
}

String formatDateFromDB(String dateFormat, String date) {
  var outputDate = "";

  if (date != ".") {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:SS.sssZ").parse(date, true).toLocal();
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat(dateFormat);
    outputDate = outputFormat.format(inputDate);
  }

  return outputDate;
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}