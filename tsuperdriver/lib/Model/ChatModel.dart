class ChatSupportDataModel {
  int ID;
  String DateTimeIN;
  String SupportID;
  String TitleTopic;
  String SenderID;
  String SenderName;
  String Status;
  String SupportStatus;

  ChatSupportDataModel(this.ID, this.DateTimeIN, 
    this.SupportID, this.TitleTopic, 
    this.SenderID, this.SenderName, 
    this.Status, this.SupportStatus);

  factory ChatSupportDataModel.fromMap(Map<String, dynamic> data) {
    return
    ChatSupportDataModel(
      data["ID"],
      data["DateTimeIN"], data["SupportID"],
      data["TitleTopic"], data["SenderID"],
      data["SenderName"], data["Status"], data["SupportStatus"]
    );
  }
}

class ChatConversationDataModel {
  int ID;
  String DateTimeIN;
  String SenderName;
  String SenderID;
  String RecieverID;
  String Message;
  String SupportID;
  String TitleTopic;

  ChatConversationDataModel(
    this.ID, this.DateTimeIN, 
    this.SenderName, this.SenderID, 
    this.RecieverID, this.Message, 
    this.SupportID, this.TitleTopic
  );
  
  factory ChatConversationDataModel.fromMap(Map<String, dynamic> data) {
    return
    ChatConversationDataModel(
      data["ID"], data["DateTimeIN"], 
      data["SenderName"], data["SenderID"], 
      data["RecieverID"], data["Message"], 
      data["SupportID"], data["TitleTopic"]
    );

  }
}

class MatchChatConversationDataModel {
  int ID;
  String DateTimeIN;
  String TransactionID;
  String ReceiverID;
  String Message;
  String SenderID;

  MatchChatConversationDataModel(
    this.ID, this.DateTimeIN, 
    this.TransactionID, this.ReceiverID, 
    this.Message, this.SenderID
  );
  
  factory MatchChatConversationDataModel.fromMap(Map<String, dynamic> data) {
    return
    MatchChatConversationDataModel(
      data["ID"], data["DateTimeIN"], 
      data["TransactionID"], data["ReceiverID"], 
      data["Message"], data["SenderID"]
    );
  }
}

class MatchChatListDataModel {
  int ID;
  String DateTimeIN;
  String TransactionNo;
  String ClientName;
  String DriverName;
  String Location;
  String Schedule;
  String Status;
  int UNRead;
  int DriverUNRead;

  MatchChatListDataModel(
    this.ID, this.DateTimeIN, 
    this.TransactionNo, this.ClientName,
    this.DriverName, this.Location,
    this.Schedule, this.Status, 
    this.UNRead, this.DriverUNRead
  );
  
  factory MatchChatListDataModel.fromMap(Map<String, dynamic> data) {
    return
    MatchChatListDataModel(
      data["ID"], data["DateTimeIN"], 
      data["TransactionNo"], data["ClientName"],
      data["DriverName"], data["Location"],
      data["Schedule"], data["Status"],
      data["UNRead"], data["DriverUNRead"]
    );
  }
}