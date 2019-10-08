import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserCenterEditView extends StatelessWidget{

  String _realName;
  String _sex;
  String _idType;
  String _idNo;

  UserCenterEditView(this._realName, this._sex, this._idType, this._idNo);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: new Text('编辑'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.done),
              onPressed: (){

              },)
          ],
        ),
        body: _Body(_realName, _sex, _idType, _idNo)
    );
  }
}


class _Body extends StatefulWidget{

  String _realName;
  String _sex;
  String _idType;
  String _idNo;


  _Body(this._realName, this._sex, this._idType, this._idNo);

  @override
  State createState() {
    return new _BodyState(_realName, _sex, _idType, _idNo);
  }
}

class _BodyState extends State<_Body>{

  String _realName;
  String _sex;
  String _idType;
  String _idNo;


  _BodyState(this._realName, this._sex, this._idType, this._idNo);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        TextFormField(
          controller: null,
          decoration: const InputDecoration(
            //icon: Icon(Icons.person),
            hintText: '请输入真实姓名',
            labelText: '真实姓名',
          ),
        ),
        new Row(
          children: <Widget>[
            new Text('性别：'),
            RadioListTile<String>(
              value: '男',
              title: Text('男'),
              groupValue: _sex,
              onChanged: (value){
                setState(() {
                  _sex = value;
                });
              },
            ),
            RadioListTile<String>(
              value: '女',
              title: Text('女'),
              groupValue: _sex,
              onChanged: (value){
                setState(() {
                  _sex = value;
                });
              },
            ),
            RadioListTile<String>(
              value: '保密',
              title: Text('保密'),
              groupValue: _sex,
              onChanged: (value){
                setState(() {
                  _sex = value;
                });
              },
            ),
          ],
        ),
        new Row(
          children: <Widget>[
            Text('证件类型：'),
            DropdownButtonHideUnderline(
              child: new DropdownButton(
                  items: [
                    new DropdownMenuItem(
                      child: new Text('身份证'),
                      value: '身份证',
                    ),
                    new DropdownMenuItem(
                      child: new Text('军人证'),
                      value: '军人证',
                    ),
                    new DropdownMenuItem(
                      child: new Text('护照'),
                      value: '护照',
                    ),
                  ],
                  onChanged: (value){

                  }
              ),
            ),
          ],
        ),
        TextFormField(
          controller: null,
          decoration: const InputDecoration(
            hintText: '请输入证件号',
            labelText: '证件号',
          ),
        ),
      ],
    );
  }
}

