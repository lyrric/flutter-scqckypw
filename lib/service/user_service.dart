
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_scqckypw/data/data.dart';
import 'package:flutter_scqckypw/data/sys_constant.dart';
import 'package:flutter_scqckypw/model/http_result.dart';
import 'package:flutter_scqckypw/model/user_model.dart';
import 'package:flutter_scqckypw/service/base_service.dart';
import 'package:flutter_scqckypw/util/data_util.dart';
import 'package:html/parser.dart' show parse;

class UserService extends BaseService{
  
  ///获取用户基本信息
  Future<HttpResult> getUser() async {
    Response response = await dio.get(USER_CENTER_URL);
    if(!isLogin(response)){
      Data.logout();
      return HttpResult.error('登陆信息失效，请重新登陆');
    }
    String html = response.data;
    var document = parse(html);
    UserModel user =  UserModel.emptyUser();
    String username = document.querySelectorAll('#infoDiv > dl > dd > span')[0].text.replaceAll('\n', '').replaceAll('\t', '');
    user.username = username;
    String realName = document.querySelectorAll('#h_cs_realName')[0].attributes['value'];
    user.realName = realName;
    String sex = document.querySelectorAll('#sGender')[0].text.replaceAll('\n', '').replaceAll('\t', '');
    user.sex = sex;
    String idType = document.querySelectorAll('#iType')[0].text;
    user.idType = idType;
    String idNo = document.querySelectorAll('#h_cs_id_number')[0].attributes['value'];
    user.idNo = idNo;
    String phone = document.querySelectorAll('#infoDiv > dl > dd')[7].text.replaceAll('\n', '').replaceAll(' ', '').replaceAll('手机：', '');
    phone = phone == '空'?'未绑定手机':phone;
    user.phone = phone;
    String email = document.querySelectorAll('#infoDiv > dl > dd')[9].text.replaceAll('\n', '').replaceAll(' ', '').replaceAll('邮箱：', '');
    email = email == '空'?'未绑定邮箱':email;
    user.email = email;
    Data.user = user;
    return HttpResult.success(data: user);
  }

  ///更新用户
  Future<HttpResult> updateInfo(String realName, String sex, String idType, String idNo) async {
    Response response = await dio.post(USER_UPDATE_URL
        ,queryParameters:{
        'name':realName,
        'gender':sex,
        'idType':idType,
        'idNo':idNo,
      });
    Map<String, dynamic> map = json.decode(response.data);
    if(map['success']){
      return HttpResult.success();
    }else{
      return HttpResult.error(map['msg']);
    }
  }
}