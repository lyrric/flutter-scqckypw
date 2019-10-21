// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../http_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpResult _$HttpResultFromJson(Map<String, dynamic> json) {
  return HttpResult()
    ..success = json['success'] as bool
    ..errMsg = json['errMsg'] as String
    ..data = json['data'];
}

Map<String, dynamic> _$HttpResultToJson(HttpResult instance) =>
    <String, dynamic>{
      'success': instance.success,
      'errMsg': instance.errMsg,
      'data': instance.data,
    };
