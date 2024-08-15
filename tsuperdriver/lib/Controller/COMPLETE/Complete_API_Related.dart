part of 'CompleteVC.dart';

extension extAPIRelated on CompleteTrxn {
  void rateDriver(BuildContext context) async {
    final params = {
      "driverID": pendingDriverBookingInfo?.DriverID ?? "",
      "driverName": pendingDriverBookingInfo?.DriverName ?? "",
      "clientName": userData?.FirstName ?? "",
      "rate": starRating + 1,
      "comment": commentTxtController.text.isEmpty ? "" : commentTxtController.text
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/rateDriver", {}, params);

    final status = jsonDecoded["status"].toString();
    if (status == "000"){
        pendingBookingInfo = null;
        pendingDriverBookingInfo = null;
        if (!context.mounted) return;
        Navigator.of(context).pop("CLOSE");
    }
  }
}