import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/service/common_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

///是否确定框
class YesNoDialog extends StatelessWidget {

  final String title;


  YesNoDialog(this.title);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("提示"),
        content: Text(title),
        actions: <Widget>[
          FlatButton(
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
          FlatButton(
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

  var ctrl = TextEditingController();
  var commonService = CommonService();
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
    return AlertDialog(
        title: Text("请输入验证码"),
        content:  Row(
          children: <Widget>[
            Container(
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
            Container(
                height: 100,
                width: 100,
                child: captureBytes==null?Center(child: CircularProgressIndicator(), ):
                FlatButton(
                  child: Image.memory(captureBytes,width: 100,height:50, fit: BoxFit.fill,),
                  onPressed: (){
                    _initCapture();
                  },)
            )
          ],
        ),
        actions: <Widget>[
          FlatButton(
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
          FlatButton(
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
class LoadingDialog extends StatelessWidget{

  String text = '获取数据中...';

  LoadingDialog({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Material( //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center( //保证控件居中效果
        child: SizedBox(
          width: 120.0,
          height: 120.0,
          child: Container(
            decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///提示框
class MessageDialog extends StatelessWidget{

  final String _text;

  MessageDialog(this._text);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_text),
      actions: <Widget>[
        FlatButton(
          child: Text('确定'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
