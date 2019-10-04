// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../target_city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TargetCityModel _$TargetCityModelFromJson(Map<String, dynamic> json) {
  return TargetCityModel()
    ..id = json['id'] as int
    ..name = json['endCityName'] as String
    ..headPinyin = json['headPinyin'] as String
    ..pinyin = json['pinyin'] as String;
}

Map<String, dynamic> _$TargetCityModelToJson(TargetCityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'headPinyin': instance.headPinyin,
      'pinyin': instance.pinyin,
    };
