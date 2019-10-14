
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scqckypw/data/data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

  _State(this.initialUrl);

  String _title = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: WebView(
        onWebViewCreated: (ctrl){
          ctrl.loadUrl(initialUrl, headers:{
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