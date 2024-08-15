part of 'BookingVC.dart';

extension extBookingAPIRealted on _BookingVC {
  void fetchAllBooking() async {
    Map<String, dynamic> params = {};

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/fetchAllBooking", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    if (status == "000"){
      final jsonData = jsonDecoded["data"];
      List<BookingDataModel> decodedData = (jsonData as List).map((e) => BookingDataModel.fromMap(e)).toList();
      decodedData.sort((a,b) => b.DateTimeIN.compareTo(a.DateTimeIN));

      allBookingData = decodedData;
      displayBookingData = decodedData;
      refreshState();

      if (!mounted) return;
      await Future.delayed(const Duration(seconds: 3));
      fetchAllBooking();
    }else{
      if (!mounted) return;
      showPromptModal(context, "error", message);
    }
  }
}