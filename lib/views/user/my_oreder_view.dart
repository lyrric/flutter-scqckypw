import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/model/order.dart';


///我的订单
class MyOrderView extends StatefulWidget{

  @override
  State createState() {
    return _BodyStat();
  }
}

class _BodyStat extends State with SingleTickerProviderStateMixin {


  TabController tabCtrl;

  int currentPage = 1;
  final int pageSize = 20;

  List<OrderList> orders;

  _BodyStat(){
    tabCtrl = TabController(length: 4, vsync: this);
    orders = new List();
    var order = OrderList();
    order.tradeNumber = '123456';
    order.payOrderId = 123456;
    order.departureTime = '2019-10-16 09:20';
    order.price = 234.1;
    order.orderStatus = '订单过期';
    order.fromStation = '东站汽车站';
    order.targetStation = '宜宾';
    orders.add(order);
    orders.add(order);
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
          _body(''),
          _body('succeed'),
          _body('pending'),
          _body('backed'),
        ],
        controller: tabCtrl,
      ),
    );

  }

  Widget _body(String orderStatus){
    return ListView.separated(
        itemCount: orders.length,
        itemBuilder: (context, index){
          if(index == orders.length){
            //get
            return Center(
              child: Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            );
          }else if(index < orders.length){
            return _OrderItem(orders[index],
              onPay: (payOrderId){_onPay(payOrderId);},
              onCancel: (payOrderId){_onCancel(payOrderId);},
            );
          }else{
            return null;
          }
        },
        separatorBuilder:(context, index){
          return Divider(color: Colors.red,);
        }
    );
  }
  void _onPay(int payOrderId){

  }
  void _onCancel(int payOrderId){

  }
}

class _OrderItem extends StatelessWidget{

  final OrderList _order;
  ///支付按键事件
  Function(int payOrderId) onPay;
  ///取消按钮事件
  Function(int payOrderId) onCancel;

  _OrderItem(this._order, {this.onPay, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
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