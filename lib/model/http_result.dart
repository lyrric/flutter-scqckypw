


import 'package:json_annotation/json_annotation.dart';

part 'generator/http_result.g.dart';
//返回
@JsonSerializable()
class HttpResult {

  bool success;
  String errMsg;
  dynamic data;


  HttpResult();


  factory HttpResult.success({dynamic data}){
    return new HttpResult()
        ..success = true
        ..data = data;
  }
  factory HttpResult.error(String errMsg){
    return new HttpResult()
      ..success = false
      ..errMsg = errMsg;
  }

  factory HttpResult.fromJson(Map<String, dynamic> map)=>_$HttpResultFromJson(map);

  Map<String, dynamic> toJson()=>_$HttpResultToJson(this);
}