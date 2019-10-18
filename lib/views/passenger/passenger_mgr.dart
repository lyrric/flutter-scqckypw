
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/util/data_util.dart';
import 'package:flutter_scqckypw/model/passenger_model.dart';
import 'package:flutter_scqckypw/service/passenger_service.dart';
import 'package:flutter_scqckypw/views/passenger/passenger_add.dart';
import 'package:flutter_scqckypw/views/passenger/passenger_edit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../common_view.dart';

///乘车人管理
class PassengerMgrView extends StatefulWidget{

  @override
  State createState() {
    return new _PassengerMgrState();
  }
}


class _PassengerMgrState extends State<PassengerMgrView> {


  PassengerService _passengerService = new PassengerService();

  List<Passenger> _passengers;

  void _initPassenger(){
    _passengerService.getPassengers(1).then((httpResult){
      if(httpResult.success){
        setState(() {
          _passengers = httpResult.data;
        });
      }else{
        Fluttertoast.showToast(msg: httpResult.errMsg);
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    _initPassenger();
    return new Scaffold(
      backgroundColor: Color(0xFFF0EFF4),
      appBar: new AppBar(
        centerTitle: true,
        title: Text('乘车人管理'),
      ),
      body: Column(
        children: <Widget>[
          Container(height: 10,),
          Container(
              height: 40,
              alignment: Alignment.center,
              color: Colors.white,
              child: FlatButton(
                padding: EdgeInsets.zero,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add_circle_outline, color: Colors.blue,),
                    Text(' 添加乘客', style: TextStyle(color: Colors.blue),)
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(builder: (_){
                    return new PassengerAddView();
                  }));
                },
              )
          ),
          Container(height: 10,),
          passengerListWidget(),
        ],
      ),
    );
  }
  ///当修改，新增时，删除时重新获取数据
  ///由于变更后，直接跳转到乘客页面，所以无法判断是否添加成功，这里都认为是添加成功了
  void onUpdate(bool result){
    _initPassenger();
  }

  Widget passengerListWidget() {
    if (_passengers == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (_passengers.length == 0) {
      return Center(
        child: Text('你没有添加乘客信息'),
      );
    } else {
      return Expanded(
        child: ListView.builder(
            itemCount: _passengers.length,
            itemBuilder: (BuildContext context, int index) {
              return _PassengerItem(_passengers[index], (res){onUpdate(res);});
            }),
      );
    }
  }
}

class _PassengerItem extends StatelessWidget{

  final Passenger _passenger;

  final void Function(bool result) onUpdate;

  final _passengerService = new PassengerService();

  _PassengerItem(this._passenger, this.onUpdate);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 60,
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
                      new Text(_passenger.realName,),
                      new Text('  成人票', style: TextStyle(fontSize: 12),),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: new Text(convertIdTypeByVal(_passenger.idType) + ' ${_passenger.idNumber}'),
                  ),

                ],
              ),
              new Row(
                children: <Widget>[
                  new IconButton(icon: Icon(Icons.edit, color: Colors.blue,), onPressed: (){
                    Navigator.of(context).push(new MaterialPageRoute(builder: (_){
                      return new PassengerEditView(_passenger);
                    })).then((result){
                      onUpdate(result);
                    });
                  }),
                  new IconButton(icon: Icon(Icons.delete_outline, color: Colors.red), onPressed: (){

                    showDialog(context: context,builder: (content){
                      return new YesNoDialog('是否删除', context);
                    }).then((val){
                      if(val != null && val){
                        _passengerService.delete(_passenger.id).then((result){
                          onUpdate(true);
                        });
                      }
                    });
                  }),
                ],
              ),
            ],
          ),
        ),
        new Container(height: 10,)
      ],
    );
  }
}



