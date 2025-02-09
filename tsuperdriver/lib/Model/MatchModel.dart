class GetMatchDataModel {
  int ID;
  int DriverID;
  String DriverName;
  int UserID;
  String UserName;
  String Status;

  GetMatchDataModel(
    this.ID, this.DriverID, 
    this.DriverName, this.UserID, 
    this.UserName, this.Status);

  factory GetMatchDataModel.fromMap(Map<String, dynamic> data) {
    return
    GetMatchDataModel(
      data["ID"], data["DriverID"], 
      data["DriverName"], data["UserID"],
      data["UserName"], data["Status"]
    );
  }
}

class GetMatchQueueDataModel {
  int ID;
  String DateTimeIN;
  int ClientID;
  String ClientName;
  String CarModel;
  String Transmission;
  String CurrentLocation;
  String Status;

  late double distance = 0.0;

  GetMatchQueueDataModel(
    this.ID, this.DateTimeIN, 
    this.ClientID, this.ClientName, 
    this.CarModel, this.Transmission,
    this.CurrentLocation, this.Status);

  factory GetMatchQueueDataModel.fromMap(Map<String, dynamic> data) {
    return
    GetMatchQueueDataModel(
      data["ID"], data["DateTimeIN"], 
      data["ClientID"], data["ClientName"],
      data["CarModel"], data["Transmission"],
      data["CurrentLocation"], data["Status"]
    );
  }
}