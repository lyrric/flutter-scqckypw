
import 'package:json_annotation/json_annotation.dart';

part 'generator/passenger_model.g.dart';

@JsonSerializable()
class Passenger{
  int id;
  int userId;
  String realName;
  String idType;
  String idNumber;

  Passenger();

  factory Passenger.fromJson(Map<String, dynamic> map)=>_$PassengerModelFromJson(map);

  Map<String, dynamic> toJson()=>_$PassengerModelToJson(this);

}