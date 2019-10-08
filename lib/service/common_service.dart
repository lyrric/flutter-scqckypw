import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_scqckypw/data/data.dart';
import 'package:flutter_scqckypw/data/sys_constant.dart';
import 'package:flutter_scqckypw/service/base_service.dart';

///公共服务
class CommonService extends BaseService{

  //图片验证码
  Future<Uint8List> getCapture() async {
    Response response = await dio.get(CAPTURE_URL,
        queryParameters: {'d':Random.secure().nextDouble()},
        options: new Options(
          headers: { 'cookie':Data.cookie,},
          responseType: ResponseType.bytes
        ),
    );
    List<int> data = response.data;
    Uint8List bytes = Uint8List.fromList(data);
    return bytes;
  }
}