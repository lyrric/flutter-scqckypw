import 'package:json_annotation/json_annotation.dart';


part 'generator/refund_info.g.dart';

@JsonSerializable()
class RefundInfo{

  @JsonKey(name: 'startName')
  String fromStation;
  @JsonKey(name: 'stopName')
  String targetStation;
  ///发车时间
  @JsonKey(name: 'startTime')
  String departureTime;
  ///车票价格
  @JsonKey(name: 'price')
  double ticketPrice;
  ///退票金额
  @JsonKey(name: 'conut')
  double refundPrice;

  RefundInfo();

  factory RefundInfo.fromJson(Map<String, dynamic> map)=>_$RefundInfoFromJson(map);

  Map<String, dynamic> toJson()=>_$RefundInfoToJson(this);
}