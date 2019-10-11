import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/model/passenger_model.dart';
import 'package:flutter_scqckypw/model/ticket_model.dart';
import 'package:flutter_scqckypw/service/passenger_service.dart';
import 'package:flutter_scqckypw/service/ticket_service.dart';
import 'package:flutter_scqckypw/views/ticket_list.dart';

import '../data_util.dart';

///确定订单界面
class TicketOrderConfirm extends StatefulWidget {
  final TicketModel _tickerMode;

  TicketOrderConfirm(this._tickerMode);

  @override
  State createState() {
    return new _Body(_tickerMode);
  }
}

class _Body extends State<TicketOrderConfirm> {
  ///车次信息
  TicketModel _tickerMode;

  ///用户常用乘车人
  List<Passenger> _userPassengers;
  ///用户常用乘车人
  List<Passenger> _selectedPassengers = new List();
  ///总共价格
  double _totalPrice = 0.0;
  ///token创建订单时需要
  String _token;

  String _captureCode;

  PassengerService _passengerService = new PassengerService();
  TicketService _ticketService = new TicketService();

  var _contactNameCtrl = new TextEditingController(text: '张三');
  var _contactPhoneCtrl = new TextEditingController(text: '158025466112');

  _Body(this._tickerMode);

  ///加载常用乘车人
  _loadUserPassengers() {
    _passengerService.getPassengers(1).then((data) {
      setState(() {
        _userPassengers = data;
      });
    });
  }
  _initToken(){
    _ticketService.getOrderPageToken(_tickerMode.carryStaId, _tickerMode.departureTime, _tickerMode.signId, _tickerMode.targetStation)
        .then((data){
          _token = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadUserPassengers();
    _initToken();
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
                    controller: _contactNameCtrl,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: '联系人姓名',
                    ),
                  ),
                  TextFormField(
                    controller: _contactPhoneCtrl,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.phone),
                      labelText: '联系人电话',
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
                child: Text('立刻预定'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///选择乘客
  Widget _userPassengerWidget() {
    if (_userPassengers == null) {
      return CircularProgressIndicator();
    } else if (_userPassengers.length == 0) {
      return Container(
        alignment: Alignment.center,
        height: 40,
        width: 170,
        decoration: BoxDecoration(
            border: new Border.all(color: Colors.blue, width: 0.5)),
        child: FlatButton(
          padding: EdgeInsets.zero,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add_circle_outline,
                color: Colors.blue,
              ),
              Text(
                ' 添加乘客(成人)',
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
          onPressed: () {},
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        child: new Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 50,
                  width: 400,
                  child:  ListView.builder(
                      padding:EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: _userPassengers.length+1,
                      itemBuilder: (_, index){
                        if(index < _userPassengers.length){
                          return FlatButton(
                            padding: EdgeInsets.zero,
                            child: Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                border: new Border.all(color: Colors.blue, width: 1)),
                              child: Text(_userPassengers[index].realName, style: TextStyle(fontSize: 14,color: Colors.blue),),
                            ),
                            onPressed: () {
                              setState(() {
                                if(!_selectedPassengers.contains(_userPassengers[index])){
                                  _selectedPassengers.add(_userPassengers[index]);
                                  _totalPrice+=_tickerMode.price;
                                }
                              });

                            },
                          );
                        }else{
                          return  FlatButton(
                            padding: EdgeInsets.zero,
                            child: Container(
                              height: 30,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                  border: new Border.all(color: Colors.blue, width: 1)),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    ' 添加',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {},
                          );
                        }

                      }),
                ),

              ],
            ),
            Divider(
              height: 5,
            ),
            Column(
              children: getSelectedPassengerWidget(),
            )
          ],
        ),
      );
    }
  }

  ///已选择乘客
  List<Widget> getSelectedPassengerWidget(){
    List<Widget> list = new List();
    for(int i=0; i<_selectedPassengers.length; i++){
      list.add(_SelectedPassengers(_selectedPassengers[i], onDelete:(){
        setState(() {
          _selectedPassengers.removeAt(i);
          _totalPrice-=_tickerMode.price;
        });
      }));
    }
    return list;
  }

}

///已选择的乘客item
class _SelectedPassengers extends StatelessWidget{

  final Passenger _passenger;
  final void Function() onDelete;

  _SelectedPassengers(this._passenger, {this.onDelete});

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
              new Row(
                children: <Widget>[
                  new IconButton(
                      icon: Icon(Icons.delete_outline,
                          color: Colors.red),
                      onPressed: () {
                        onDelete();
                      }),
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
