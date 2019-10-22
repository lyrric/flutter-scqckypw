
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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


  String captchaCode;

  TextEditingController _usernameController = TextEditingController(text: '0');
  TextEditingController _passwordController = TextEditingController(text: '0');

  _FormSate(){
    initCaptureCode();
  }

  Future<HttpResult> initCaptureCode() async{
    var httpResult = await  CommonService().getCaptchaCode();
    if(httpResult.success){
      captchaCode = httpResult.data;
    }
    return httpResult;
  }

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
                showDialog(context: context, builder: (_){
                  return LoadingDialog(text:'登录中...');
                });
                //判断验证码是否获取
                if(captchaCode == null){
                  initCaptureCode().then((httpResult){
                    if(httpResult.success){
                      login();
                    }else{
                      Fluttertoast.showToast(msg: '登陆失败，请重试');
                    }
                  });
                }else{
                  login();
                }
              },
            ),
          ),

        ],
      ),
    );
  }

  void login(){
    LoginService().login(_usernameController.text,
        _passwordController.text, captchaCode)
        .then((httpResult){
      Navigator.pop(context);
      if(httpResult.success){
        //登陆成功
        Navigator.of(context).pop(true);
        Fluttertoast.showToast(
          msg: '登陆成功',
        );
      }else{
        Fluttertoast.showToast( msg: httpResult.errMsg,);
      }
    });
  }
}