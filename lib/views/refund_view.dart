import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/core/exception_handler.dart';
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
  //总退款金额
  double totalRefundPrice;

  List<RefundInfo> refundInfoList;

  var orderService = OrderService();

  _initData(){
    orderService.getRefundPageInfo(ticketIds, payOrderId).catchError(ExceptionHandler.toastHandler().handException).then((result){
      if(result.success){
        refundInfoList = result.data;
      }
    });
  }

  _RefundStat(this.payOrderId, this.ticketIds){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('退款'),
      ),
      body: refundInfoList == null?LoadingDialog():
         Container(
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
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Text('退款票数'),
                   Text('${refundInfoList.length}张'),
                 ],
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Text('车票价格（元）'),
                   Text('${refundInfoList[0].ticketPrice}张'),
                 ],
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Text('应退金额（元/张）'),
                   Text('${refundInfoList[0].refundPrice}'),
                 ],
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Text('退款总额（元）'),
                   Text('$totalRefundPrice'),
                 ],
               ),
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

                   },
                 ),
               ),
             ],
           ),
         )
    );
  }
}


