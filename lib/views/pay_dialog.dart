
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/data/data.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

///付款pay webview
class PayWebDialog extends StatefulWidget{

  final String initialUrl;


  PayWebDialog(this.initialUrl);

  @override
  State createState() {
    return _State(initialUrl);
  }
}


class _State extends State{

  final String initialUrl;

  String _title = '付款';

  final flutterWebviewPlugin = FlutterWebviewPlugin();

  var webview;

  _State(this.initialUrl){
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged data) {
      String url = data.url;
      if(url.startsWith('alipay') || url.startsWith('tbopen')){
        _lunch(url);
      }
      if(url.indexOf('fontNotify.html') != -1){
          Navigator.of(context).pop(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    webview =  WebviewScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_title),
      ),
      url: initialUrl,
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
          width: 120.0,
          height: 120.0,
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
                    '付款中，请勿返回...',
                    style: TextStyle(fontSize: 12.0),
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

  Future _lunch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }

}