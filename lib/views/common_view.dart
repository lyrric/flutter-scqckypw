import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/data/request_status.dart';
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
                Text('确定')
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

///公共方法
Widget PreWidget(RequestStatus status, Function retryMethod){
  if(status == RequestStatus.LOADING){
    //加载中
    return Center(
        child: Container(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(),
        )
    );
  }
  if(status == RequestStatus.NETWORK_ERROR){
    ///出错了
    return NetworkErrorView(retryMethod);
  }
  return null;
}

///网络异常
class NetworkErrorView extends StatelessWidget{

  Function retryMethod;

  NetworkErrorView(this.retryMethod);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        width: 200,
        child: Column(
          children: <Widget>[
            Image.asset('images/network-error.jpg', width: 100,),
            Container(height: 20,),
            Text('诶呀，网络出了问题', style: TextStyle(fontSize: 16),),
            Container(height: 20,),
            Container(
              decoration: new BoxDecoration(
                border: new Border.all(color: Colors.blue, width: 0.5), // 边色与边宽度
                //color: Color(0xFF9E9E9E), // 底色
                borderRadius: new BorderRadius.circular((20.0)), // 圆角度/ 也可控件一边圆角大小
              ),
              alignment: Alignment.center,
              child:  MaterialButton(
                  textColor: Colors.white,
                  height: 40,
                  minWidth: 150,
                  child: Text('重新加载', style: TextStyle(color: Colors.blue, fontSize: 18),),
                  onPressed: retryMethod
              ),
            ),

          ],
        ),
      ),
    );
  }
}
///是否确定框
class RetryDialog extends StatelessWidget {

  final String title;

  RetryDialog(this.title);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title),
        content: Text('是否重试？'),
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.check, color: Colors.green,),
                Text('重试')
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
