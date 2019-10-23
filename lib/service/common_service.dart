import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_scqckypw/data/data.dart';
import 'package:flutter_scqckypw/data/sys_constant.dart';
import 'package:flutter_scqckypw/model/http_result.dart';
import 'package:flutter_scqckypw/service/base_service.dart';

///公共服务
class CommonService extends BaseService{

  ///判断验证码是否正确
  Future<bool> captureCheck(String code) async {
    Response response = await dio.get(CAPTCHA_CHECK_URL,
      queryParameters: {
      'code':code,
      '_':DateTime.now().millisecondsSinceEpoch
      },
    );
    Map map = json.decode(response.data);
    return map['success'];
  }

  ///获取验证码
  Future<HttpResult> getCaptchaCode( )async {
    Response response = await dio.get(CAPTCHA_CODE_URL,
      queryParameters: {
        'cookie':Data.cookie,
      },
    );
    return HttpResult.fromJson(response.data);
  }

  ///初始化获取cookie
  Future<HttpResult> initCookie() async{
    await dio.get(COOKIE_URL);
    return HttpResult.success();
  }

}