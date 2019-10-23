import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/model/http_result.dart';
import 'package:flutter_scqckypw/model/order.dart';
import 'package:flutter_scqckypw/model/page_result.dart';
import 'package:flutter_scqckypw/service/order_service.dart';
import 'package:flutter_scqckypw/views/order_pay.dart';
import 'package:flutter_scqckypw/views/refund_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../common_view.dart';


///我的订单
class MyOrderListView extends StatefulWidget{

  @override
  State createState() {
    return _MyOrderListViewStat();
  }
}

class _MyOrderListViewStat extends State with SingleTickerProviderStateMixin {

  TabController tabCtrl;

  _MyOrderListViewStat(){
    tabCtrl = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0EFF4),
      appBar: AppBar(
        title: Text('我的订单'),
        bottom: TabBar(
          controller: tabCtrl,
          tabs: <Widget>[
            Tab(
              text: '全部',
            ),
            Tab(
              text: '已支付',
            ),
            Tab(
              text: '未支付',
            ),
            Tab(
              text: '已退款',
            )
          ],
        ),
      ),
      body: TabBarView(
          children: [
            _Body('all'),
            _Body('succeed'),
            _Body('pending'),
            _Body('backed'),
        ],
        controller: tabCtrl,
      ),
    );

  }


}

class _Body extends StatefulWidget{

  final String _orderStatus;

  _Body(this._orderStatus);

  @override
  State createState() {
    return _BodyStat(_orderStatus);
  }
}

class _BodyStat extends State{

  int _currentPage = 1;

  OrderService _orderService = new OrderService();

  int totalCount = 0;
  int totalPage;

  List<OrderList> _orders;

  String _orderStatus;

  bool _isLoading = false;

  _BodyStat(this._orderStatus){
    _loadData();
  }

  ///加载数据
  void _loadData(){
    if(totalPage != null && _currentPage > totalPage){
      //数据已加载完
      return;
    }
    if(!_isLoading){
      _isLoading = true;
      _orderService.myOrderList(_currentPage, _orderStatus).then((httpResult){
        _isLoading = false;
        if(httpResult.success){
          if(_orders == null){
            _orders = new List();
          }
          PageResult pageResult = httpResult.data;
          totalPage = pageResult.totalPage;
          totalCount = pageResult.totalCount;

          if(totalCount != 0){
            _currentPage++;
            _orders.addAll(pageResult.data);
            if(mounted){
              setState(() {});
            }
          }

        }else{
          Fluttertoast.showToast(msg: httpResult.errMsg);
        }
      });
    }
  }

  ///去支付
  void _onPay(int payOrderId){
    Navigator.of(context).push(new MaterialPageRoute(builder: (_){
      return new OrderPayingView(payOrderId);
    }));
  }

  ///取消订单
  void _onCancel(int payOrderId){
    showDialog(context: context,builder: (_){
      return new YesNoDialog('确定取消吗？');
    }).then((val){
      if(val != null && val){
        _orderService.cancel(payOrderId).then((httpResult){
          if(httpResult.success){
            Fluttertoast.showToast(msg: '取消成功');
            setState(() {
              _orders.singleWhere((e)=>e.payOrderId == payOrderId).orderStatus = '订单过期';
            });
          }else{
            Fluttertoast.showToast(msg: httpResult.errMsg);
          }
        });
      }
    });
  }
  ///退款
  void _refund(OrderList order){
    var ticketIds = '';
    for( OrderDetail detail in order.orderDetails){
      ticketIds = ","+detail.orderId.toString();
    }
    ticketIds = ticketIds.substring(1);
    Navigator.of(context).push(new MaterialPageRoute(builder: (_){
      return new RefundView(order.payOrderId, ticketIds);
    }));
  }

  @override
  Widget build(BuildContext context) {
    if(_orders != null && _orders.length == 0){
      ///没有数据
      return Container(
        child: Center(
          child: Text('你还没有此类订单数据'),
        ),
      );
    }
    if(_orders == null){
        ///加载中
      return Center(
        child: Container(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(),
        ),
      );
    }
    return ListView.separated(
        itemCount: totalCount,
        itemBuilder: (context, index){
          if(index < _orders.length){
            return _OrderItem(_orders[index],
              onPay: (payOrderId){_onPay(payOrderId);},
              onCancel: (payOrderId){_onCancel(payOrderId);},
              refund: (orderList){_refund(orderList);},
            );
          }else if(index == _orders.length && index < totalCount){
            //getData
            _loadData();
            return Center(
              child: Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            );
          }else{
            return null;
          }
        },
        separatorBuilder:(context, index){
          return Divider();
        }
    );
  }

}

class _OrderItem extends StatelessWidget{

  final OrderList _order;
  ///支付按键事件
  final Function(int payOrderId) onPay;
  ///取消按钮事件
  final Function(int payOrderId) onCancel;
  ///退款事件
  final Function(OrderList order) refund;

  _OrderItem(this._order, {this.onPay, this.onCancel, this.refund});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('发车时间：${_order.departureTime}', style: TextStyle(fontSize: 12),),
                Text('￥${_order.price}', style: TextStyle(color: Colors.deepOrange),),
              ],
            ),
          ),

          Row(
            children: <Widget>[
              Container(
                width: 20,
              ),
              Container(
                child: Image.asset('images/order_list.jpg', height: 45,),
              ),
              Container(
                height: 60,
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 300,
                      padding: EdgeInsets.only(top: 5, left: 10),
                      child: Text(_order.fromStation),
                    ),
                    Container(
                      width: 300,
                      padding: EdgeInsets.only(bottom: 5, left: 10),
                      child: Text(_order.targetStation),
                    ),
                  ],
                ),
              ),

            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 5,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(_order.orderStatus, style: TextStyle(color: Colors.blue),),
                  orderButton(),
                ],
              ),
          ),
        ],
      ),
    );
  }

  ///订单按钮
  Widget orderButton(){
    if(_order.orderStatus == '待支付'){
      return Container(
        child: Row(
          children: <Widget>[
            FlatButton(
              color: Colors.blue,
              child: Text('支付', style: TextStyle(color: Colors.white),),
              onPressed: (){onPay(_order.payOrderId);},
            ),
            Container(
              width: 10,
            ),
            FlatButton(
              color: Colors.blue,
              child: Text('取消', style: TextStyle(color: Colors.white),),
              onPressed: (){onCancel(_order.payOrderId);},
            )
          ],
        ),
      );
    }else if (_order.orderStatus == '待出行'){
      return Container(
        child: FlatButton(
          color: Colors.blue,
          child: Text('退票', style: TextStyle(color: Colors.white),),
          onPressed: (){refund(_order);},
        ),
      );
    }else{
     return Text('');
    }
  }
}