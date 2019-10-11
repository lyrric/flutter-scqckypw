import 'package:json_annotation/json_annotation.dart';


part 'generator/ticket_model.g.dart';
//车票列表
@JsonSerializable()
class TicketModel{
  //乘车车站
  @JsonKey(name: 'CarryStaName')
  String fromStation;
  //途经车站
  @JsonKey(name: 'StopName')
  String halfwayStation;
  //终点站
  @JsonKey(name: 'EndStaName')
  String targetStation;
  //发车时间
  @JsonKey(name: 'DrvDateTime')
  String departureTime;
  //里程(296公里)
  @JsonKey(name: 'Mile')
  int mileage;
  //车型(中型高二)
  @JsonKey(name: 'BusTypeName')
  String vehicleType;
  //班次类型(固定班、流水班)
  @JsonKey(name: 'SchTypeName')
  String ticketType;
  //价格(106)
  @JsonKey(name: 'FullPrice')
  double price;
  //剩余票数
  @JsonKey(name: 'SAmount')
  int remainderTicketNum;
  //剩余免票儿童数
  @JsonKey(name: 'ChildSAmount')
  int remainderChildTicketNum;
  //乘车车站拼音首字母
  @JsonKey(name: 'CarryStaId')
  String carryStaId;
  //不知道是啥，创建订单时需要
  @JsonKey(name: 'SignID')
  String signId;


  TicketModel();

  factory TicketModel.fromJson(Map<String, dynamic> map)=>_$TicketModelFromJson(map);

  Map<String, dynamic> toJson()=>_$TicketModelToJson(this);
}