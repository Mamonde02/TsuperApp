import 'package:flutter/material.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/PromptModal.dart';
import 'package:tsuperdriver/Model/BookingModel.dart';
import 'package:intl/intl.dart';

import '../../../Server/Repo.dart';

part 'GenerateReport_ListView.dart';
part 'GenerateReport_CommonFunc.dart';
part 'GenerateReport_DropDown.dart';
part 'GenerateReport_API.dart';
part 'GenerateReport_RevenueView.dart';

class GenerateReportVC extends StatefulWidget {
  List<BookingDataModel> allBookingData;

  GenerateReportVC({
    super.key,
    required this.allBookingData
  });
  
  @override
  State<GenerateReportVC> createState() => _GenerateReportVC();
}

class _GenerateReportVC extends State<GenerateReportVC> {
  var displayBookingData = [];
  List<String> arrVal = [];
  List<String> arrType = ["Daily","Weekly","Monthly", "Annual"];

  bool isHasValType = false;
  String type = "Daily";
  String? valtype;
  double totalRevenue = 0.0;
  var dateNeeded = getDateFromNOW("MM/dd/yyyy");

  @override
  void initState() {
    displayBookingData.addAll(widget.allBookingData);
    displayBookingData.removeWhere((e) {
      final date = formatDateFromDB("MM/dd/yyyy", e.DateTimeIN);
      if (date != dateNeeded) {
        return true;
      }
      return false;
    });

    for (var e in displayBookingData) {
      totalRevenue += e.TotalAmount;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: gkGetColor(PickClr.gkBtnColor),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                child: dropDownContainerVIEW()
              ),
              
              const SizedBox(width: 15),
              SizedBox(
                width: 200,
                child: dropDownContainerVIEW(isActive: isHasValType, isValueType: true)
              )
            ],
          ),
        ),
        revenueView(),
        
        bookingListVIEW() 
      ],
    );
  }
  
  void refreshState() => setState(() {});
}