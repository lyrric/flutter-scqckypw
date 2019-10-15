
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/data/data.dart';
import 'package:flutter_scqckypw/service/user_service.dart';
import 'package:flutter_scqckypw/views/login.dart';
import 'package:flutter_scqckypw/views/passenger/passenger_mgr.dart';
import 'package:flutter_scqckypw/views/user/my_oreder_view.dart';
import 'package:flutter_scqckypw/views/user/user_center.dart';

///首页侧边栏
class HomeDrawerWidget extends StatelessWidget{



  @override
  Widget build(BuildContext context) {

    return  new ListView(
      padding: const EdgeInsets.only(),
      children: <Widget>[
        new _UserDrawerHeader(),
        new ClipRect(
          child: new ListTile(
            leading: new CircleAvatar(child: new Text('A'), ),
            title: new Text("我的信息"),
            onTap: (){
              if(Data.cookie.isNotEmpty){
                Navigator.of(context).push(new MaterialPageRoute(builder: (_){
                  return new UserCenter();
                }));
              }

            },
          ),
        ),
        new ClipRect(
          child: new ListTile(
            leading: new CircleAvatar(child: new Text('B'), ),
            title: new Text("我的订单"),
            onTap: (){
              Navigator.of(context).push(new MaterialPageRoute(builder: (_){
                return new MyOrderView();
              }));
            },
          ),
        ),
        new ClipRect(
          child: new ListTile(
            leading: new CircleAvatar(child: new Text('C'), ),
            title: new Text("常用乘车人"),
            onTap: (){
              if(Data.cookie.isNotEmpty){
                Navigator.of(context).push(new MaterialPageRoute(builder: (_){
                  return new PassengerMgrView();
                }));
              }
            },
          ),
        ),
        new ClipRect(
          child: new ListTile(
            leading: new CircleAvatar(child: new Text('D'), ),
            title: new Text("关于我们"),
            onTap: (){},
          ),
        ),
      ],
    );
  }
}
class _UserDrawerHeader extends StatefulWidget{

  @override
  State createState() {
    return new _UserDrawerHeaderStat();
  }
}

class _UserDrawerHeaderStat extends State<_UserDrawerHeader>{

  UserService _userService = new UserService();

  @override
  Widget build(BuildContext context) {
    return new DrawerHeader(
      padding: EdgeInsets.zero,
      child: FlatButton(
        padding: EdgeInsets.zero,
        child: new Stack(
          children: <Widget>[
            new Image.asset("images/user_header_bg.jpg", fit: BoxFit.fill, width: double.infinity,),
            new Align(
              alignment: FractionalOffset.bottomLeft,
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new CircleAvatar(
                    backgroundImage: AssetImage("images/user_default_avatar.jpg"),
                    radius: 35.0,
                  ),
                  new Container(
                    height: 70,
                    margin: EdgeInsets.only(left: 12.0, bottom: 12.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(Data.user.username, style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),),
                        new Text(Data.user.email, style: new TextStyle(
                            fontSize: 14.0, color: Colors.white),),
//                      new Text(Data.user.phone, style: new TextStyle(
//                          fontSize: 14.0, color: Colors.white),),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        onPressed: (){
          Navigator.of(context).push(new MaterialPageRoute(builder:(_){
            return new LoginView();
          })).then((res){
            if(res != null && res){
              _userService.getUser().then((_){
                setState(() {

                });
              });
            }
          });
        },
      )
    );
  }
}