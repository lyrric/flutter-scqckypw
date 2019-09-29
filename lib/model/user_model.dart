import 'package:json_annotation/json_annotation.dart';

part 'package:flutter_scqckypw/model/generator/user_model.g.dart';

@JsonSerializable()

class UserModel{
  //用户名
  String username;
  //电话号码
  String phone;
  //邮箱
  String email;
  //真实姓名
  String realName;
  //证件类型
  String idType;
  //证件编号
  String idNo;
  //证件编号
  String cookie;

  UserModel(this.username, this.phone, this.email, this.realName, this.idType,
      this.idNo);

  UserModel.emptyUser();

  factory UserModel.fromJson(Map<String, dynamic> map)=>_$UserModelFromJson(map);

  Map<String, dynamic> toJson()=>_$UserModelToJson(this);
}
