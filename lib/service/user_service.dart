
import 'package:dio/dio.dart';
import 'package:flutter_scqckypw/data/data.dart';
import 'package:flutter_scqckypw/data/sys_constant.dart';
import 'package:flutter_scqckypw/model/user_model.dart';
import 'package:flutter_scqckypw/service/base_service.dart';
import 'package:html/parser.dart' show parse;

class UserService extends BaseService{
  
  ///获取用户基本信息
  Future<UserModel> getUser() async {
    Response response = await dio.get(USER_CENTER_URL);
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
    if(idNo != '未添加'){
      String startStr = idNo.substring(0, 3);
      String endStr = idNo.substring(idNo.length-3, idNo.length);
      idNo = startStr + '***'+ endStr;
    }
    user.idNo = idNo;
    String phone = document.querySelectorAll('#infoDiv > dl > dd')[7].text.replaceAll('\n', '').replaceAll(' ', '').replaceAll('手机：', '');
    phone = phone == '空'?'未绑定手机':phone;
    user.phone = phone;
    String email = document.querySelectorAll('#infoDiv > dl > dd')[9].text.replaceAll('\n', '').replaceAll(' ', '').replaceAll('邮箱：', '');
    email = email == '空'?'未绑定邮箱':email;
    user.email = email;
    Data.user = user;
    return user;
  }
}