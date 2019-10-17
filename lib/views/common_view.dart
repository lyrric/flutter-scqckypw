import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/service/common_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

///是否确定框
class YesNoDialog extends StatelessWidget {

  final String title;

  var pContent;

  YesNoDialog(this.title, this.pContent);

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
        title: new Text("提示"),
        content: new Text(title),
        actions: <Widget>[
          new FlatButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.check, color: Colors.green,),
                Text(' 确定')
              ],
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          new FlatButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.cancel, color: Colors.red,),
                Text(' 取消')
              ],
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          )
        ]);
  }
}

///验证码输入框
class CaptureCodeDialog extends StatefulWidget {


  final pContent;

  CaptureCodeDialog(this.pContent);

  @override
  State createState() {
    return _CaptureCodeState(pContent);
  }


}
///验证码body
class _CaptureCodeState extends State{

  final pContent;

  var ctrl = new TextEditingController();
  var commonService = new CommonService();
  //验证码数据
  Uint8List captureBytes;

  _CaptureCodeState(this.pContent){
    _initCapture();
  }

  _initCapture(){
    commonService.getCapture().then((data){
      setState(() {
        captureBytes = data;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
        title: new Text("请输入验证码"),
        content:  new Row(
          children: <Widget>[
            new Container(
              height: 100,
              width: 150,
              child:  TextFormField(
                controller: ctrl,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: '请输入验证码',
                  labelText: '验证码',
                ),
              ),
            ),
            new Container(
                height: 100,
                width: 100,
                child: captureBytes==null?Center(child: CircularProgressIndicator(), ):
                new FlatButton(
                  child: Image.memory(captureBytes,width: 100,height:50, fit: BoxFit.fill,),
                  onPressed: (){
                    _initCapture();
                  },)
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.check, color: Colors.green,),
                Text(' 确定')
              ],
            ),
            onPressed: () {
              //判断验证码是否正确
              if(ctrl.text.length >= 4){
                commonService.captureCheck(ctrl.text).then((success){
                  if(success){
                    Navigator.of(context).pop(ctrl.text);
                  }else{
                    Fluttertoast.showToast(msg: '验证码错误');
                  }
                });

              }

            },
          ),
          new FlatButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.cancel, color: Colors.red,),
                Text(' 取消')
              ],
            ),
            onPressed: () {
              Navigator.of(context).pop(null);
            },
          )
        ]);
  }
}
///等待
class WaitingWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return  Center(
      child: Container (
        height: 80,
        width: 80,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
