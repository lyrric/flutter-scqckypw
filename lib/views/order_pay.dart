import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/data/sys_constant.dart';
import 'package:flutter_scqckypw/model/http_result.dart';
import 'package:flutter_scqckypw/model/passenger_model.dart';
import 'package:flutter_scqckypw/model/ticket_model.dart';
import 'package:flutter_scqckypw/service/order_service.dart';
import 'package:flutter_scqckypw/views/pay_web_view.dart';
import 'package:flutter_scqckypw/views/ticket_list.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../data_util.dart';

class OrderPayingView extends StatefulWidget{

  ///车次信息
  final TicketModel _tickerMode;
  ///用户常用乘车人
  final List<Passenger> _selectedPassengers;
  ///总共价格
  final double _totalPrice;

  final String contactName;

  final String contactPhone;

  final int orderId;


  OrderPayingView(this._tickerMode, this._selectedPassengers, this._totalPrice,
      this.contactName, this.contactPhone, this.orderId);

  @override
  State createState() {
    return _OrderPayingState(_tickerMode, _selectedPassengers, _totalPrice, contactName, contactPhone, orderId);
  }
}

///订单支付界面
class _OrderPayingState extends State {

  ///车次信息
  final TicketModel _tickerMode;
  ///用户常用乘车人
  final List<Passenger> _selectedPassengers;
  ///总共价格
  final double _totalPrice;

  final String contactName;

  final String contactPhone;

  final int orderId;

  _OrderPayingState(this._tickerMode, this._selectedPassengers,
      this._totalPrice, this.contactName, this.contactPhone, this.orderId);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFFF0EFF4),
      appBar: new AppBar(
        title: Text('确认订单'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: ListView(
          children: <Widget>[
            new TicketItem(_tickerMode),
            new Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    readOnly: true,
                    initialValue: contactName,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                    ),
                  ),
                  TextFormField(
                    readOnly: true,
                    initialValue: contactPhone,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.phone),
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              height: 10,
            ),
            new Container(
              decoration: BoxDecoration(color: Colors.white),
              child: new Column(
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
                  Divider(),
                  new Container(
                    padding: EdgeInsets.only(bottom: 5),
                    alignment: Alignment.center,
                    child: _userPassengerWidget(),
                  ),
                ],
              ),
            ),
            new Container(
              height: 10,
            ),
            new Container(
              decoration: BoxDecoration(color: Colors.white),
              height: 50,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text('总价'),
                  Text('￥$_totalPrice', style: TextStyle(color: Colors.deepOrangeAccent,),),
                ],
              ),
            ),
            new Container(
              decoration: new BoxDecoration(),
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              child: new MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                height: 40,
                minWidth: 350,
                child: Text('支付'),
                onPressed: () async {
                 _pay('alipay');
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  _pay(String payWay) async {
    Navigator.of(context).push(new MaterialPageRoute(builder: (_){
      return new PayWebView(PAY_MIDDLE_URL+'?payid='+orderId.toString()+'&plateform='+payWay);
    }));
  }

  ///选择乘客
  Widget _userPassengerWidget() {
    return Container(
      color: Colors.white,
      child:  Column(
        children: getSelectedPassengerWidget(),
      )
    );
  }

  ///已选择乘客
  List<Widget> getSelectedPassengerWidget(){
    List<Widget> list = new List();
    for(int i=0; i<_selectedPassengers.length; i++){
      list.add(_SelectedPassengers(_selectedPassengers[i]));
    }
    return list;
  }

}

///已选择的乘客item
class _SelectedPassengers extends StatelessWidget{

  final Passenger _passenger;

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
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Text(
                        _passenger.realName,
                      ),
                      new Text(
                        '  成人票',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: new Text(
                        convertIdTypeByVal(_passenger.idType) +
                            ' ${_passenger.idNumber}'),
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
