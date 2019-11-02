
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/data/data.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

///付款pay webview
class PayWebDialog extends StatefulWidget{

  ///支付
  final String url;

  ///支付类型，1=浏览器支付，2=直接lunch
  final int payType;

  ///支付宝or微信
  final String payPlatform;


  PayWebDialog(this.url, this.payType, this.payPlatform);

  @override
  State createState() {
    return _State(url, payType, payPlatform);
  }
}


class _State extends State{

  ///支付
  final String url;

  ///支付类型，1=浏览器支付，2=直接launch
  final int payType;

  ///alipay
  final String payPlatform;


  String _title = '付款';

  final flutterWebviewPlugin = FlutterWebviewPlugin();

  var webview;


  _State(this.url, this.payType, this.payPlatform){
    if(payType == 1){
      flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged data) {
        String url = data.url;
        print(url);
        if(url.startsWith('alipay')){
          launch(url);
        }
        if(url.indexOf('fontNotify.html') != -1){
          Navigator.of(context).pop(true);
        }
      });
    }else{
        launch('alipayqr://platformapi/startapp?saId=10000007&qrcode='+Uri.encodeFull(url));
    }
  }


  @override
  Widget build(BuildContext context) {
    webview =  payType==2?Container():WebviewScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_title),
      ),
      url: url,
      headers: {
        'cookieStr':Data.cookie,
        'Accept-Language':'zh-CN,zh;q=0.9,en;q=0.8,ja;q=0.7,zh-TW;q=0.6,la;q=0.5',
        'Connection':'keep-alive',
        'Upgrade-Insecure-Requests':'1'
      },
      hidden: true,
      enableAppScheme:true,
      withZoom: true,
      withLocalStorage: true,
      initialChild: Container(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    return Material( //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center( //保证控件居中效果
        child: SizedBox(
          width: 250.0,
          height: 200.0,
          child: Container(
            decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Text(
                    '支付中...，支付成功后请点击确定按钮',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child:  MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    height: 40,
                    minWidth: 200,
                    child: Text('确定'),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  height: 0,
                  child: webview,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}