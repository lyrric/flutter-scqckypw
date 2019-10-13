
import 'package:dio/dio.dart';
import 'package:flutter_scqckypw/data/sys_constant.dart';
import 'package:flutter_scqckypw/model/http_result.dart';
import 'package:flutter_scqckypw/model/passenger_model.dart';
import 'package:flutter_scqckypw/model/ticket_model.dart';
import 'package:flutter_scqckypw/service/base_service.dart';
import 'package:html/parser.dart' show parse;

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

  ///下单
  Future<HttpResult> order(TicketModel ticketModel, List<Passenger> passengers, String contactName, String phone,String token, String captureCode) async {
    if(await _havePayingOrder()){
      return HttpResult.error('你还有未支付的订单');
    }
   return _lockTicket(ticketModel, passengers, contactName, phone, token, captureCode);

  }
  ///锁定车票
  Future<HttpResult> _lockTicket(TicketModel ticketModel, List<Passenger> passengers, String contactName, String phone,String token, String captureCode) async {
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
    para['passenger_num'] = 'passenger_num'+passengers.length.toString();
    para['insurant_sum3'] = 0;
    para['insurant_sum4'] = 0;

    //乘客信息
    for(int i=0; i<passengers.length; i++){
      para['passenger_ticket_type'+(i+1).toString()] = 0;
      para['passenger_name'+(i+1).toString()] = passengers[i].realName;
      para['birthday'+(i+1).toString()] = passengers[i].idNumber.substring(6, 10)+ '-'+passengers[i].idNumber.substring(10, 12)+'-'+passengers[i].idNumber.substring(12, 14);
      para['bring_child'+(i+1).toString()] = 0;
    }
    Response response;
    try{
      response = await dio.post(LOCK_TICKET_URL,queryParameters: para);
    }on DioError catch(e){
      if(e.type == DioErrorType.RESPONSE){
        response = e.response;
      }else{
        print(e.toString());
        return HttpResult.error('锁定车票失败');
      }
    }
    String referer = response.headers.value('Location');
    String orderId= referer.split('=')[1];
    return HttpResult.success(int.parse(orderId));
  }

  ///获取待付款订单的数据
/*  Future<HttpResult> getUnPayOrderDetail (int orderId) async {
    Response response = await dio.get(CHOOSE_PAY_WAY_URL, queryParameters: {
      'pay_order_id':orderId
    });
    var document = parse(response.data);
    Map map = new Map();
    map['payid'] = document.querySelector('#form_pay > input[name="payid"]').attributes['value'];
    map['bank']  = document.querySelector('#form_pay > input[name="bank"]').attributes['value'];
    map['plate']  = document.querySelector('#form_pay > input[name="plate"]').attributes['value'];
    //支付方式，alipay、weixin
    map['plateform'] = document.querySelector('#form_pay > input[name="plateform"]').attributes['value'];
    map['qr_pay_mode'] = document.querySelector('#form_pay > input[name="qr_pay_mode"]').attributes['value'];
    map['discountCode'] = document.querySelector('#form_pay > input[name="discountCode"]').attributes['value'];
    return HttpResult.success(map);
  }*/

  /*///付款
  Future<HttpResult> pay(Map map) async {
    Response response = await dio.post(PAY_MIDDLE_URL, queryParameters: map);
    var document = parse(response.data);
    Map data = new Map();
    data['subject'] = document.querySelector('#web_pay_form > input[name="subject"]').attributes['value'];
    data['sign_type']  = document.querySelector('#web_pay_form > input[name="sign_type"]').attributes['value'];
    data['notify_url']  = document.querySelector('#web_pay_form > input[name="notify_url"]').attributes['value'];
    data['out_trade_no'] = document.querySelector('#web_pay_form > input[name="out_trade_no"]').attributes['value'];
    data['default_login'] = document.querySelector('#web_pay_form > input[name="default_login"]').attributes['value'];
    data['return_url'] = document.querySelector('#web_pay_form > input[name="return_url"]').attributes['value'];
    data['sign'] = document.querySelector('#web_pay_form > input[name="sign"]').attributes['value'];
    data['_input_charset'] = document.querySelector('#web_pay_form > input[name="_input_charset"]').attributes['value'];
    data['it_b_pay'] = document.querySelector('#web_pay_form > input[name="it_b_pay"]').attributes['value'];
    data['total_fee'] = document.querySelector('#web_pay_form > input[name="total_fee"]').attributes['value'];
    data['service'] = document.querySelector('#web_pay_form > input[name="service"]').attributes['value'];
    data['paymethod'] = document.querySelector('#web_pay_form > input[name="paymethod"]').attributes['value'];
    data['partner'] = document.querySelector('#web_pay_form > input[name="partner"]').attributes['value'];
    data['seller_id'] = document.querySelector('#web_pay_form > input[name="seller_id"]').attributes['value'];
    data['anti_phishing_key'] = document.querySelector('#web_pay_form > input[name="anti_phishing_key"]').attributes['value'];
    data['seller_email'] = document.querySelector('#web_pay_form > input[name="seller_email"]').attributes['value'];
    data['payment_type'] = document.querySelector('#web_pay_form > input[name="payment_type"]').attributes['value'];
    String url = document.querySelector('#web_pay_form]').attributes['action'];
    ///创建支付宝订单
    try{
        response = await dio.post(url,queryParameters: data);
     }on DioError catch(e){
        if(e.type == DioErrorType.RESPONSE){
          response = e.response;
        }else{
          print(e.toString());
          return HttpResult.error('锁定车票失败');
        }
    }
    //这个referer会连续跳转好几次，并且伴随着cookie的设置，比较复杂，放在webView里面可能好些
    //https://mapi.alipay.com/gateway.do --> https://unitradeadapter.alipay.com/gateway/exterfaceAssign.do -> https://excashier.alipay.com/standard/auth.htm?payOrderId=22dc050ed8de44e7b36b65ced83aba31.80
    String referer = response.headers.value('Location');
    return HttpResult.success(referer);
    String qrCodeUrl = document.querySelector('#J_qrCode').attributes['value'];
    //启动参数，value值需要URL_ENCODE,?_s=web-other好像可以不要
    //alipays://platformapi/startapp?saId=10000007&clientVersion=3.7.0.0718&qrcode=https://qr.alipay.com/upx08084asousb6fweg7802d?_s=web-other

  }*/

  ///302跳转
  Future<HttpResult> _jump(String url) async {
    Response response;
    try{
      response = await dio.get(url);
    }on DioError catch(e){
      if(e.type == DioErrorType.RESPONSE){
        response = e.response;
      }else{
        print(e.toString());
        return HttpResult.error('请求失败');
      }
    }
    return HttpResult.success(response.headers.value('Location'));
  }
}