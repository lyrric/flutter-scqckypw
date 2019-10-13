
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    /*return WebviewScaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text('付款'),
      ),
      url: initialUrl,
    );*/
    return Scaffold(
      appBar: AppBar(
        title: Text('付款'),
      ),
      body: WebView(
        javascriptMode:JavascriptMode.unrestricted,
        initialUrl: initialUrl,
        navigationDelegate: (NavigationRequest request){
          print(request.url);
          if(request.url.startsWith('tbopen')){
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