import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
