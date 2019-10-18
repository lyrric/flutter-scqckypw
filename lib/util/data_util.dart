
//转换身份类型,身份证->id_card
import 'package:dio/dio.dart';

String convertIdTypeByText(String text){
  switch(text){
    case '身份证':
      return 'id_card';
    case '军人证':
      return 'military_card';
    case '护照':
      return 'passport';
    default:
      return 'id_card';
  }
}
//转换身份类型,id_card->身份证
String convertIdTypeByVal(String val){
  switch(val){
    case 'id_card':
      return '身份证';
    case 'military_card':
      return '军人证';
    case 'passport':
      return '护照';
    default:
      return '身份证';
  }
}
///根据response判断是登陆
bool isLogin(Response response){
  return response.data.toString().indexOf('parent.location.href') == -1;
}