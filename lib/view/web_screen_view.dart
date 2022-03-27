import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'app_components.dart';

class WebScreenView extends StatefulWidget {
  static const String id = 'WebScreenView';

  const WebScreenView({Key? key}) : super(key: key);

  @override
  State<WebScreenView> createState() => _WebScreenViewState();
}

class _WebScreenViewState extends State<WebScreenView> {
  int stackWidgetsPosition = 1;
  final _key = UniqueKey();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((value) {
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
        index: stackWidgetsPosition,
        children: <Widget>[
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
