part of 'DriverReviewsVC.dart';

extension extAPIRelated on _DriverReviewsVC {
  void fetchReviewRating() async {
    final params = {
      "driverID": widget.driverInfo.ID.toString(),
      "driverName": "${widget.driverInfo.FirstName} ${widget.driverInfo.LastName}",
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/fetchReviewRating", {}, params);

    final status = jsonDecoded["status"].toString();
    final data = jsonDecoded["data"];
    if (status == "000"){
      if (data == null) {
        refreshState();
        return;
      }

      reviewsData = (data as List).map((e) => DriverRatingReviewDataModal.fromMap(e)).toList();
      reviewsData.sort((a, b) {
        var adate = a.DateTimeIN;
        var bdate = b.DateTimeIN;
        return bdate.compareTo(adate);
      });
      refreshState();
    }
  }
}