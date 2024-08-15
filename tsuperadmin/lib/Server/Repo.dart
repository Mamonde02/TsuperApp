import 'package:dio/dio.dart';

import '/Server/Utility.dart';

class RepoClass {
  late didStartCallAPI mClient1;
  RepoClass() {
    mClient1 = didStartCallAPI(Dio());
  }

  String callName = '';
  List indexVal = [];
  String authentication = '';
  String key = '';
  String encryptedData = '';
  String decryptedData = '';

  Future<Map<String,dynamic>> didStart_CallAPI(
    String endpoint, 
    Map<String, dynamic> headers,
    Map<String, dynamic> params) async {

    return mClient1.postAPI(headers, params, endpoint);
  }
}
