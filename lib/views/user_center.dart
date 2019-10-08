import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/data/data.dart';
import 'package:flutter_scqckypw/views/user_center_edit.dart';

class UserCenter extends StatefulWidget{


  @override
  State createState() {
    return _UserCenterState();
  }
}

class _UserCenterState extends State<UserCenter>{


  double _lineHeight = 25;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text('个人信息'),
        actions: <Widget>[
            IconButton(icon: Icon(Icons.edit),
            onPressed: (){
                Navigator.of(context).push(new MaterialPageRoute(builder: (_){
                  return new UserCenterEditView(Data.user.realName, Data.user.sex, Data.user.idType, Data.user.idNo);
                }));
            },)
        ],
      ),
      body: new ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 10),
            child: new Column(
              children: <Widget>[
                Container(
                  height: _lineHeight,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('用户名',style: TextStyle(fontSize: 16)),
                      Text(Data.user.username,style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                Divider(),

                Container(
                  height: _lineHeight,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('真实姓名',style: TextStyle(fontSize: 16)),
                      Text(Data.user.realName,style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                Divider(),

                Container(
                  height: _lineHeight,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('性别',style: TextStyle(fontSize: 16)),
                      Text(Data.user.sex,style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  height: _lineHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('证件', style: TextStyle(fontSize: 16),),
                      Text(Data.user.idNo,style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  height: _lineHeight,
                  child:    new FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('绑定手机',style: TextStyle(fontSize: 16)),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(Data.user.phone,style: TextStyle(fontSize: 16)),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Divider(),
                Container(
                  height: _lineHeight,
                  child:    new FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('绑定邮箱',style: TextStyle(fontSize: 16)),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(Data.user.email,style: TextStyle(fontSize: 16)),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}