
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_scqckypw/data/data.dart';
import 'package:flutter_scqckypw/data/sys_constant.dart';
import 'package:flutter_scqckypw/model/http_result.dart';
import 'package:flutter_scqckypw/model/order.dart';
import 'package:flutter_scqckypw/model/page_result.dart';
import 'package:flutter_scqckypw/model/passenger_model.dart';
import 'package:flutter_scqckypw/model/pay_order_info.dart';
import 'package:flutter_scqckypw/model/refund_info.dart';
import 'package:flutter_scqckypw/model/ticket_model.dart';
import 'package:flutter_scqckypw/service/base_service.dart';
import 'package:flutter_scqckypw/util/data_util.dart';
import 'package:html/parser.dart' show parse;

///订单
class OrderService extends BaseService{

  ///我的订单列表
  Future<HttpResult> myOrderList(int currentPage, String orderStatus) async {
    try{
      Response response = await dio.get(MY_ORDER_LIST_URL, queryParameters: {
        'startTime':'2000-10-09',
        'pageSize':20,
        'currentPage':currentPage,
        'orderState':orderStatus
      });
      if(!isLogin(response)){
        Data.logout();
        return HttpResult.error('登陆信息失效，请重新登陆');
      }
      var document = parse(response.data);
      ///获取总页数，和数据总数
      int startIndex = response.data.toString().indexOf('countPage = ');
      int endIndex = response.data.toString().indexOf(';', startIndex);
      int totalPage = int.parse(response.data.toString().substring(startIndex+'countPage = '.length, endIndex));
      var pageResult = new PageResult();
      pageResult.totalPage = totalPage;
      startIndex = response.data.toString().indexOf('searchCount = ');
      endIndex = response.data.toString().indexOf(';', startIndex);
      int totalCont = int.parse(response.data.toString().substring(startIndex+'searchCount = '.length, endIndex));
      pageResult.totalCount = totalCont;

      ///获取数据
      List<OrderList> list = new List();
      var resultDiv = document.querySelectorAll('#hiddenresult > div');
      for(var item in resultDiv){
        var order = new OrderList();
        order.payOrderId = int.parse(item.querySelectorAll(' form > table > tbody > tr > td >input')[0].attributes['value']);
        order.tradeNumber = item.querySelectorAll('form > table > tbody > tr > td')[1].nodes[2].text.replaceAll('\n', '').replaceAll('\t', '').replaceAll(' ', '');
        order.departureTime = item.querySelectorAll('form > table > tbody > tr > td')[2].nodes[0].text.replaceAll('\n', '').replaceAll('\t', '').replaceAll('发车时间:', '');
        order.price = double.parse(item.querySelectorAll('form > table > tbody > tr > td')[3].nodes[0].text.replaceAll('\n', '').replaceAll('\t', '').replaceAll('总金额(元):', ''));
        order.fromStation = item.querySelectorAll('form > table > tbody > tr')[2].querySelectorAll('td')[1].nodes[0].text;
        order.targetStation = item.querySelectorAll('form > table > tbody > tr')[2].querySelectorAll('td')[1].nodes[2].text.replaceAll(' ', '');
        var e = item.querySelector('form > table > tbody > tr > td > div >font');
        if(e != null){
          order.orderStatus = e.text;
        }else{
          if(item.querySelectorAll('form > table > tbody > tr > td > div > input').length == 2){
            order.orderStatus = '待支付';
          }else{
            order.orderStatus = '待出行';
          }

        }
        var subItem = item.querySelectorAll('form > table > tbody > tr');
        var  orderDetails = new List<OrderDetail>();
        for(int i=2;i<subItem.length;i++){
          OrderDetail orderDetail = new OrderDetail();
          orderDetail.price = double.parse(subItem[i].querySelectorAll('td')[2].nodes[0].text);
          orderDetail.ticketStatus = subItem[i].querySelectorAll('td')[3].nodes[1].text;
          orderDetail.orderId = int.parse(subItem[i].nodes[0].nodes[1].attributes['value']);
          orderDetails.add(orderDetail);
        }
        order.orderDetails = orderDetails;
        list.add(order);
      }
      pageResult.data = list;
      return HttpResult.success(data:pageResult);
    }on DioError catch(e){
      print(e);
      return HttpResult.error('获取订单列表失败');
    }

  }
  ///取消订单
  Future<HttpResult> cancel(int payOrderId) async {
    try{
      Response response = await dio.get(CANCEL_ORDER_URL, queryParameters: {
        'payOrderId':payOrderId.toString()
      });
      Map map = json.decode(response.data);
      if(map['success']){
        return HttpResult.success();
      }
      return HttpResult.error('取消失败');
    }on DioError catch(e){
      print(e);
      return HttpResult.error('取消失败');
    }
  }
  ///退款页面信息
  Future<HttpResult> getRefundPageInfo(String ticketIds, int payOrderId) async {
    try{
      Response response = await dio.get(CANCEL_ORDER_URL, queryParameters: {
        'ticket_ids':ticketIds,
        'payorder_id':payOrderId,
      });
      String html = response.data;
      int startIndex = html.indexOf('ticket = ');
      if(startIndex == -1){
        return HttpResult.error('获取数据失败');
      }
      int endIndex = html.indexOf(';');
      String jsonStr = html.substring(startIndex+'ticket = '.length, endIndex);
      Map map = json.decode(jsonStr);
      List<RefundInfo> list = new List();
      for(int i = 0;i<map.length;i++){
        RefundInfo refundInfo = RefundInfo.fromJson(map[i]);
        list.add(refundInfo);
      }
      return HttpResult.success(data:list);
    }on DioError catch(e){
      print(e);
      return HttpResult.error('获取数据失败');
    }
  }

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
    var para = new Map<String, dynamic> ();
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

    ///乘客信息
    for(int i=0; i<passengers.length; i++){
      para['passenger_ticket_type'+(i+1).toString()] = 0;
      para['passenger_card_type'+(i+1).toString()] = passengers[i].idType;
      para['passenger_card_num'+(i+1).toString()] = passengers[i].idNumber;
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
    if(referer.indexOf('errMsg') != -1){
      return HttpResult.error('锁定车票失败');
    }
    String orderId= referer.split('=')[1];
    return HttpResult.success(data:int.parse(orderId));
  }


  ///获取待支付的订单信息
  Future<HttpResult> getUnPayOrderDetail (int orderId) async {
    Response response;
    try{
      response = await dio.get(CHOOSE_PAY_WAY_URL, queryParameters: {
        'pay_order_id':orderId
      });
    }on DioError catch(e){
      print(e);
      return HttpResult.error('车票已过期 请重新购票');
    }
    var document = parse(response.data);
    var list = document.querySelectorAll('#rnbox4');
    List<PayOrderInfo> data = new List();
    for(int i=0;i<list.length;i++){
      var item = list[i];
      var payOrderInfo = new PayOrderInfo();
      payOrderInfo.fromStation = item.querySelectorAll('ul > li')[0].text;
      payOrderInfo.targetStation = item.querySelectorAll('ul > li')[1].text;
      payOrderInfo.passengerName = item.querySelectorAll('ul > li')[2].text;
      payOrderInfo.date = item.querySelectorAll('ul > li')[3].text;
      payOrderInfo.prices = double.parse(item.querySelectorAll('ul > li')[4].text.replaceAll('\n', '').replaceAll('\t', ''));
      payOrderInfo.idNumber = document.querySelectorAll('#box3 > div.em_lst > ul > li.c3')[i].text.replaceAll('\n', '').replaceAll('\t', '');
      data.add(payOrderInfo);
    }
    return HttpResult.success(data:data);
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
    return HttpResult.success(data:response.headers.value('Location'));
  }
}