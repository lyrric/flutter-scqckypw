
import 'package:dio/dio.dart';
import 'package:flutter_scqckypw/data/data.dart';

class DioInterceptor extends InterceptorsWrapper{


  @override
  Future onRequest(RequestOptions options) async {
    options.headers['User-Agent'] = 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36';
    if(Data.getCookie().isNotEmpty){
      options.headers['cookie'] = Data.getCookie();
    }
    return options;
  }

  @override
  Future onResponse(Response response)async  {
    //设置新的cookie
    List cookies = response.headers['set-cookie'];
    String cookiesStr = '';
    if(cookies != null && cookies.length > 0){
      for(String cookie in cookies){
        if(cookie.indexOf('JSESSIONID') != -1){
          cookiesStr+=cookie;
        }
      }
      if(cookiesStr.isNotEmpty){
        print('cookies='+cookiesStr);
        Data.setCookie(cookiesStr);
      }

    }
    return response;
  }
}