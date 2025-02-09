part of 'HomeTabbarVC.dart';

extension extAPIRelated on _HomeTabbarVC {
  void findPendingBooking(String bookerName, String bookerID) async {
    final params = {
      "bookername": bookerName,
      "bookerid": bookerID
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/findPendingBooking", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();

    pendingBookingInfo = null;
    if (status == "000"){
      if (jsonDecoded["data"] == null) {
        return;
      }

      pendingBookingInfo = FindBookingHistoryDataModel.fromMap(jsonDecoded["data"]);
      if (
        (pendingBookingInfo?.Status == "BOOKED" && userData?.MemberType != "Driver") ||
        (pendingBookingInfo?.Status == "SPECIAL" && userData?.MemberType != "Driver")
      ){
        findPendingDriverBookingQueue(pendingBookingInfo?.Extra3 ?? "".toString(), pendingBookingInfo?.Extra2 ?? "".toString());
      }
      
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
  
  void findPendingDriverBookingQueue(String driverName, String driverID) async {
    final params = {
      "driverName": driverName,
      "driverID": driverID
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/findPendingDriverBookingQueue", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();

    pendingDriverBookingInfo = null;
    if (status == "000"){
      if (jsonDecoded["data"] == null) {
        pendingBookingInfo = null;
        return;
      }
      pendingDriverBookingInfo = DriverBookingQueueDataModel.fromMap(jsonDecoded["data"]);
      if (userData?.MemberType == "Driver" && pendingDriverBookingInfo?.DriverID != null) {
        findPendingBooking(pendingDriverBookingInfo?.BookerName ?? "", (pendingDriverBookingInfo?.BookerID ?? 0).toString());
      }

    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }

  void fetchNotif() async {
    final params = {
      "userID": userData?.ID.toString(),
      "membertype": userData?.MemberType.toString()
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/fetchNotif", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();

    allNotif = [];
    if (status == "000"){
      allNotif = (jsonDecoded["data"] as List).map((e) => NotifListDataModel.fromMap(e)).toList();
      allNotif = allNotif.map((e) {
        var item = e;
        final arrViewerList = e.Viewer.split(",");
        if (arrViewerList.contains(userData?.ID.toString())) {
          item.Status = "NOT";
          return item;
        } else {
          return item;
        }
      }).toList();
      allNotifCount.value = allNotif.where((e) => e.Status != "NOT").toList().length;

      for (var e in allNotif) {
        final receivedArr = e.IsReceived.split(",");
        if (!receivedArr.contains(userData?.ID.toString())) {
          updateIsReceivedNotif(e.ID.toString());
          if (e.Type == "Driver") {
            if (e.Msg.contains("##")) {
              final msgArr = e.Msg.split("##");
              Notif.showBigTextNotification(title: "Tsuper App", body: msgArr[1], fln: flutterLocalNotificationsPlugin);
            }
          }

          if (e.Type == ".") {
            Notif.showBigTextNotification(title: "Tsuper App", body: e.Msg, fln: flutterLocalNotificationsPlugin);
          }
        }
      }
      allNotif.sort((a, b) {
        var adate = a.DateTimeIN;
        var bdate = b.DateTimeIN;
        return bdate.compareTo(adate);
      });

      if (mounted) {
        setState(() {});
      }
      await Future.delayed(const Duration(milliseconds: 3500));
      fetchNotif();

    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }

  void updateIsReceivedNotif(String ID) async {
    final params = {
      "userID": userData?.ID.toString(),
      "ID": ID
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/updateIsReceivedNotif", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();

    if (status == "000"){

    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }

  void countSpecialReqBooking() async {
    final params = {
      "id": userData?.ID.toString(),
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/countSpecialReqBooking", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    final data = jsonDecoded["data"].toString();

    if (status == "000"){
      allSpecialReq.value = int.parse(data ?? "0");
      if (mounted) {
        setState(() {});
      }
      await Future.delayed(const Duration(milliseconds: 4000));
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
}