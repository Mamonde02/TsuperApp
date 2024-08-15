import 'package:json_annotation/json_annotation.dart';

part 'APIDataModel.g.dart';

@JsonSerializable()
class ResponseDataModel {
  ResponseDataModel({this.date, this.data, this.status = "--", this.message, this.result});

  String? date;
  String? data;
  late String? status = "--";
  late String? message;
  late String? result;

  factory ResponseDataModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseDataModelToJson(this);
}
