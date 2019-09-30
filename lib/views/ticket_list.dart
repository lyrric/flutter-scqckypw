import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/model/ticket_model.dart';

class TicketListView extends StatefulWidget {
  //发车城市
  String _fromCity;
  //目标城市
  String _targetCity;
  //处罚日期
  String _date;

  TicketListView(this._fromCity, this._targetCity, this._date);

  @override
  State createState() {
    return TicketListState(_fromCity, _targetCity, _date);
  }
}

class TicketListState extends State<TicketListView> {
  //发车城市
  String _fromCity;
  //目标城市
  String _targetCity;
  //处罚日期
  String _date;

  List<TickerMode> tickets;

  TicketListState(this._fromCity, this._targetCity, this._date);

  @override
  Widget build(BuildContext context) {
    TicketModel ticketModel = new TicketModel();
    ticketModel.price = '100元';
    ticketModel.fromStation = '成都';
    ticketModel.targetStation = '宜宾';
    ticketModel.departureTime = '2019-10-01 07:40';
    ticketModel.mileage = '296公里';
    ticketModel.halfwayStation = '宜宾';
    ticketModel.ticketType = '固定班';
    ticketModel.remainderTicketNum = 10;
    ticketModel.remainderChildTicketNum = 5;
    ticketModel.vehicleType = '中型高二';
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('$_fromCity - $_targetCity'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          new ListItem(ticketModel),
          new ListItem(ticketModel),
        ],
      ),
    );
  }
}

///列表项
class ListItem extends StatelessWidget {

  TicketModel _ticket;

  ListItem(this._ticket);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.zero,
      child:  new Column(
        children: <Widget>[
          new Container(
            decoration:  new BoxDecoration(
              color: Colors.white, // 底色
            ),
            height: 100,
            child: new Column(
              children: <Widget>[
                new Container(
                  decoration:  new BoxDecoration(
                    color: Colors.white, // 底色
                  ),
                  height: 70,
                  margin: EdgeInsets.only(left: 10),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Text(_getTime(), style: new TextStyle(fontSize: 20), ),
                      new Container(
                        width: 200,
                        child:  new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            new Text(_ticket.fromStation,style: new TextStyle(fontSize: 20)),
                            new Container(
                              child:  new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text('途经：${_ticket.halfwayStation}',style: new TextStyle(fontSize: 10)),
                                  new Image.asset("images/arrow_right.png", width: 80, height: 10,),
                                  new Text('里程：${_ticket.mileage}',style: new TextStyle(fontSize: 10)),
                                ],
                              ),
                            ),
                            new Text(_ticket.targetStation,style: new TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                      new Text(_ticket.price,style: new TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
                new Divider(height: 5,color: Colors.blue,),
                new Container(
                  height: 15,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Text('班次类型：${_ticket.ticketType}', style: new TextStyle(fontSize: 10),),
                      new Text('车型：${_ticket.vehicleType}', style: new TextStyle(fontSize: 10),),
                      new Text('票数：${_ticket.remainderTicketNum}', style: new TextStyle(fontSize: 10),),
                      new Text('免票儿童数：${_ticket.remainderChildTicketNum}', style: new TextStyle(fontSize: 10),),
                    ],
                  ),
                ),

              ],
            ),
          ),
          new Container(
            decoration:  new BoxDecoration(
            ),
            height: 10,
          ),
        ],
      ),
      onPressed: (){
        //点击事件

      },
    );
     
  }

  String _getTime() {
    return _ticket.departureTime.split(' ')[1];
  }
}