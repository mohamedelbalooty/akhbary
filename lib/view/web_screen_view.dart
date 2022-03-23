import 'package:akhbary_app/provider/web_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'app_components.dart';

class WebScreenView extends StatefulWidget {
  static const String id = 'WebScreenView';

  @override
  State<WebScreenView> createState() => _WebScreenViewState();
}

class _WebScreenViewState extends State<WebScreenView> {
  int stackWidgetsPosition = 1;
  final _key = UniqueKey();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5)).then((value) {
      setState(() {
        stackWidgetsPosition = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var url = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: IndexedStack(
        // index: context.select<WebViewProvider, int>(
        //     (value) => value.stackWidgetsPosition),
        index: stackWidgetsPosition,
        children: <Widget>[
          // Consumer<WebViewProvider>(
          //   builder: (context, provider, child) {
          //     return WebView(
          //       initialUrl: url.toString(),
          //       javascriptMode: JavascriptMode.unrestricted,
          //       key: _key,
          //       // onPageFinished: (finished) {
          //       //   provider.downLoadingWebView();
          //       // },
          //       // onPageStarted: (started) {
          //       //   provider.startWebView();
          //       // },
          //     );
          //   },
          // ),
          WebView(
            initialUrl: url.toString(),
            javascriptMode: JavascriptMode.unrestricted,
            key: _key,
          ),
          const BuildLoadingWidget(),
        ],
      ),
    );
  }
}
