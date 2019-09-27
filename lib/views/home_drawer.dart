
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///首页侧边栏
class HomeDrawerWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

  }
}
///头像、个人资料
class HomeDrawerHeaderWidget extends StatefulWidget{

  @override
  State createState() {

  }
}
class _HomeDrawerHeaderState extends State<HomeDrawerHeaderWidget>{

  @override
  Widget build(BuildContext context) {
    return new UserAccountsDrawerHeader(accountName: null, accountEmail: null);
  }
}