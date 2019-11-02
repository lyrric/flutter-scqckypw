import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/core/exception_handler.dart';
import 'package:flutter_scqckypw/util/data_util.dart';
import 'package:flutter_scqckypw/service/user_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../common_view.dart';

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
        ),
        body: Container(
          margin: EdgeInsets.only(left: 5, right: 5,top: 5),
          child: _Body(_realName, _sex, _idType, _idNo),
        ),

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

  var _realNameCtrl;
  var _idNoCtrl;

  UserService _userService = new UserService();

  _BodyState(this._realName, this._sex, this._idType, this._idNo){

    switch(_sex){
      case '男':
        _sex = 'M';break;
      case '女':
        _sex = 'F';break;
      case '保密':
        _sex = 'S';break;
    }
    _idType = convertIdTypeByText(_idType);
    _realNameCtrl = TextEditingController(text: _realName);
    _idNoCtrl  = TextEditingController(text: _idNo);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        TextFormField(
          controller: _realNameCtrl,
          decoration: const InputDecoration(
            //icon: Icon(Icons.person),
            hintText: '请输入真实姓名',
            labelText: '真实姓名',
          ),
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Text('性别：'),
            Container(
              width: 100,
              child: RadioListTile<String>(
                value: 'M',
                title: Text('男'),
                groupValue: _sex,
                onChanged: (value){
                  setState(() {
                    _sex = value;
                  });
                },
              ),
            ),
            Container(
              width: 100,
              child:  RadioListTile<String>(
                value: 'F',
                title: Text('女'),
                groupValue: _sex,
                onChanged: (value){
                  setState(() {
                    _sex = value;
                  });
                },
              ),
            ),
            Container(
              width: 150,
              child:  RadioListTile<String>(
                value: 'S',
                title: Text('保密'),
                groupValue: _sex,
                onChanged: (value){
                  setState(() {
                    _sex = value;
                  });
                },
              ),
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
                      value: 'id_card',
                    ),
                    new DropdownMenuItem(
                      child: new Text('军人证'),
                      value: 'military_card',
                    ),
                    new DropdownMenuItem(
                      child: new Text('护照'),
                      value: 'passport',
                    ),
                  ],
                  onChanged: (value){
                    setState(() {
                      _idType = value;
                    });
                  },
                hint: new Text('请选择'),
                value: _idType,
              ),
            ),
          ],
        ),
        TextFormField(
          controller: _idNoCtrl,
          decoration: const InputDecoration(
            hintText: '请输入证件号',
            labelText: '证件号',
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 5),
          alignment: Alignment.center,
          child: MaterialButton(
            height: 40,
            minWidth: 300,
            color: Colors.blue,
            textColor: Colors.white,
            child: Text('保存'),
            onPressed: (){
                showDialog(context: context, builder: (_){
                  return new LoadingDialog(text:'保存中...');
                });
                _userService.updateInfo(_realName, _sex, _idType, _idNo)
                    .then((_){
                          Fluttertoast.showToast(backgroundColor: Colors.black, textColor: Colors.white, msg: '保存成功');
                          Navigator.of(context).pop(true); })
                    .catchError(ExceptionHandler.toastHandler().handException)
                    .whenComplete((){
                  Navigator.of(context).pop(true); });
            },
          ),
        ),

      ],
    );
  }
}

