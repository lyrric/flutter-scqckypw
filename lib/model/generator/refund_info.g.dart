// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../refund_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefundInfo _$RefundInfoFromJson(Map<String, dynamic> json) {
  return RefundInfo()
    ..fromStation = json['startName'] as String
    ..targetStation = json['stopName'] as String
    ..departureTime = json['startTime'] as String
    ..ticketPrice = (json['price'] as num)?.toDouble()
    ..refundPrice = (json['conut'] as num)?.toDouble();
}

Map<String, dynamic> _$RefundInfoToJson(RefundInfo instance) =>
    <String, dynamic>{
      'startName': instance.fromStation,
      'stopName': instance.targetStation,
      'startTime': instance.departureTime,
      'price': instance.ticketPrice,
      'conut': instance.refundPrice,
    };
