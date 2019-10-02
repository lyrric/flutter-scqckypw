
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('登陆'),
      ),
      body: _FormView()
    );
  }
}


class _FormView extends StatefulWidget{

  @override
  State createState() {
    return new _FormSate();
  }
}
///表单
class _FormSate extends State<_FormView>{

  final _formKey = GlobalKey<_FormSate>();

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: '请输入用户名',
              labelText: '用户名',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.vpn_key),
              hintText: '请输入密码',
              labelText: '密码',
            ),
          ),
          new Row(
            children: <Widget>[
              new Container(
                width: 250,
                child:  TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: '请输入验证码',
                    labelText: '验证码',
                  ),
                ),
              ),
              Image.network("https://www.scqckypw.com/rCode.jpg?d=0.10689338593382991",width: 150),
            ],
          ),
          new Container(
            padding: EdgeInsets.only(top: 5),
            alignment: Alignment.center,
            child:  new MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              height: 40,
              minWidth: 300,
              child: Text('登陆'),
              onPressed: (){

              },
            ),
          ),

        ],
      ),
    );
  }
}