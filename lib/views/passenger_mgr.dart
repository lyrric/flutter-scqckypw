
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/data_util.dart';
import 'package:flutter_scqckypw/model/passenger_model.dart';

///乘车人管理
class PassengerMgrView extends StatefulWidget{

  @override
  State createState() {
    return new _PassengerMgrState();
  }
}


class _PassengerMgrState extends State<PassengerMgrView> {


  List<PassengerModel> _passengers;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFFF0EFF4),
      appBar: new AppBar(
        title: Text('乘车人管理'),
      ),
      body: ListView(
        children: <Widget>[
          Container(height: 10,),
          Container(
              height: 40,
              width: 170,
              decoration: BoxDecoration(
                  border: new Border.all(color: Colors.blue, width: 0.5)
              ),
              alignment: Alignment.center,
              color: Colors.white,
              child: FlatButton(
                padding: EdgeInsets.zero,
                child: new Row(
                  children: <Widget>[
                    Icon(Icons.add_circle_outline, color: Colors.blue,),
                    Text('添加乘客')
                  ],
                ),
                onPressed: () {

                },
              )
          ),
          Container(height: 10,),

        ],
      ),
    );
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
      return ListView.builder(
          itemCount: _passengers.length,
          itemBuilder: (BuildContext context, int index) {
            return _PassengerItem(_passengers[index]);
          });
    }
  }
}

class _PassengerItem extends StatelessWidget{

  final PassengerModel _passenger;

  _PassengerItem(this._passenger);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Text(_passenger.realName,),
                new Text('  成人票', style: TextStyle(fontSize: 12),),
              ],
            ),
            new Text(convertIdTypeByVal(_passenger.idType) + ' ${_passenger.idNumber}'),
          ],
        ),
        new Row(
          children: <Widget>[
            new IconButton(icon: Icon(Icons.edit, color: Colors.blue,), onPressed: null),
            new IconButton(icon: Icon(Icons.delete_outline, color: Colors.red), onPressed: null),
          ],
        ),
      ],
    );
  }


}

