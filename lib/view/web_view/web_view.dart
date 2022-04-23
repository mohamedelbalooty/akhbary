import 'package:akhbary_app/model/article.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../app_components.dart';
import 'components.dart';

class WebScreenView extends StatefulWidget {
  final Article article;

  const WebScreenView({Key? key, required this.article}) : super(key: key);

  @override
  State<WebScreenView> createState() => _WebScreenViewState();
}

class _WebScreenViewState extends State<WebScreenView> {
  int stackWidgetsPosition = 1;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((value) {
      setState(() {
        stackWidgetsPosition = 0;
      });
    });
  }

  bool isError = false;
  bool isLoading = false;

  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: buildWebViewAppBar(context, isPortrait,
          author: widget.article.author,
          source: widget.article.source,
          url: widget.article.url),
      body: IndexedStack(
        index: stackWidgetsPosition,
        children: <Widget>[
          WebView(
            initialUrl: widget.article.url.toString(),
            javascriptMode: JavascriptMode.unrestricted,
          ),
          const BuildLoadingWidget(),
        ],
      ),
      bottomNavigationBar: isPortrait
          ? BuildWebViewBottomBar(
              author: widget.article.author,
              source: widget.article.source,
              url: widget.article.url)
          : const SizedBox(),
    );
  }
}
