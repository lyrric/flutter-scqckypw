
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/data/data.dart';
import 'package:flutter_scqckypw/service/user_service.dart';
import 'package:flutter_scqckypw/views/common_view.dart';
import 'package:flutter_scqckypw/views/login.dart';
import 'package:flutter_scqckypw/views/passenger/passenger_mgr.dart';
import 'package:flutter_scqckypw/views/user/my_oreder_list_view.dart';
import 'package:flutter_scqckypw/views/user/user_center.dart';

///首页侧边栏
class HomeDrawerWidget extends StatefulWidget{


  @override
  State createState() {
    return _HomeDrawerStat();
  }
}

class _HomeDrawerStat extends State{

  @override
  Widget build(BuildContext context) {
    return  ListView(
      padding: const EdgeInsets.only(),
      children: <Widget>[
        _UserDrawerHeader(),
        ClipRect(
          child: ListTile(
            leading: CircleAvatar(child: Text('A'), ),
            title: Text("我的信息"),
            onTap: (){
              if(Data.cookie.isNotEmpty){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return UserCenter();
                }));
              }

            },
          ),
        ),
        ClipRect(
          child: ListTile(
            leading: CircleAvatar(child: Text('B'), ),
            title: Text("我的订单"),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_){
                return MyOrderListView();
              }));
            },
          ),
        ),
        ClipRect(
          child: ListTile(
            leading: CircleAvatar(child: Text('C'), ),
            title: Text("常用乘车人"),
            onTap: (){
              if(Data.cookie.isNotEmpty){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return PassengerMgrView();
                }));
              }
            },
          ),
        ),
        ClipRect(
          child: ListTile(
            leading: CircleAvatar(child: Text('D'), ),
            title: Text("关于我们"),
            onTap: (){},
          ),
        ),
        Data.cookie.isEmpty?Text(''):ClipRect(
          child: ListTile(
            leading: CircleAvatar(child: Text('D'), ),
            title: Text("退出登陆"),
            onTap: (){
                showDialog(context: context,builder: (_){
                  return YesNoDialog('确定退出吗？');
                }).then((result){
                  if(result){
                    setState(() {
                      Data.logout();
                    });
                  }
                });

            },
          ),
        ),
      ],
    );
  }
}

class _UserDrawerHeader extends StatefulWidget{

  @override
  State createState() {
    return _UserDrawerHeaderStat();
  }
}

class _UserDrawerHeaderStat extends State<_UserDrawerHeader>{

  UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: EdgeInsets.zero,
      child: FlatButton(
        padding: EdgeInsets.zero,
        child: Stack(
          children: <Widget>[
            Image.asset("images/user_header_bg.jpg", fit: BoxFit.fill, width: double.infinity,),
            Align(
              alignment: FractionalOffset.bottomLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage("images/user_default_avatar.jpg"),
                    radius: 35.0,
                  ),
                  Container(
                    height: 70,
                    margin: EdgeInsets.only(left: 12.0, bottom: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(Data.user.username, style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),),
                        Text(Data.user.email, style: TextStyle(
                            fontSize: 14.0, color: Colors.white),),
//                      Text(Data.user.phone, style: TextStyle(
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
          Navigator.of(context).push(MaterialPageRoute(builder:(_){
            return LoginView();
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