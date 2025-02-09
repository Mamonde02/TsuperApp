
import 'package:retrofit/retrofit.dart';

class BookingHistoryDataModel {
  String TransactionNo;
  String DateTimeIN;
  String Locations;
  double TotalAmount;
  double Distance;
  String BookerName;
  String BookerID;
  String TypeOfService;
  String Status;
  String? Extra4;

  BookingHistoryDataModel(
    this.TransactionNo, this.DateTimeIN, 
    this.Locations, this.TotalAmount, 
    this.Distance, this.BookerName,
    this.BookerID, this.TypeOfService, 
    this.Status, this.Extra4
  );

  factory BookingHistoryDataModel.fromMap(Map<String, dynamic> data) {
    return
    BookingHistoryDataModel(
      data["TransactionNo"], data["DateTimeIN"], 
      data["Locations"], double.parse("${data["TotalAmount"]}"),
      double.parse("${data["Distance"]}"),  data["BookerName"], data["BookerID"],
      data["TypeOfService"], data["Status"], data["Extra4"]
    );
  }
}

class FindBookingHistoryDataModel {
  String TransactionNo;
  String DateTimeIN;
  String Locations;
  double TotalAmount;
  String? DateStart;
  String? DateEnd;
  int? Days;
  double Distance;
  String BookerName;
  String PaymentMethod;
  String BookerID;
  String TypeOfService;
  String Remarks;
  String Status;
  String? Extra1;
  String? Extra2;
  String? Extra3;
  String? Extra4;

  FindBookingHistoryDataModel(
    this.TransactionNo, this.DateTimeIN, 
    this.Locations, this.TotalAmount, 
    this.DateStart, this.DateEnd, this.Days,
    this.Distance, this.PaymentMethod,
    this.BookerName, this.BookerID, 
    this.TypeOfService, this.Remarks,
    this.Status, 
    this.Extra1, this.Extra2, this.Extra3, this.Extra4
  );

  factory FindBookingHistoryDataModel.fromMap(Map<String, dynamic> data) {
    return
    FindBookingHistoryDataModel(
      data["TransactionNo"], data["DateTimeIN"], 
      data["Locations"], double.parse("${data["TotalAmount"]}"),
      data["DateStart"] ?? "", data["DateEnd"] ?? "", data["Days"] ?? 0, 
      double.parse("${data["Distance"]}"), data["PaymentMethod"],
      data["BookerName"], data["BookerID"],
      data["TypeOfService"], data["Remarks"],
      data["Status"], 
      data["Extra1"], data["Extra2"], data["Extra3"], data["Extra4"]
    );
  }
}

class BookingDataModel {
  int ID;
  String TransactionNo;
  String DateTimeIN;
  String Locations;
  double TotalAmount;
  double Distance;
  String BookerName;
  String BookerID;
  String TypeOfService;
  String? Extra2;
  String? Extra3;
  String Status;

  BookingDataModel(
    this.ID,
    this.TransactionNo, this.DateTimeIN, 
    this.Locations, this.TotalAmount, 
    this.Distance, this.BookerName,
    this.BookerID, this.TypeOfService, 
    this.Extra2, this.Extra3, 
    this.Status
  );

  factory BookingDataModel.fromMap(Map<String, dynamic> data) {
    return
    BookingDataModel(
      data["ID"],
      data["TransactionNo"], data["DateTimeIN"], 
      data["Locations"], double.parse("${data["TotalAmount"]}"),
      double.parse("${data["Distance"]}"),  data["BookerName"], data["BookerID"],
      data["TypeOfService"], data["Extra2"], data["Extra3"], data["Status"]
    );
  }
}

class DriverBookingQueueDataModel {
  int ID;
  int DriverID;
  String DriverName;
  String ProfilePic;
  String BookingID;
  int BookerID;
  String BookerName;
  double ServiceFee;
  String Status;

  DriverBookingQueueDataModel(
  this.ID, this.DriverID, this.DriverName,
  this.ProfilePic, this.BookingID, this.BookerName,
  this.BookerID, this.ServiceFee, this.Status);

  factory DriverBookingQueueDataModel.fromMap(Map<String, dynamic> data) {
    return
    DriverBookingQueueDataModel(
      data["ID"],
      data["DriverID"], data["DriverName"], 
      data["ProfilePic"], data["BookingID"], data["BookerName"],
      data["BookerID"], double.parse("${data["ServiceFee"] ?? 0}"), 
      data["Status"]
    );
  }
}

class DriverRatingReviewDataModal {
  int ID;
  String DateTimeIN;
  String DriverName;
  int DriverID;
  String ClientName;
  int Rate;
  String Comment;

  DriverRatingReviewDataModal(
  this.ID, this.DateTimeIN, 
  this.DriverName, this.DriverID,
  this.ClientName, this.Rate, this.Comment);

  factory DriverRatingReviewDataModal.fromMap(Map<String, dynamic> data) {
    return
    DriverRatingReviewDataModal(
      data["ID"], data["DateTimeIN"],
      data["DriverName"], data["DriverID"], 
      data["ClientName"], data["Rate"], data["Comment"]
    );
  }
}