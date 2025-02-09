// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'APIDataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseDataModel _$ResponseDataModelFromJson(Map<String, dynamic> json) {
  return ResponseDataModel(
    date: json['date'] as String?,
    data:  "${json['data']}",
    status: json['status'] as String?,
    message: json['message'] as String?,
    result: json['result'] as String?,
  );
}

Map<String, dynamic> _$ResponseDataModelToJson(ResponseDataModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'result': instance.result,
    };
