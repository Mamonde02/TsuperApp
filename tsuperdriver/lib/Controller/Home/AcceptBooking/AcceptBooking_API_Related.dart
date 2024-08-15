part of 'AcceptBooking.dart';

extension extAPIRelated on _AcceptBookingVC {
  void acceptBookingReqNow() async {
    final scFee = serviceFeeTxtController.text.isEmpty ? 0.00 : double.parse(serviceFeeTxtController.text);
    final params = {
      "driverID": userData?.ID.toString(),
      "driverName": "${userData?.FirstName ?? ""} ${userData?.LastName ?? ""}",
      "profilePic": userData?.ProfilePic.toString(),
      "serviceFee": scFee,
      "bookerName": widget.selectedBook.BookerName.toString(),
      "bookerID": widget.selectedBook.BookerID.toString(),
      "bookingID": widget.selectedBook.TransactionNo.toString()
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/acceptBookingReqNow", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      Notif.showBigTextNotification(title: "Tsuper App", body: "Successfully Request. Please wait for response.", fln: flutterLocalNotificationsPlugin);
      if (!mounted) return;
      Navigator.of(context).pop("APPLY");
      
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
}