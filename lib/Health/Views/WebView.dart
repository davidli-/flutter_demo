import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HealthWebView extends StatelessWidget {
  final String _title;
  final String _url;
  
  HealthWebView(this._title ,this._url);

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(_title)
      ),
      body: WebView(
        initialUrl: _url,
        gestureNavigationEnabled: true,
        javascriptMode: JavascriptMode.unrestricted,
        
        onWebViewCreated: (WebViewController webViewController){
        },
        
        onPageStarted: (String url) {
        },
        
        onPageFinished: (String url) {
        },
      ),
    );
  }
}