import 'package:json_annotation/json_annotation.dart';

part 'package:flutter_scqckypw/model/generator/city_model.g.dart';

@JsonSerializable()
class CityModel{
  //编号
  int id;
  //名称
  String name;
  //拼音
  String pinyin;
  //子地区
  List<CityModel> children;
  //是否是标题，如果是则不能选择
  bool isTitle;

  CityModel();

  factory CityModel.fromJson(Map<String, dynamic> map)=>_$CityModelFromJson(map);

  Map<String, dynamic> toJson()=>_$CityModelToJson(this);
}