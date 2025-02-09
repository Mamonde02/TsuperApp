part of 'BookingDetails.dart';

extension extBookingDetails on _BookingDetails {
  void dismissLoadingView(){
    Navigator.of(context).pop();
  }

  void insertBooking() async {
    var locations = "";
    if (widget.confirmationData["TypeService"] == "DropOff" || widget.confirmationData["TypeService"] == "RoundTrip"){
      locations = "${widget.confirmationData["PickUp"]}##${widget.confirmationData["DropOff"]}";
    }else{
      for (var e in widget.locations) {
        locations += locations == "" ? e : "##$e";
      }
    }
    
    final serviceType = widget.confirmationData["TypeService"];
    final multiPlier = serviceType == "RoundTrip" ? 2 : 1;
    final bookerName = "${userData?.FirstName ?? ""} ${userData?.LastName ?? ""}";
    final params = {
      "bookername": bookerName,
      "bookerid": userData?.ID,
      "locations": locations,
      "datestart": widget.confirmationData["DateStart"],
      "dateend": widget.confirmationData["DateEnd"],
      "days": widget.confirmationData["Days"],
      "typeservice": widget.confirmationData["TypeService"],
      "bookingtype": "$typeOfApplication Booking",
      "totalamount": convertCurrencyNoSymbol(totalAmount).replaceAll(",", ""),
      "distance": ((distance / 1000) * multiPlier).toStringAsFixed(2).replaceAll(",", ""),
      "carinfo": userData?.LegalProofPhotos ?? "",
      "paymentmethod": "Cash",
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/insertBooking", {}, params);

    dismissLoadingView();
    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      pendingBookingInfo = FindBookingHistoryDataModel(
        jsonDecoded["data"].toString(), "00000", 
        locations, totalAmount, widget.confirmationData["DateStart"],
        widget.confirmationData["DateEnd"], widget.confirmationData["Days"],
        double.parse(((distance / 1000) * multiPlier).toStringAsFixed(2)), 
        "Cash", bookerName, (userData?.ID ?? 0).toString(), 
        widget.confirmationData["TypeService"], "", "PENDING", "", "", "", ""
      );
      
      Notif.showBigTextNotification(title: "Successfully Booked!", 
      body: "You successfully choose the ${widget.confirmationData["TypeService"]}.", 
      fln: flutterLocalNotificationsPlugin);

      if (!mounted) return;
      showPromptModal(context, "success", "Successfully Booked!")
      .then((value) => {
        Navigator.of(context).pop("COMPLETE")
      });
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }

  
  void specialBooking() async {
    var locations = "";
    if (widget.confirmationData["TypeService"] == "DropOff" || widget.confirmationData["TypeService"] == "RoundTrip"){
      locations = "${widget.confirmationData["PickUp"]}##${widget.confirmationData["DropOff"]}";
    }else{
      for (var e in widget.locations) {
        locations += locations == "" ? e : "##$e";
      }
    }
    
    final serviceType = widget.confirmationData["TypeService"];
    final multiPlier = serviceType == "RoundTrip" ? 2 : 1;
    final bookerName = "${userData?.FirstName ?? ""} ${userData?.LastName ?? ""}";
    final driverName = "${specialDriverBook?.FirstName ?? ""} ${specialDriverBook?.LastName ?? ""}";
    final params = {
      "bookername": bookerName,
      "bookerid": userData?.ID,
      "locations": locations,
      "datestart": widget.confirmationData["DateStart"],
      "dateend": widget.confirmationData["DateEnd"],
      "days": widget.confirmationData["Days"],
      "typeservice": widget.confirmationData["TypeService"],
      "bookingtype": "$typeOfApplication Booking",
      "totalamount": convertCurrencyNoSymbol(totalAmount).replaceAll(",", ""),
      "distance": ((distance / 1000) * multiPlier).toStringAsFixed(2).replaceAll(",", ""),
      "carinfo": userData?.LegalProofPhotos ?? "",
      "paymentmethod": "Cash",
      "serviceFee": convertCurrencyNoSymbol(specialServiceFee).replaceAll(",", ""),
      "driverID": specialDriverBook?.ID.toString(),
      "driverName": driverName,
      "profilePic": specialDriverBook?.ProfilePic
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/specialBooking", {}, params);

    dismissLoadingView();
    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      pendingBookingInfo = FindBookingHistoryDataModel(
        jsonDecoded["data"].toString(), "00000", 
        locations, totalAmount, widget.confirmationData["DateStart"],
        widget.confirmationData["DateEnd"], widget.confirmationData["Days"],
        double.parse(((distance / 1000) * multiPlier).toStringAsFixed(2)), 
        "Cash", bookerName, (userData?.ID ?? 0).toString(), 
        widget.confirmationData["TypeService"], "", "PENDING", "", "", "",""
      );
      
      Notif.showBigTextNotification(title: "Successfully Booked!", 
      body: "You successfully choose the ${widget.confirmationData["TypeService"]}.", 
      fln: flutterLocalNotificationsPlugin);

      if (!mounted) return;
      showPromptModal(context, "success", "Successfully Booked!")
      .then((value) => {
        Navigator.of(context).pop("COMPLETE")
      });
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
}