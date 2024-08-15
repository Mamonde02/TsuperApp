part of 'GenerateReportVC.dart';

extension extGenerateCommon on _GenerateReportVC {
  List<String> months() {
    return
    [
      "January","February","March",
      "April","May","June","July",
      "August","September",
      "October","November","December"
    ];
  }

  String returnMonthVal(String month){
    switch (month) {
      case "January": return "01";
      case "February": return "02";
      case "March": return "03";
      case "April": return "04";
      case "May": return "05";
      case "June": return "06";
      case "July": return "07";
      case "August": return "08";
      case "September": return "09";
      case "October": return "10";
      case "November": return "11";
      case "December": return "12";
      default: return "01";
    }
  }

  List<String> year() {
    return
    [
      "2023","2022",
      "2021","2020"
    ];
  }
}