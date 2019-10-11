// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) {
  return TicketModel()
    ..fromStation = json['CarryStaName'] as String
    ..halfwayStation = json['StopName'] as String
    ..targetStation = json['EndStaName'] as String
    ..departureTime = json['DrvDateTime'] as String
    ..mileage = json['Mile'] as int
    ..vehicleType = json['BusTypeName'] as String
    ..ticketType = json['SchTypeName'] as String
    ..price = (json['FullPrice'] as num)?.toDouble()
    ..remainderTicketNum = json['SAmount'] as int
    ..remainderChildTicketNum = json['ChildSAmount'] as int
    ..carryStaId = json['CarryStaId'] as String
    ..signId = json['SignID'] as String;
}

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'CarryStaName': instance.fromStation,
      'StopName': instance.halfwayStation,
      'EndStaName': instance.targetStation,
      'DrvDateTime': instance.departureTime,
      'Mile': instance.mileage,
      'BusTypeName': instance.vehicleType,
      'SchTypeName': instance.ticketType,
      'FullPrice': instance.price,
      'SAmount': instance.remainderTicketNum,
      'ChildSAmount': instance.remainderChildTicketNum,
      'CarryStaId': instance.carryStaId,
      'SignID': instance.signId,
    };
