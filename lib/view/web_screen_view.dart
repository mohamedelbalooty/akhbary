import 'package:akhbary_app/provider/web_view_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'app_components.dart';

class WebScreenView extends StatelessWidget {
  static const String id = 'WebScreenView';

  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    var url = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: IndexedStack(
        index: context.select<WebViewProvider, int>(
            (value) => value.stackWidgetsPosition),
        children: <Widget>[
          Consumer<WebViewProvider>(
            builder: (context, provider, child) {
              return WebView(
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
                key: _key,
                onPageFinished: (finished) {
                  provider.downLoadingWebView();
                },
                onPageStarted: (started) {
                  provider.startWebView();
                },
              );
            },
          ),
          BuildLoadingWidget(),
        ],
      ),
    );
  }
}
