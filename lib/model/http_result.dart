//返回
class HttpResult {
  bool success;
  String errMsg;
  dynamic data;


  HttpResult();

  factory HttpResult.success(dynamic data){
    return new HttpResult()
        ..success = true
        ..data = data;
  }
  factory HttpResult.error(String errMsg){
    return new HttpResult()
      ..success = false
      ..errMsg = errMsg;
  }
}