
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/model/ticket_model.dart';
import 'package:flutter_scqckypw/views/ticket_list.dart';

///确定订单界面
class TicketOrderConfirm extends StatefulWidget{


  final TicketModel _tickerMode;


  TicketOrderConfirm(this._tickerMode);

  @override
  State createState() {
    return new _Body(_tickerMode);
  }
}

class _Body extends State<TicketOrderConfirm>{


  TicketModel _tickerMode;

  _Body(this._tickerMode);

  //总共价格
  double _totalPrice = 0.0;

  var _contactNameCtrl = new TextEditingController(text: '张三');
  var _contactPhoneCtrl= new TextEditingController(text: '158025466112');

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
              new Container(height: 10, ),
              new Container(
                decoration: BoxDecoration(color: Colors.white),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text('乘客', style: TextStyle(fontSize: 12),),
                    ),
                    Divider(),
                    new Container(
                      padding: EdgeInsets.only(bottom: 5),
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 170,
                        decoration: BoxDecoration(
                            border: new Border.all(color: Colors.blue, width: 0.5)
                        ),
                        child: FlatButton(
                          padding: EdgeInsets.zero,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.add_circle_outline, color: Colors.blue,),
                              Text(' 添加乘客(成人)', style: TextStyle(color: Colors.blue),),
                            ],
                          ),
                          onPressed: (){

                          },
                        ),
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
                height: 50,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text('总价'),
                    Text('￥$_totalPrice'),
                  ],
                ),
              ),

              new Container(
                decoration:  new BoxDecoration(
                ),
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                child:  new MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  height: 40,
                  minWidth: 350,
                  child: Text('立刻预定'),
                  onPressed: (){

                  },),
              ),
            ],
          ),
        ),
      );
  }
}