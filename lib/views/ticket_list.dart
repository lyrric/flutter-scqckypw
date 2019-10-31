import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/data/request_status.dart';
import 'package:flutter_scqckypw/model/city_model.dart';
import 'package:flutter_scqckypw/model/ticket_model.dart';
import 'package:flutter_scqckypw/service/ticket_service.dart';
import 'package:flutter_scqckypw/views/common_view.dart';
import 'package:flutter_scqckypw/views/order_confirm.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  //出发日期
  String _date;

  //请求状态
  RequestStatus _status = RequestStatus.LOADING;

  List<TicketModel> _tickets;




  TicketListState(this._fromCity, this._targetCity, this._date){
    initData();
  }

  initData(){
    if(mounted){
      setState(() {
        _status = RequestStatus.LOADING;
      });
    }
    TicketService().getTickets(_fromCity, _targetCity, _date).then((data){
          _status = RequestStatus.SUCCESS;
          _tickets = data;
    }).catchError((_){
        _status = RequestStatus.NETWORK_ERROR;
    }).whenComplete((){setState(() {

    });});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_fromCity.name} - ${_targetCity.name}'),
        centerTitle: true,
      ),
      body: _Body()
    );
  }

  Widget _Body(){
    var preWidget = PreWidget(_status, initData);
    if(preWidget != null){
      return preWidget;
    }
    if(_tickets.length == 0){
      //暂无数据
      return Center(
          child:Text('暂无数据')
      );
    }else{
      List<Widget> list = List();
      for(TicketModel ticket in _tickets){
        list.add(_ListItem(ticket));
      }return ListView(
        children: list
      );
    }
  }
}

///列表项
class _ListItem extends StatelessWidget {

  final TicketModel _ticket;

  _ListItem(this._ticket);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.zero,
      child:  TicketItem(_ticket),
      onPressed: (){
        //点击事件
        Navigator.of(context).push(MaterialPageRoute(builder: (_){
          return TicketOrderConfirm(_ticket);
        }));
      },
    );
     
  }


}

class TicketItem extends StatelessWidget{

  TicketModel _ticket;

  TicketItem(this._ticket);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration:  BoxDecoration(
            color: Colors.white, // 底色
          ),
          height: 100,
          child: Column(
            children: <Widget>[
              Container(
                decoration:  BoxDecoration(
                  color: Colors.white, // 底色
                ),
                height: 70,
                margin: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child: Text(_getTime(), style: TextStyle(fontSize: 20), ),
                    ),
                    Container(
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 100,
                            padding: EdgeInsets.only(left: 10),
                            //decoration: new
                            child: Text(_ticket.fromStation,style: TextStyle(fontSize: 15), overflow: TextOverflow.ellipsis,),
                          ),
                          Container(
                            width: 80,
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('途经：${_ticket.halfwayStation}',style: TextStyle(fontSize: 10)),
                                Image.asset("images/arrow_right.png", width: 80, height: 10,),
                                Text('里程：${_ticket.mileage}公里',style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                          Container(
                            //decoration: ne
                            width: 100,
                            padding: EdgeInsets.only(left: 10),
                            child: Text(_ticket.targetStation,style: TextStyle(fontSize: 15), overflow: TextOverflow.ellipsis,),
                          ),
                        ],
                      ),
                    ),
                    Text('${_ticket.price}元',style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
              Divider(height: 5,color: Colors.blue,),
              Container(
                padding: EdgeInsets.only(top: 5),
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('班次类型：${_ticket.ticketType}', style: TextStyle(fontSize: 10),),
                    Text('车型：${_ticket.vehicleType}', style: TextStyle(fontSize: 10),),
                    Text('票数：${_ticket.remainderTicketNum}', style: TextStyle(fontSize: 10),),
                    Text('免票儿童数：${_ticket.remainderChildTicketNum}', style: TextStyle(fontSize: 10),),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration:  BoxDecoration(
              color: Color(0xFFF0EFF4)
          ),
          height: 10,
        ),
      ],
    );
  }
  String _getTime() {
    return _ticket.departureTime.split(' ')[1];
  }
}