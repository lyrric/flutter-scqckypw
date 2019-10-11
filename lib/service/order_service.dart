
import 'package:dio/dio.dart';
import 'package:flutter_scqckypw/data/sys_constant.dart';
import 'package:flutter_scqckypw/model/passenger_model.dart';
import 'package:flutter_scqckypw/model/ticket_model.dart';
import 'package:flutter_scqckypw/service/base_service.dart';

///订单
class OrderService extends BaseService{

  ///是否有未支付订单
  Future<bool> _havePayingOrder() async {
    Response response = await dio.get(HAVING_PAYING_ORDER_URL, queryParameters: {
      'is_show':'no',
      '_':DateTime.now().millisecondsSinceEpoch
    });
   return response.data.toString().indexOf('ture') != -1;
  }

  //下单
  order(TicketModel ticketModel, List<Passenger> passengers, String contactName, String phone,String token, String captureCode) async {
    Map result = new Map();
    if(await _havePayingOrder()){
      result['success'] = false;
      result['errMsg'] = '你还有未支付的订单';
      return result;
    }

  }
  ///锁定车票
  _lockTicket(TicketModel ticketModel, List<Passenger> passengers, String contactName, String phone,String token, String captureCode) async {
    Map para = new Map();
    para['sdfgfgfg'] = 'on';
    para['contact_name'] = contactName;
    para['phone_num'] = phone;
    para['contact_card_num'] = '';
    para['sign_id'] = ticketModel.signId;
    para['carry_sta_id'] = ticketModel.carryStaId;
    para['carry_sta_id'] = ticketModel.carryStaId;
    para['drv_date_time'] = ticketModel.departureTime;
    para['stop_name'] = ticketModel.targetStation;
    para['token'] = token;
    para['code'] = captureCode;
    para['is_save_contact_person'] = false;

    Response response = await dio.get(LOCK_TICKET_URL,queryParameters: {

    });
  }
}