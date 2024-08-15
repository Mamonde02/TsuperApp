// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Utility.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// API no SESSION
class _didStartCallAPI implements didStartCallAPI {
  _didStartCallAPI(this._dio) {
    baseUrl ??= apiLink;
  }

  final Dio _dio;

  String? baseUrl;

  String? decryptedData;
  String decryptedMsg = '';


  @override
  Future<Map<String,dynamic>> postAPI(headers, param, endPoint) async {
    final queryParameters = <String, dynamic>{};
    final apiResult = await _dio.fetch<Map<String, dynamic>>(
                        _setStreamType<ResponseDataModel>(Options(
                          method: 'POST',
                          headers: headers,
                          extra: {}
                        )
                        .compose(_dio.options, endPoint, queryParameters: queryParameters, data: param)
                        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl))
                      ); 
    // final resData = apiResult.data ?? [];
    return apiResult.data!;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
