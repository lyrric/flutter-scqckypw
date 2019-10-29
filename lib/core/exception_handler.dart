
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/views/common_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ExceptionHandler{
  ///错误信息显示模式
  ShowErrorType showErrorType;
  ///显示错误前是否先pop（pop掉loading dialog）
  bool pop;
  ///是否重试
  bool retry;
  ///重试方法
  Function retryMethod;
  ///content
  BuildContext context;

  ExceptionHandler({this.showErrorType, this.pop, this.retry, this.retryMethod, this.context});

  ///just toast
  factory ExceptionHandler.toastHandler(){
    return ExceptionHandler()
      ..showErrorType = ShowErrorType.TOAST
      ..pop = false;
  }

  ///提示并pop
  factory ExceptionHandler.popAndToastHandler(BuildContext _context){
    return ExceptionHandler()
        ..showErrorType = ShowErrorType.TOAST
        ..pop = true
        ..context = _context;
  }
  ///带重试的提示
  factory ExceptionHandler.retryWithPopHandler(BuildContext _context, Function retryMethod){
    return ExceptionHandler()
      ..showErrorType = ShowErrorType.YES_NO_DIALOG
      ..pop = true
      ..retry = true
      ..retryMethod = retryMethod
      ..context = _context;
  }

   handException(dynamic error){
     if(pop){
        Navigator.pop(context);
     }
     String errMsg;
     if(error is BusinessError){
       errMsg = error.errMsg;
     }else{
       print(error);
       errMsg = '请求失败';
     }
     if(showErrorType == ShowErrorType.TOAST){
       Fluttertoast.showToast(backgroundColor: Colors.black, textColor: Colors.white, msg: errMsg);
     }else if(showErrorType == ShowErrorType.MESSAGE_DIALOG){
       showDialog(context: context, builder: (_){
         return new MessageDialog(errMsg);
       });
     }else {
       showDialog(context: context, builder: (_){
         return new RetryDialog(errMsg);
       }).then((_retry){
         if(_retry != null && _retry){
           retryMethod();
         }
       });
     }
   }

}

enum ShowErrorType {

  TOAST,

  MESSAGE_DIALOG,

  YES_NO_DIALOG,

}

///业务异常
class BusinessError implements Exception{

  String errMsg;

  BusinessError(this.errMsg);

  @override
  String toString() {
    return 'BusinessException{errMsg: $errMsg}';
  }
}

///网络异常
class NetworkError implements Exception{

}