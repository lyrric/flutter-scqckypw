import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_scqckypw/data/data.dart';
import 'package:flutter_scqckypw/data/sys_constant.dart';

///公共服务
class CommonService{
  Dio _dio = new Dio();
  
  //图片验证码
  Future<Uint8List> getCapture() async {
    Response response = await _dio.get(CAPTURE_URL,
        queryParameters: {'d':Random.secure().nextDouble()},
        options: new Options(
          headers: { 'cookie':Data.getCookie(),},
          responseType: ResponseType.bytes
        ),
    );
    //设置新的cookie
    List cookies = response.headers['set-cookie'];
    if(cookies != null && cookies.length > 0){
      var cookie = cookies[0];
      Data.setCookie(cookie);
    }
    List<int> data = response.data;
    Uint8List bytes = Uint8List.fromList(data);
    return bytes;
  }
}