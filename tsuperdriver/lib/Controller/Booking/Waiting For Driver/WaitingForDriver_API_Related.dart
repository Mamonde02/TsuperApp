part of 'WaitingForDriver.dart';

extension extAPIRelated on _WaitingForDriver {
  void findDriverBookingQueue() async {
    final params = {
      "bookingID": pendingBookingInfo?.TransactionNo.toString()
    };
    
    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/findDriverBookingQueue", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      driverQueue = (jsonDecoded["data"] as List).map((e) => DriverBookingQueueDataModel.fromMap(e)).toList();

      if (!mounted) return;
      refreshState();
      if (pendingBookingInfo?.Status == "BOOKED"){
        driverQueue = [];
        return;
      }
      
      await Future.delayed(const Duration(seconds: 5));
      findDriverBookingQueue();

    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
  
  void cancelWaitingBooking({bool isDecline = false, int i = 0}) async {
    var params = {
      "memberType": userData?.MemberType.toString(),
      "transactionNo": pendingBookingInfo?.TransactionNo.toString(),
      "userID": userData?.ID.toString(),
      "userName": "${userData?.FirstName ?? ""} ${userData?.LastName ?? ""}"
    };

    if (isDecline) {
      params = {
        "memberType": "Driver",
        "transactionNo": pendingBookingInfo?.TransactionNo.toString(),
        "userName": driverQueue[i].DriverName,
        "userID": driverQueue[i].DriverID.toString()
      };
    }

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/cancelWaitingBooking", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000") {
      if (!isDecline) {
        pendingDriverBookingInfo = null;
        pendingBookingInfo = null;
        pendingBookingInfo?.BookerID = "";

        widget.callback();
      }

      if (isDecline) {
        driverQueue.removeAt(i);
      }

    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
  
  void selectDriverReq(int i, String statusVal) async {
    if (pendingBookingInfo?.Status != "PENDING"){
      driverQueue = [pendingDriverBookingInfo!];
    }

    final params = {
      "driverID": driverQueue[i].DriverID.toString(),
      "driverName": driverQueue[i].DriverName.toString(),
      "serviceFee": driverQueue[i].ServiceFee.toString(),
      "bookingID": pendingBookingInfo?.TransactionNo.toString(),
      "status": statusVal
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/selectDriverReq", {}, params);
    
    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      if (statusVal == "ARRIVED") {
        pendingBookingInfo?.Status = "BOOKED";
        pendingDriverBookingInfo?.Status = "BOOKED";
      }

      if (statusVal == "BOOKED") {
        pendingBookingInfo?.Status = "BOOKED";
        driverQueue[i].Status = "ARRIVING";
        pendingDriverBookingInfo = driverQueue[i];
        return;
      }
      
      if (statusVal == "COMPLETE") {
        pendingBookingInfo?.Status = "COMPLETE";
        driverQueue[i].Status = "COMPLETE";
        showCompleteTrxnModalView();
        return;
      }

      driverQueue[i].Status = "DECLINED";
      refreshState();

    } else {
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
  
  void checkDriverBookingQueueStatus(String trxnNO, String driverName, String driverID) async {
    final params = {
      "trxnNO": trxnNO,
      "driverName": driverName,
      "driverID": driverID
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/checkDriverBookingQueueStatus", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    pendingDriverBookingInfo = null;
    if (!mounted) return;

    if (status == "000"){
      if (jsonDecoded["data"] == null) {
        pendingBookingInfo = null;
        pendingDriverBookingInfo = null;
        driverQueue = [];
        refreshState();
        return;
      }

      pendingDriverBookingInfo = DriverBookingQueueDataModel.fromMap(jsonDecoded["data"]);
      final statusVal = pendingDriverBookingInfo?.Status ?? ".";
      driverQueue = [pendingDriverBookingInfo!];
      if (statusVal == "CANCELLED") {
        pendingBookingInfo = null;
        pendingDriverBookingInfo = null;
        driverQueue = [];
        refreshState();
        return;
      }

      if (statusVal == "COMPLETE") {
        pendingBookingInfo?.Status = "COMPLETE";
        showCompleteTrxnModalView();
        return;
      }

      refreshState();
      await Future.delayed(const Duration(seconds: 5));
      checkDriverBookingQueueStatus(trxnNO, driverName, driverID);

    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }

  void insertMatchMsg(int i) async {
    final params = {
      "trxnID": pendingBookingInfo?.TransactionNo.toString(),
      "clientName": "${userData?.FirstName ?? ""} ${userData?.LastName ?? ""}",
      "driverName": driverQueue[i].DriverName.toString(),
      "location": pendingBookingInfo?.Locations.toString(),
      "schedule": "${pendingBookingInfo?.DateStart ?? ""} - ${pendingBookingInfo?.DateEnd ?? ""}"
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/insertMatchMsg", {}, params);
    
    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){

    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
}