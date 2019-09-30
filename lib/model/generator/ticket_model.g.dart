// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) {
  return TicketModel()
    ..fromStation = json['fromStation'] as String
    ..halfwayStation = json['halfwayStation'] as String
    ..targetStation = json['targetStation'] as String
    ..departureTime = json['departureTime'] as String
    ..mileage = json['mileage'] as String
    ..vehicleType = json['vehicleType'] as String
    ..ticketType = json['ticketType'] as String
    ..price = json['price'] as String
    ..remainderTicketNum = json['remainderTicketNum'] as int
    ..remainderChildTicketNum = json['remainderChildTicketNum'] as int;
}

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'fromStation': instance.fromStation,
      'halfwayStation': instance.halfwayStation,
      'targetStation': instance.targetStation,
      'departureTime': instance.departureTime,
      'mileage': instance.mileage,
      'vehicleType': instance.vehicleType,
      'ticketType': instance.ticketType,
      'price': instance.price,
      'remainderTicketNum': instance.remainderTicketNum,
      'remainderChildTicketNum': instance.remainderChildTicketNum,
    };
