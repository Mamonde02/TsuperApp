part of 'HistoryVC.dart';

extension extHistoryAPI on _HistoryVC {
  void viewHistory() async {
    final params = {
      "isdriver": userData?.MemberType == "Driver" ? 1 : 0,
      "bookername": "${userData?.FirstName.toString()} ${userData?.LastName.toString()}",
      "bookerid": userData?.ID,
      "bookingtype": "Driver Booking",
      "month": getDateFromNOW("MM"),
      "year": getDateFromNOW("yyyy"),
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/viewHistory", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      allHistory = (jsonDecoded["data"] as List).map((e) => BookingHistoryDataModel.fromMap(e)).toList();
      allHistory.sort((a, b) {
        var adate = a.DateTimeIN;
        var bdate = b.DateTimeIN;
        return bdate.compareTo(adate);
      });
      refreshState();
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
}