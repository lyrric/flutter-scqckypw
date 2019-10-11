
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_scqckypw/data/sys_constant.dart';
import 'package:flutter_scqckypw/model/city_model.dart';
import 'package:flutter_scqckypw/model/ticket_model.dart';
import 'package:flutter_scqckypw/service/base_service.dart';
import 'package:html/parser.dart' show parse;

///车票
class TicketService extends BaseService{


  //获取车次列表
  Future<List<TicketModel>> getTickets(CityModel from, CityModel target, String date) async {
    List<TicketModel> result = new List<TicketModel>();
    Response<String> response = await dio.get(BASE_URL+"/query/searchTicket.html",
        queryParameters: {
          'cityId':from.id,
          'cityName':from.name,
          'targetName':target.name,
          'searchDate':date,
         }
      );
    String html = response.data;
    int start = html.indexOf('"data":');
    int end = html.indexOf('}]}');
    if(start == -1 || end == -1){
      return result;
    }
    String jsonData = html.substring(start+'"data":'.length, end+2);
    List list = json.decode(jsonData);
    for(var map in list){
      TicketModel ticket = TicketModel.fromJson(map);
      result.add(ticket);
    }
    return result;
  }

  ///获取token，创建订单的时候需要
  Future<String> getOrderPageToken(String carryStaId,String strDate, String signId, String stopName) async {
    Response response = await dio.get(CREATE_ORDER_PAGE_URL,queryParameters: {
      'carry_sta_id':carryStaId,
      'str_date':strDate,
      'sign_id':signId,
      'stop_name':stopName
    });
    var document = parse(response.data);
    String token = document.querySelector('#ticket_with_insurant > input[name="token"]').attributes['value'];
    return token;
  }

}