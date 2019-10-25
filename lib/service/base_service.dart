import 'package:dio/dio.dart';
import 'package:flutter_scqckypw/core/dio_interceptor.dart';

abstract class BaseService{

  Dio dio;

  BaseService(){
    dio = new Dio(BaseOptions(connectTimeout:3000, sendTimeout: 5000, receiveTimeout: 5000));
    dio.interceptors.add(new DioInterceptor());
  }


}
