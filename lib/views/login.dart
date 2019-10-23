
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/core/exception_handler.dart';
import 'package:flutter_scqckypw/data/data.dart';
import 'package:flutter_scqckypw/data/sys_constant.dart';
import 'package:flutter_scqckypw/model/http_result.dart';
import 'package:flutter_scqckypw/service/common_service.dart';
import 'package:flutter_scqckypw/service/login_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'common_view.dart';

class LoginView extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登陆'),
      ),
      body: _FormView()
    );
  }
}


class _FormView extends StatefulWidget{

  @override
  State createState() {
    return _FormSate();
  }
}
///表单
class _FormSate extends State<_FormView>{

  final _formKey = GlobalKey<_FormSate>();

  TextEditingController _usernameController = TextEditingController(text: '0');
  TextEditingController _passwordController = TextEditingController(text: '0');


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: '请输入用户名',
              labelText: '用户名',
            ),
          ),
          TextFormField(
            obscureText: true,
            controller: _passwordController,
            decoration: const InputDecoration(
              icon: Icon(Icons.vpn_key),
              hintText: '请输入密码',
              labelText: '密码',
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            alignment: Alignment.center,
            child:  MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              height: 40,
              minWidth: 300,
              child: Text('登陆'),
              onPressed: (){
                login().catchError(ExceptionHandler(context: context, retry: true, pop: true, retryMethod: login).handException);
              },
            ),
          ),

        ],
      ),
    );
  }



  Future login() async {
    showDialog(context: context, builder: (_){
      return LoadingDialog(text:'登录中...');
    });
    if(Data.cookie.isEmpty){
      await CommonService().initCookie();
    }
    HttpResult httpResult = await CommonService().getCaptchaCode();
    httpResult = await LoginService().login(_usernameController.text,_passwordController.text, httpResult.data);
    if(httpResult.success){
      //登陆成功
      Navigator.pop(context);
      Navigator.of(context).pop(true);
      Fluttertoast.showToast(
        msg: '登陆成功',
      );
    }else{
      Fluttertoast.showToast( msg: httpResult.errMsg,);
      Navigator.pop(context);
    }
  }
}