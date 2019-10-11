import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/model/passenger_model.dart';
import 'package:flutter_scqckypw/service/passenger_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PassengerAddView extends StatefulWidget{

  @override
  State createState() {
    return _PassengerAddState();
  }
}

class _PassengerAddState extends State{

  Passenger _passenger = new Passenger();

  var _passengerService = new PassengerService();

  TextEditingController _nameCtrl;
  TextEditingController _idNoCtrl;


  _PassengerAddState(){
    _passenger.idType = 'id_card';
    _nameCtrl = new TextEditingController();
    _idNoCtrl = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor:  Color(0xFFF0EFF4),
      appBar: AppBar(
        centerTitle: true,
        title: Text('添加乘客'),
      ),
      body: Column(
        children: <Widget>[
          Container(height: 10,),
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 5, right: 5),
            color: Colors.white,
            child:  Row(
              children: <Widget>[
                Container(
                  width: 100,
                  child: Text('姓名：',style: TextStyle(fontSize: 16),),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  width: 200,
                  child: TextFormField(
                    style: TextStyle(fontSize: 15),
                    controller: _nameCtrl,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: '请输入证件上的姓名',
                      border:InputBorder.none
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Divider(height: 5,),
          ),
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 5, right: 5),
            color: Colors.white,
            child:  Row(
              children: <Widget>[
                Container(
                  width: 100,
                  child: Text('证件类型：'),
                ),
                DropdownButtonHideUnderline(
                  child: new DropdownButton(
                    items: [
                      new DropdownMenuItem(
                        child: new Text('身份证'),
                        value: 'id_card',
                      ),
                      new DropdownMenuItem(
                        child: new Text('军人证'),
                        value: 'military_card',
                      ),
                      new DropdownMenuItem(
                        child: new Text('护照'),
                        value: 'passport',
                      ),
                    ],
                    onChanged: (value){
                      setState(() {
                        _passenger.idType = value;
                      });
                    },
                    hint: new Text('请选择'),
                    value: _passenger.idType,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Divider(height: 5,),
          ),
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 5, right: 5),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Container(
                  width: 100,
                  child: Text('证件号：',style: TextStyle(fontSize: 16),),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 0),
                  width: 200,
                  child:  TextFormField(
                    style: TextStyle(fontSize: 15),
                    controller: _idNoCtrl,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: '请输入证件上的号码',
                      border:InputBorder.none
                    ),
                  ),
                ),

              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Divider(height: 5,),
          ),
          Container(
            padding: EdgeInsets.only(top: 5, left: 5, right: 5,bottom: 5),
            color: Colors.white,
            child: Text('购票实行车票实名制，请仔细检查您的姓名和身份信息，确保真实准确，以免耽误您的出行。',
              style: TextStyle(fontSize: 12, color: Colors.deepOrangeAccent), maxLines:2),),
          Container(height: 20,),
          Container(
            height: 40,
            width: 300,
            color: Colors.white,
            child: MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('保存',),
              onPressed: (){
                _passenger.realName = _nameCtrl.text;
                _passenger.idNumber = _idNoCtrl.text;
                _passengerService.add(_passenger).then((res){
                  if(res.isNotEmpty){
                    Fluttertoast.showToast(msg: res);
                  }else{
                    Fluttertoast.showToast(msg: '保存成功').then((_){
                      Navigator.of(context).pop(true);
                    });
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}