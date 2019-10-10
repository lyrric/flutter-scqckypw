// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../passenger_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Passenger _$PassengerModelFromJson(Map<String, dynamic> json) {
  return Passenger()
    ..id = json['id'] as int
    ..userId = json['userId'] as int
    ..realName = json['realName'] as String
    ..idType = json['idType'] as String
    ..idNumber = json['idNumber'] as String;
}

Map<String, dynamic> _$PassengerModelToJson(Passenger instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'realName': instance.realName,
      'idType': instance.idType,
      'idNumber': instance.idNumber,
    };
