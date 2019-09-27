
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///首页侧边栏
class HomeDrawerWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return  new ListView(
      padding: const EdgeInsets.only(),
      children: <Widget>[
        new _HomeDrawerHeaderWidget(),
        new ClipRect(
          child: new ListTile(
            leading: new CircleAvatar(child: new Text('A'), ),
            title: new Text("我的信息"),
            onTap: ()=>{},
          ),
        ),
        new ClipRect(
          child: new ListTile(
            leading: new CircleAvatar(child: new Text('B'), ),
            title: new Text("我的订单"),
            onTap: ()=>{},
          ),
        ),
        new ClipRect(
          child: new ListTile(
            leading: new CircleAvatar(child: new Text('C'), ),
            title: new Text("常用乘车人"),
            onTap: ()=>{},
          ),
        ),
        new ClipRect(
          child: new ListTile(
            leading: new CircleAvatar(child: new Text('D'), ),
            title: new Text("关于我们"),
            onTap: ()=>{},
          ),
        ),
      ],
    );
  }
}
///头像、个人资料
class _HomeDrawerHeaderWidget extends StatefulWidget{

  @override
  State createState() {
    return new _HomeDrawerHeaderState();
  }
}
class _HomeDrawerHeaderState extends State<_HomeDrawerHeaderWidget>{

  @override
  Widget build(BuildContext context) {
    return new UserAccountsDrawerHeader(
        accountName: new Text('未登录', ),
        currentAccountPicture: new CircleAvatar(
          backgroundImage: new AssetImage("images/user_default_avatar.jpg"),
        ),
        accountEmail: new Text("186082837**")
    );
  }
}