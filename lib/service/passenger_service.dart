
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_scqckypw/core/exception_handler.dart';
import 'package:flutter_scqckypw/data/data.dart';
import 'package:flutter_scqckypw/data/sys_constant.dart';
import 'package:flutter_scqckypw/model/http_result.dart';
import 'package:flutter_scqckypw/model/passenger_model.dart';
import 'package:flutter_scqckypw/service/base_service.dart';
import 'package:flutter_scqckypw/util/data_util.dart';

///乘客管理
class PassengerService extends BaseService{


  Future<List<Passenger>> getPassengers(int pageNo) async {
    Response response = await dio.get(PASSENGER_QUERY_URL, queryParameters: {
      'currentPage':pageNo
    });
    if(!isLogin(response)){
      Data.logout();
      throw new BusinessError('登陆信息失效，请重新登陆');
    }
    List<Passenger> passengers = new List();
    String data = _parseHtml(response.data);
    if(data == null) return passengers;
    Map<String, dynamic> map = json.decode(data);
    List list = map['person'];
    if(list.length == 0){
      return passengers;
    }
    for(var item in list){
      passengers.add(Passenger.fromJson(item));
    }
    //一页五条数据，如果小于五条表示没有下一页了
    if(passengers.length < 5){
      return passengers;
    }
    List<Passenger> nextPagePassengers = await getPassengers(pageNo+1);
    if(nextPagePassengers.length != 0){
      passengers.addAll(nextPagePassengers);
    }
    return passengers;
  }

  ///修改乘客信息，这个接口是直接跳到乘客界面
  Future update(Passenger passenger) async {
    //先判断是否重复
    Response response = await dio.get(PASSENGER_CHECK_URL,
        queryParameters: {
          'cpId':passenger.id,
          'idType':passenger.idType,
          'idNo':passenger.idNumber, }
    );
    if(!isLogin(response)){
      Data.logout();
      throw BusinessError('登陆信息失效，请重新登陆');
    }
    String data = response.data;
    Map<String, dynamic> map = json.decode(data);
    if(!map['success']){
      return map['msg'];
    }
    response = await dio.get(PASSENGER_UPDATE_URL,
        queryParameters: {
          'cpId':passenger.id,
          'name':passenger.realName,
          'idType':passenger.idType,
          'idNo':passenger.idNumber, }
          );
  }

  ///修改乘客信息，这个接口是直接跳到乘客界面
  Future add(Passenger passenger) async {
    Response response = await dio.get(PASSENGER_ADD_URL,
        queryParameters: {
          'name':passenger.realName,
          'idType':passenger.idType,
          'idNo':passenger.idNumber, }
    );
    if(!isLogin(response)){
      Data.logout();
      throw BusinessError('登陆信息失效，请重新登陆');
    }
  }

  ///删除乘客信息，这个接口是直接跳到乘客界面
  Future delete(int id) async {
    Response response = await dio.get(PASSENGER_DELETE_URL,
        queryParameters: {'id':id,}
    );
    if(!isLogin(response)){
      Data.logout();
      throw BusinessError('登陆信息失效，请重新登陆');
    }
  }

  String  _parseHtml(String html){
      int start = html.indexOf('var data = ');
      if(start == -1 ){
        return null;
      }
      int end = html.indexOf(']}', start);
      if(end == -1 ){
        return null;
      }
      return html.substring(start + 'var data = '.length, end+']}'.length);
  }
}