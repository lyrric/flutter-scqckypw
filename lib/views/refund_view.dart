import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/core/exception_handler.dart';
import 'package:flutter_scqckypw/data/request_status.dart';
import 'package:flutter_scqckypw/model/refund_info.dart';
import 'package:flutter_scqckypw/service/order_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'common_view.dart';

class RefundView extends StatefulWidget{

  int payOrderId;
  String ticketIds;

  RefundView(this.payOrderId, this.ticketIds);

  @override
  State createState() {
    return _RefundStat(payOrderId, ticketIds);
  }
}


class _RefundStat extends State{

  int payOrderId;
  String ticketIds;

  String openId;
  String ticketId;
  String applyId;

  //总退款金额
  double totalRefundPrice = 0.0;

  RequestStatus _status = RequestStatus.LOADING;

  List<RefundInfo> refundInfoList;

  var orderService = OrderService();

  _initData(){
    if(mounted){
      setState(() {
        _status = RequestStatus.LOADING;
      });
    }
    orderService.getRefundPageInfo(ticketIds, payOrderId).then((result){
        _status = RequestStatus.SUCCESS;
        openId = result['openId'];
        ticketId = result['ticketId'];
        applyId = result['applyId'];
        refundInfoList = result['data'];
        refundInfoList.forEach((f)=>totalRefundPrice+=f.refundPrice);
    }).catchError((error){
        print(error);
        _status = RequestStatus.NETWORK_ERROR;
    }).whenComplete((){setState(() {

    });});
  }

  _RefundStat(this.payOrderId, this.ticketIds){
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('退款'),
      ),
      body: _body(),
    );
  }

  Widget _body(){
    var preWidget = PreWidget(_status, _initData);
    if(preWidget != null){
      return preWidget;
    }
    return  Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
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
                              width: 100,
                              //decoration: new
                              child: Text(refundInfoList[0].fromStation,style: TextStyle(fontSize: 15), overflow: TextOverflow.ellipsis,),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 80,
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(refundInfoList[0].departureTime,style: TextStyle(fontSize: 10)),
                                  Image.asset("images/arrow_right.png", width: 80, height: 10,),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 100,
                              padding: EdgeInsets.only(left: 10),
                              child: Text(refundInfoList[0].targetStation,style: TextStyle(fontSize: 15), overflow: TextOverflow.ellipsis,),
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
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('退款票数'),
                Text('${refundInfoList.length}张'),
              ],
            ),
          ),
          Divider(height: 5,color: Colors.deepOrange,),
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('车票价格（元）'),
                Text('${refundInfoList[0].ticketPrice}张'),
              ],
            ),
          ),
          Divider(height: 5,color: Colors.deepOrange,),
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('应退金额（元/张）'),
                Text('${refundInfoList[0].refundPrice}'),
              ],
            ),
          ),

          Divider(height: 5,color: Colors.deepOrange,),
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('退款总额（元）'),
                Text('$totalRefundPrice', style: TextStyle(color: Colors.red),),
              ],
            ),
          ),
          Divider(height: 5,color: Colors.deepOrange,),
          Container(
            padding: EdgeInsets.only(top: 5),
            alignment: Alignment.center,
            child:  MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              height: 40,
              minWidth: 300,
              child: Text('确认退票'),
              onPressed: (){
                showDialog(context: context, builder: (_){
                  return YesNoDialog('确定要退票吗？');
                }).then((result){
                  if(result != null || result){
                    showDialog(context: context, builder: (_){
                      return new LoadingDialog(text: '请求中...');
                    });
                    orderService.refund(openId, ticketId, applyId)
                      .then((_){
                          Fluttertoast.showToast(backgroundColor: Colors.black, textColor: Colors.white, msg: '退款成功').then((_){
                            Navigator.of(context).pop(true);
                          });
                       })
                       .catchError(ExceptionHandler.toastHandler().handException);
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}


