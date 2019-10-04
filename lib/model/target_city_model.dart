import 'package:json_annotation/json_annotation.dart';

part 'generator/target_city_model.g.dart';

@JsonSerializable()
class TargetCityModel{
  //编号
  int id;
  //名称
  @JsonKey(name: 'endCityName')
  String name;
  //简拼（拼音首字母）
  String headPinyin;
  //拼音
  String pinyin;

  factory TargetCityModel.of(int id, String name){
    return TargetCityModel()
      ..id = id
      ..name = name;
  }

  TargetCityModel();

  factory TargetCityModel.fromJson(Map<String, dynamic> map)=>_$TargetCityModelFromJson(map);

  Map<String, dynamic> toJson()=>_$TargetCityModelToJson(this);
}