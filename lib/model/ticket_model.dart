import 'package:json_annotation/json_annotation.dart';


part 'generator/ticket_model.g.dart';
//车票列表
@JsonSerializable()
class TicketModel{
  //乘车车站
  String fromStation;
  //途经车站
  String halfwayStation;
  //终点站
  String targetStation;
  //发车时间
  String departureTime;
  //里程(296公里)
  String mileage;
  //车型(中型高二)
  String vehicleType;
  //班次类型(固定班、流水班)
  String ticketType;
  //价格(106元)
  String price;
  //剩余票数
  int remainderTicketNum;
  //剩余免票儿童数
  int remainderChildTicketNum;




  TicketModel();

  factory TicketModel.fromJson(Map<String, dynamic> map)=>_$TicketModelFromJson(map);

  Map<String, dynamic> toJson()=>_$TicketModelToJson(this);
}