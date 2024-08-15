class NotifListDataModel {
  int ID;
  String DateTimeIN;
  int UserID;
  String Msg;
  String Type;
  String IsReceived;
  String Status;
  String Viewer;

  NotifListDataModel(
    this.ID, this.DateTimeIN, 
    this.UserID, this.Msg,
    this.Type, this.IsReceived,
    this.Status, this.Viewer
  );
  
  factory NotifListDataModel.fromMap(Map<String, dynamic> data) {
    return
    NotifListDataModel(
      data["ID"], data["DateTimeIN"], 
      data["UserID"], data["Msg"],
      data["Type"], data["IsReceived"],
      data["Status"], data["Viewer"]
    );
  }
}