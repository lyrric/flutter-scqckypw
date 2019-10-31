import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/core/exception_handler.dart';
import 'package:flutter_scqckypw/data/request_status.dart';
import 'package:flutter_scqckypw/data/sys_constant.dart';
import 'package:flutter_scqckypw/model/http_result.dart';
import 'package:flutter_scqckypw/model/pay_order_info.dart';
import 'package:flutter_scqckypw/service/order_service.dart';
import 'package:flutter_scqckypw/views/pay_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common_view.dart';

class OrderPayingView extends StatefulWidget{

  final int orderId;

  OrderPayingView(this.orderId);

  @override
  State createState() {
    return _OrderPayingState(orderId);
  }
}

///订单支付界面
class _OrderPayingState extends State {

  ///订单信息
  List<PayOrderInfo> _orderInfo;
  ///总共价格
  double _totalPrice = 0.0;

  var _status = RequestStatus.LOADING;

  var _orderService = OrderService();

  int _payType;

  final int orderId;

  int _peyStatus = 2;

  _initData(){
    _status = RequestStatus.LOADING;
    _orderService.getUnPayOrderDetail(orderId)
        .then((map){
          _status = RequestStatus.SUCCESS;
          _payType = map['type'];
          _orderInfo = map['data'];
          _orderInfo.forEach((item){
            _totalPrice+=item.prices;
          });
        })
        .catchError((error){
          if(error is BusinessError){
            _status = RequestStatus.BUSINESS_ERROR;
          }else{
            _status = RequestStatus.NETWORK_ERROR;
          }})
        .whenComplete((){setState(() {});});
    if(mounted){
      setState(() {});
    }

  }
  _OrderPayingState(this.orderId){
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0EFF4),
      appBar: AppBar(
        title: Text('订单详情'),
      ),
      body:  _body(),
    );
  }

  Widget _body(){
    var preWidget = PreWidget(_status, _initData);
    if(preWidget != null){
      return preWidget;
    }
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ///车票
              Container(
                decoration:  BoxDecoration(
                  color: Colors.white, // 底色
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration:  BoxDecoration(
                        color: Colors.white, // 底色
                      ),
                      height: 50,
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  //decoration: new
                                  child: Text(_orderInfo[0].fromStation,style: TextStyle(fontSize: 15), overflow: TextOverflow.ellipsis,),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  alignment: Alignment.center,
                                  child:  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(_orderInfo[0].date,style: TextStyle(fontSize: 10)),
                                      Image.asset("images/arrow_right.png", width: 80, height: 10,),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(_orderInfo[0].targetStation,style: TextStyle(fontSize: 15), overflow: TextOverflow.ellipsis,),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 5,color: Colors.blue,),
                  ],
                ),
              ),

            ],
          ),
          Container(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    '乘客',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 5),
                  alignment: Alignment.center,
                  child: _userPassengerWidget(),
                ),
              ],
            ),
          ),
          Container(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('总价'),
                Text('￥$_totalPrice', style: TextStyle(color: Colors.deepOrangeAccent,),),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(),
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                height: 40,
                minWidth: 350,
                child: Text(_getButtonText()),
                onPressed: () {
                  if(_peyStatus == 1){
                    Navigator.pop(context);
                  }else if(_peyStatus == 2){
                    _gotoPay('alipay');
                  }else {

                  }
                }
            ),
          ),
        ],
      ),
    );
  }
  ///去支付
  _gotoPay(String payWay) async {
    PayWebDialog dialog;
    if(_payType == 1) {
      dialog = PayWebDialog(
          PAY_MIDDLE_URL + '?payid=' + orderId.toString() + '&plateform=' +
              payWay, _payType, payWay);
    }else {
      //获取付款url
      String url = await _orderService.getPayUrl(orderId);
      dialog = PayWebDialog(url, _payType, payWay);
    }
    showDialog(context: context, builder: (_){
      return dialog;
    }).then((result)  {
       _orderService.isPay(orderId).then((httpResult){
         ///查询付款状态
         if(httpResult.success){
           ///付款成功
           Navigator.of(context).popUntil((route)=>route.isFirst);
           _peyStatus = 1;
         }else{
           Fluttertoast.showToast(backgroundColor: Colors.black, textColor: Colors.white, msg: httpResult.errMsg);
           if(httpResult.errMsg == '支付未完成'){
             _peyStatus = 2;
           }else{
             _peyStatus = 3;
           }
         }
       }).whenComplete((){setState(() {

       });}).catchError(ExceptionHandler.toastHandler().handException);

    });

  }

  String _getButtonText(){
    if(_peyStatus == 1){
      return '支付成功，返回';
    }else if(_peyStatus == 2){
      return '去支付';
    }else {
      return '订单已过期';
    }
  }
  ///乘客
  Widget _userPassengerWidget() {
    List<Widget> list = List();
    for(int i=0; i<_orderInfo.length; i++){
      list.add(_SelectedPassengers(_orderInfo[i]));
    }
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Divider(
            height: 5,
          ),
          Column(
            children: list,
          )
        ],
      ),
    );
  }

}

///已选择的乘客item
class _SelectedPassengers extends StatelessWidget{

  final PayOrderInfo _passenger;

  _SelectedPassengers(this._passenger);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 60,
          width: 400,
          padding: EdgeInsets.only(left: 10, right: 10, top: 5),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        _passenger.passengerName,
                      ),
                      Text(
                        '  成人票',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                        '证件号  ${_passenger.idNumber}'),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
