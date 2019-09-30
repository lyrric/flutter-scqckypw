import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/model/city_model.dart';
import 'package:flutter_scqckypw/model/ticket_model.dart';
import 'package:flutter_scqckypw/service/ticket_service.dart';

class TicketListView extends StatefulWidget {
  //发车城市
  CityModel _fromCity;
  //目标城市
  CityModel _targetCity;
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
  CityModel _fromCity;
  //目标城市
  CityModel _targetCity;
  //处罚日期
  String _date;

  List<TicketModel> _tickets;

  TicketListState(this._fromCity, this._targetCity, this._date){
    TicketService ticketService = new TicketService();
    ticketService.getTickets(_fromCity, _targetCity, _date).then((data){
      super.setState((){
        _tickets =  data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('${_fromCity.name} - ${_targetCity.name}'),
        centerTitle: true,
      ),
      body: _getBody()
    );
  }
  Widget _getBody(){
    if(_tickets == null){
      //加载中
      return new Text('加载中');
    }else if(_tickets.length == 0){
      //暂无数据
      return new Text('暂无数据');
    }else{
      List<Widget> list = new List();
      for(TicketModel ticket in _tickets){
        list.add(new ListItem(ticket));
      }return ListView(
        children: list
      );
    }
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
                                  new Text('里程：${_ticket.mileage}公里',style: new TextStyle(fontSize: 10)),
                                ],
                              ),
                            ),
                            new Text(_ticket.targetStation,style: new TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                      new Text('${_ticket.price}元',style: new TextStyle(fontSize: 20)),
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