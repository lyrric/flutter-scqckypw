import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/model/http_result.dart';
import 'package:flutter_scqckypw/model/order.dart';
import 'package:flutter_scqckypw/model/page_result.dart';
import 'package:flutter_scqckypw/service/order_service.dart';
import 'package:fluttertoast/fluttertoast.dart';


///我的订单
class MyOrderView extends StatefulWidget{

  @override
  State createState() {
    return _MyOrderViewStat();
  }
}

class _MyOrderViewStat extends State with SingleTickerProviderStateMixin {

  TabController tabCtrl;

  _MyOrderViewStat(){
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
            _Body(''),
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
            setState(() {});
          }

        }else{
          Fluttertoast.showToast(msg: httpResult.errMsg);
        }
      });
    }
  }
  void _onPay(int payOrderId){

  }
  void _onCancel(int payOrderId){

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

  _OrderItem(this._order, {this.onPay, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 5, left: 10, right: 10),
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
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Image.asset('images/order_list.jpg', height: 50,),
              ),
              Container(
                height: 70,
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
                  Text(_order.orderStatus),
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
    if(_order.orderStatus == '交易成功' ||_order.orderStatus == '订单过期'){
      return Text('');
    }else{
      return Container(
        child: Row(
          children: <Widget>[
            FlatButton(
              child: Text('支付'),
              onPressed: onPay(_order.payOrderId),
            ),
            FlatButton(
              child: Text('取消'),
              onPressed: onCancel(_order.payOrderId),
            )
          ],
        ),
      );
    }

  }
}