import '../Components/GlobalVar.dart';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '/Model/APIResponse/APIDataModel.dart';


part 'Utility.g.dart';

@RestApi(baseUrl: apiLink)
abstract class didStartCallAPI {
  factory didStartCallAPI(Dio dio) = _didStartCallAPI;

  @POST("POST")
  @FormUrlEncoded()
  Future<Map<String,dynamic>> postAPI(
      Map<String, dynamic> headers,
      Map<String, dynamic> param,
      String endPoint);
}