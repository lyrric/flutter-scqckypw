import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/data/data.dart';
import 'package:flutter_scqckypw/service/user_service.dart';
import 'package:flutter_scqckypw/views/user_center_edit.dart';

class UserCenter extends StatefulWidget{


  @override
  State createState() {
    return _UserCenterState();
  }
}

class _UserCenterState extends State<UserCenter>{


  double _lineHeight = 25;
  UserService _userService = new UserService();

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
                })).then((flag){
                  if(flag != null && flag){
                    _userService.getUser().then((ret){
                      setState(() {

                      });
                    });
                  }
                });
            },)
        ],
      ),
      body: new ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 10),
            child: new Column(
              children: <Widget>[
                lineWidget('用户名', Data.user.username),
                Divider(),
                lineWidget('真实姓名', Data.user.realName),
                Divider(),
                lineWidget('性别', Data.user.sex),
                Divider(),
                lineWidget('证件', dealIdNo(Data.user.idNo)),
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

  String dealIdNo(String idNo){
    if(idNo == '未添加'){
      return idNo;
    }else{
      return idNo.substring(0, 4) + '***';
    }
  }

  Widget lineWidget(String key, String value){
    return   Container(
      height: _lineHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(key, style: TextStyle(fontSize: 16),),
          Text(value,style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}