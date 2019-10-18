
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_scqckypw/data/data.dart';
import 'package:flutter_scqckypw/data/sys_constant.dart';
import 'package:flutter_scqckypw/model/http_result.dart';
import 'package:flutter_scqckypw/service/base_service.dart';

class LoginService extends BaseService{

  ///登陆
  Future<HttpResult> login(String username, String password, String captureCode) async {
    //获取登陆页面html内容，解析token值
    Response response = await dio.get(LOGIN_PAGE_URL,  options: new Options(
        headers: { 'cookie':Data.cookie,},
        responseType: ResponseType.plain
    ));
    String html = response.data;
    int start = html.indexOf('name="csrfmiddlewaretoken" value="');
    int end = html.indexOf('"',start+'name="csrfmiddlewaretoken" value="'.length);
    if(end == -1 || start == -1){
      return HttpResult.error('解析Token失败');
    }
    String token = html.substring(start+'name="csrfmiddlewaretoken" value="'.length, end);
    response = await dio.post(LOGIN_URL,
        queryParameters: {
          'uname':username,
          'passwd':password,
          'code':captureCode,
          'token':token
        },
        options: Options(headers: {
          'Referer':'https://www.scqckypw.com/login/index.html',
          'Origin':'https://www.scqckypw.com',
          'Host':'www.scqckypw.com',
          'X-Requested-With':'XMLHttpRequest',
        })
    );
    Map<String, dynamic> map = json.decode(response.data);
    if(map['success']){
      return HttpResult.success();
    }else{
      return HttpResult.error(map['msg']);
    }
  }
}