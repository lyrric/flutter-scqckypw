import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_scqckypw/data/sys_constant.dart';
import 'package:flutter_scqckypw/service/base_service.dart';

///公共服务
class CommonService extends BaseService{

  //图片验证码
  Future<Uint8List> getCapture() async {
    Response response = await dio.get(CAPTURE_URL,
        queryParameters: {'d':Random.secure().nextDouble()},
        options: new Options(
          responseType: ResponseType.bytes
        ),
    );
    List<int> data = response.data;
    Uint8List bytes = Uint8List.fromList(data);
    return bytes;
  }

  ///判断验证码是否正确
  Future<bool> captureCheck(String code) async {
    Response response = await dio.get(CAPTURE_CHECK_URL,
      queryParameters: {
      'code':code,
      '_':DateTime.now().millisecondsSinceEpoch
      },
    );
    Map map = json.decode(response.data);
    return map['success'];
  }
}