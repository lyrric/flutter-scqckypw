
import 'package:json_annotation/json_annotation.dart';

part 'package:passenger_model.g.dart';

@JsonSerializable()
class PassengerModel{
  int id;
  int userId;
  String realName;
  String idType;
  String idNumber;

  PassengerModel();

  factory PassengerModel.fromJson(Map<String, dynamic> map)=>_$PassengerModelFromJson(map);

  Map<String, dynamic> toJson()=>_$PassengerModelToJson(this);

}