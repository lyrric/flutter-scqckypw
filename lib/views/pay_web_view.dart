
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

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
      return WebviewScaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: Text('付款'),
        ),
        url: initialUrl,
        initialChild: new CircularProgressIndicator()
      );
  }

}