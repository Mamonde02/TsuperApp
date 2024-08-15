part of 'FindBooking.dart';

extension extAPIRelated on _FindBooking {
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
      final newDriver = allAvailableUser.map((e) {
        if (e!.CurrentAddress.contains(":::")) {
          final loc = e.CurrentAddress.split(":::");
          final lat1 = double.parse(loc[1]);
          final long1 = double.parse(loc[2]);

          final loc2 = e.CurrentAddress.split(":::");
          final lat2 = double.parse(loc2[1]);
          final long2 = double.parse(loc2[2]);

          final getDistance = Geolocator.distanceBetween(lat1, long1, lat2, long2);
          var item = e;
          item.distance = getDistance;
          return item;
        } else {
          return null;
        } 
      }).toList();
      newDriver.removeWhere((element) => element == null);
      
      newDriver.sort((a, b) {
        var adistance = a?.distance ?? 0.0;
        var bdistance = b?.distance ?? 0.0;
        return adistance.compareTo(bdistance);
      });

      newDriver.forEach((e) {
        print(e);
      });

      if (newDriver.isNotEmpty) {
        allAvailableUser = newDriver;
      } else {
        allAvailableUser = [];
      }

      refreshState();
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
  
  void specialBookingList() async {
    final params = {
      "id": userData?.ID.toString()
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/specialBookingList", {}, params);

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
      specialBookingList();
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
  
  void cancelSpecialBooking(int i) async {
    final params = {
      "transactionNo": allHistory[i].TransactionNo
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/cancelSpecialBooking", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (!mounted) return;

    if (status == "000"){
      allHistory.removeWhere((e) => e.TransactionNo.contains(allHistory[i].TransactionNo));
      refreshState();
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
  
  void acceptSpecialBooking(int i) async {
    final params = {
      "transactionNo": allHistory[i].TransactionNo
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/acceptSpecialBooking", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (!mounted) return;

    if (status == "000"){
      Navigator.of(context).pop("ACCEPTED");
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
}