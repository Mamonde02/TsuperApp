import 'dart:convert';

class UserAccountDataModel {
  final int ID;
  String FirstName;
  String LastName;
  String Email;
  final String Password;
  String CurrentAddress;
  String PhoneNumber;
  String MemberType;
  String ProfilePic;
  final String LegalProofPhotos;
  final String Extra1;
  final String Extra2;

  late double distance = 0.0;

  UserAccountDataModel(
    this.ID, this.FirstName, this.LastName, 
    this.Email, this.Password, this.CurrentAddress, 
    this.PhoneNumber, this.MemberType, this.ProfilePic, 
    this.LegalProofPhotos, this.Extra1, this.Extra2);

  factory UserAccountDataModel.fromMap(Map<String, dynamic> data) {
    return
    UserAccountDataModel(
    data["ID"], data["FirstName"], data["LastName"], 
    data["Email"], data["Password"], data["CurrentAddress"], 
    data["PhoneNumber"], data["MemberType"], data["ProfilePic"],
    jsonEncode(data["LegalProofPhotos"]).toString(), data["Extra1"], data["Extra2"]);
  }
  
  Map<String, dynamic> toJson() => {
    'ID': ID, 'FirstName': FirstName,
    'LastName': LastName, 'Email': Email,
    'Password': Password, 'CurrentAddress': CurrentAddress,
    'PhoneNumber': PhoneNumber, 'MemberType': MemberType,
    'ProfilePic': ProfilePic, 'LegalProofPhotos': LegalProofPhotos,
    'Extra1': Extra1, 'Extra2': Extra2
  };
}