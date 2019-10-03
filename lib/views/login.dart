
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/data/sys_constant.dart';
import 'package:flutter_scqckypw/service/common_service.dart';

class LoginView extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('登陆'),
      ),
      body: _FormView()
    );
  }
}


class _FormView extends StatefulWidget{

  @override
  State createState() {
    return new _FormSate();
  }
}
///表单
class _FormSate extends State<_FormView>{

  final _formKey = GlobalKey<_FormSate>();
  CommonService commonService = new CommonService();
  //验证码数据
  Uint8List captureBytes;


  _FormSate(){
    initCapture();
  }

  void initCapture(){
    commonService.getCapture().then((data){
      setState(() {
        captureBytes = data;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: '请输入用户名',
              labelText: '用户名',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.vpn_key),
              hintText: '请输入密码',
              labelText: '密码',
            ),
          ),
          new Row(
            children: <Widget>[
              new Container(
                width: 250,
                child:  TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: '请输入验证码',
                    labelText: '验证码',
                  ),
                ),
              ),
              new Container(
                width: 150,
                child: captureBytes==null?
                new Text('加载中', style: new TextStyle(fontSize: 8),):
                new FlatButton(
                  child: Image.network(CAPTURE_URL+Random.secure().nextDouble().toString(),width: 150,height:50, fit: BoxFit.fill,),
                  onPressed: (){
                  initCapture();
                },)
              )
            ],
          ),
          new Container(
            padding: EdgeInsets.only(top: 5),
            alignment: Alignment.center,
            child:  new MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              height: 40,
              minWidth: 300,
              child: Text('登陆'),
              onPressed: (){

              },
            ),
          ),

        ],
      ),
    );
  }
}