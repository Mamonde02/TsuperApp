part of 'FindBooking.dart';

extension extAPIRelated on _FindBooking {
  void findBookingList() async {
    final params = {
      "bookingtype": "${(userData?.MemberType ?? ".")  != "Driver" ? "Car Owner" : "Driver"} Booking"
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/findBookingList", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (!mounted) return;

    if (status == "000"){
      allHistory = (jsonDecoded["data"] as List).map((e) => FindBookingHistoryDataModel.fromMap(e)).toList();
      allHistory.sort((a, b) {
        var adate = a.DateTimeIN;
        var bdate = b.DateTimeIN;
        return bdate.compareTo(adate);
      });

      allHistory.removeWhere((element) => element.Status == "COMPLETE" || element.Status == "BOOKED");
      allHistory.removeWhere((element) => element.Remarks.contains(":${userData?.ID.toString()}"));
      refreshState();

      await Future.delayed(const Duration(seconds: 5));
      findBookingList();
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }

  void fetchAllUsers() async {
    final params = {
      "memberType": userData?.MemberType
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/fetchAllUsers", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      allAvailableUser = (jsonDecoded["data"] as List).map((e) => UserAccountDataModel.fromMap(e)).toList();

      refreshState();
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
}