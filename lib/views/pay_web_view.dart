
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/data/data.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

///付款pay webview
class PayWebView extends StatefulWidget{

  final String initialUrl;


  PayWebView(this.initialUrl);

  @override
  State createState() {
    return _State(initialUrl);
  }
}


class _State extends State{

  final String initialUrl;

  String _title = '付款';

  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  _State(this.initialUrl){
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged data) {
      String url = data.url;
      if(url.startsWith('alipay') || url.startsWith('tbopen')){
        _lunch(url);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(Data.cookie);
    return WebviewScaffold(
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
      enableAppScheme:true,
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  /*  return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: WebView(
        onWebViewCreated: (ctrl){
          ctrl.loadUrl('http://baidu.com', headers:{
            'Cookie':Data.cookie
          });

        },
        javascriptMode:JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request){
          if(request.url.startsWith('alipay')){
            _lunch(request.url);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );*/
  }

  Future _lunch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }

}