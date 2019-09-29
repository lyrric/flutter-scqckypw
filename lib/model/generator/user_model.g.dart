// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
      json['username'] as String,
      json['phone'] as String,
      json['email'] as String,
      json['realName'] as String,
      json['idType'] as String,
      json['idNo'] as String);
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'username': instance.username,
      'phone': instance.phone,
      'email': instance.email,
      'realName': instance.realName,
      'idType': instance.idType,
      'idNo': instance.idNo
    };
