
import 'package:dio/dio.dart';
import 'package:flutter_scqckypw/data/data.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DioInterceptor extends InterceptorsWrapper{

  @override
  Future onRequest(RequestOptions options) async {
    options.headers['User-Agent'] = 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36';
    options.headers['Host'] = 'www.scqckypw.com';
    options.headers['Accept-Encoding'] = 'gzip, deflate, br';
    options.headers['Accept-Language'] = 'zh-CN,zh;q=0.9,en;q=0.8,ja;q=0.7,zh-TW;q=0.6,la;q=0.5';
    options.headers['Connection'] = 'keep-alive';
    options.headers['Upgrade-Insecure-Requests'] = 1;
    if(Data.cookie.isNotEmpty){
      options.headers['cookie'] = Data.cookie;
    }
    return options;
  }

  @override
  Future onResponse(Response response)async  {
    //设置新的cookie
    if(response.request.path.startsWith('https://www.scqckypw')){
      List cookies = response.headers['set-cookie'];
      if(cookies != null && cookies.length > 0){
        for(String cookie in cookies){
          if(cookie.startsWith('JSESSIONID')){
            Data.logout();
            Data.cookie = cookie;
          }
        }
      }
      var data = response.data;
      if(data is String){
        if(data.startsWith('<script type="text/javascript">parent.location.href')){
          Data.logout();
          Fluttertoast.showToast(msg: '登录过期，请重新登陆');
        }
      }
      return response;
    }

  }
}