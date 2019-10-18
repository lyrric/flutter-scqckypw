
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/data/sys_constant.dart';
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
  var commonService = CommonService();
  var loginService = LoginService();
  //验证码数据
  Uint8List captureBytes;

  TextEditingController _usernameController = TextEditingController(text: '1');
  TextEditingController _passwordController = TextEditingController(text: '1');
  TextEditingController _captureCodeController = TextEditingController();

  _FormSate(){
    initCapture();
  }

  void initCapture(){
    commonService.getCapture().then((data){
      setState(() {
        captureBytes = data;
      });
    });
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
          Row(
            children: <Widget>[
              Container(
                width: 250,
                child:  TextFormField(
                  controller: _captureCodeController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: '请输入验证码',
                    labelText: '验证码',
                  ),
                ),
              ),
              Container(
                width: 150,
                child: captureBytes==null?Center(child: CircularProgressIndicator(), ):
                FlatButton(
                  child: Image.memory(captureBytes,width: 150,height:50, fit: BoxFit.fill,),
                  onPressed: (){
                  initCapture();
                },)
              )
            ],
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
                loginService.login(_usernameController.text, _passwordController.text, _captureCodeController.text)
                    .then((httpResult){
                      Navigator.pop(context);
                      if(httpResult.success){
                        //登陆成功
                        Navigator.of(context).pop(true);
                        Fluttertoast.showToast(
                            msg: '登陆成功',
                        );
                      }else{
                        initCapture();
                        _captureCodeController.clear();
                        Fluttertoast.showToast( msg: httpResult.errMsg,);
                      }
                });
              },
            ),
          ),

        ],
      ),
    );
  }
}