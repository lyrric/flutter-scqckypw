import 'package:dio/dio.dart';
import 'package:flutter_scqckypw/core/dio_interceptor.dart';

abstract class BaseService{

  Dio dio;

  BaseService(){
    dio = new Dio();
    dio.interceptors.add(new DioInterceptor());
  }
}
