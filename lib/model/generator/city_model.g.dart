// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityModelFromJson(Map<String, dynamic> json) {
  return CityModel()
    ..id = json['id'] as int
    ..name = json['name'] as String
    ..pinyin = json['pinyin'] as String
    ..children = (json['children'] as List)
        ?.map((e) =>
            e == null ? null : CityModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pinyin': instance.pinyin,
      'children': instance.children
    };
