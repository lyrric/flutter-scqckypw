import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/core/exception_handler.dart';
import 'package:flutter_scqckypw/model/passenger_model.dart';
import 'package:flutter_scqckypw/model/ticket_model.dart';
import 'package:flutter_scqckypw/service/common_service.dart';
import 'package:flutter_scqckypw/service/order_service.dart';
import 'package:flutter_scqckypw/service/passenger_service.dart';
import 'package:flutter_scqckypw/service/ticket_service.dart';
import 'package:flutter_scqckypw/views/common_view.dart';
import 'package:flutter_scqckypw/views/order_pay.dart';
import 'package:flutter_scqckypw/views/passenger/passenger_mgr.dart';
import 'package:flutter_scqckypw/views/ticket_list.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../util/data_util.dart';

///确定订单界面
class TicketOrderConfirm extends StatefulWidget {
  final TicketModel _tickerMode;

  TicketOrderConfirm(this._tickerMode);

  @override
  State createState() {
    return _Body(_tickerMode);
  }
}

class _Body extends State<TicketOrderConfirm> {
  ///车次信息
  TicketModel _tickerMode;

  ///用户常用乘车人
  List<Passenger> _userPassengers;
  ///用户常用乘车人
  List<Passenger> _selectedPassengers = List();
  ///总共价格
  double _totalPrice = 0.0;
  ///token创建订单时需要
  String _token;

  var orderService = OrderService();

  var _ticketService = TicketService();
  var _contactNameCtrl = TextEditingController(text: '张三');
  var _contactPhoneCtrl = TextEditingController(text: '158025466112');

  _Body(this._tickerMode){
    _initToken();
  }

  ///加载常用乘车人
  _loadUserPassengers() {
    PassengerService().getPassengers(1).then((data) {
      _userPassengers = data;
    }).catchError((error){
      Fluttertoast.showToast(msg: '加载乘车人失败');
    }).whenComplete((){setState(() {

    });});
  }

  _initToken(){
    _ticketService.getOrderPageToken(_tickerMode.carryStaId, _tickerMode.departureTime, _tickerMode.signId, _tickerMode.targetStation)
        .catchError((error){ })
        .then((data){_token = data;})
        .whenComplete((){setState(() {});});
  }

  @override
  Widget build(BuildContext context) {
    _loadUserPassengers();
    return Scaffold(
      backgroundColor: Color(0xFFF0EFF4),
      appBar: AppBar(
        title: Text('确认订单'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: ListView(
          children: <Widget>[
            TicketItem(_tickerMode),
            Container(
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
                  Divider(),
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
                child: Text('立刻预定'),
                onPressed: () {
                  //正确
                  showDialog(context: context, builder: (_){
                    return LoadingDialog(text:'创建订单中，请勿返回');
                  });
                  CommonService().getCaptchaCode().then((code){
                      orderService.order(_tickerMode, _selectedPassengers, _contactNameCtrl.text, _contactNameCtrl.text, _token, code)
                          .then((data){
                              Navigator.pop(context);
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_){
                                return OrderPayingView(data);
                              })); });
                  }).catchError(ExceptionHandler(pop: true, showErrorType: ShowErrorType.TOAST).handException);
                },
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
            border: Border.all(color: Colors.blue, width: 0.5)),
        child: FlatButton(
          padding: EdgeInsets.zero,
          child: Row(
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
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_){
              return PassengerMgrView();
            })).whenComplete((){
             setState(() {
               _loadUserPassengers();
             });
            });
          },
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        child: Column(
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
                                border: Border.all(color: Colors.blue, width: 1)),
                              child: Text(_userPassengers[index].realName, style: TextStyle(fontSize: 14,color: Colors.blue),),
                            ),
                            onPressed: () {
                              setState(() {
                                if(!_selectedPassengers.any((t)=>t.id == _userPassengers[index].id)){
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
                                  border: Border.all(color: Colors.blue, width: 1)),
                              child: Row(
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
    List<Widget> list = List();
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        _passenger.realName,
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
                        convertIdTypeByVal(_passenger.idType) +
                            ' ${_passenger.idNumber}'),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
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
