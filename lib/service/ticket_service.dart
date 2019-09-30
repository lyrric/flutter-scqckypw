
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_scqckypw/data/sys_constant.dart';
import 'package:flutter_scqckypw/model/city_model.dart';
import 'package:flutter_scqckypw/model/ticket_model.dart';

///车票
class TicketService{

  Dio _dio = new Dio();

  //获取车次列表
  Future<List<TicketModel>> getTickets(CityModel from, CityModel target, String date) async {
    List<TicketModel> result = new List<TicketModel>();
    Response<String> response = await _dio.get(BASE_URL+"/query/searchTicket.html",
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


}