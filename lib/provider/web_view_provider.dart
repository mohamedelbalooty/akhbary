import 'package:flutter/cupertino.dart';

class WebViewProvider extends ChangeNotifier{
  int stackWidgetsPosition = 1;

  downLoadingWebView() {
    stackWidgetsPosition = 0;
    notifyListeners();
  }

  startWebView() {
    stackWidgetsPosition = 1;
    notifyListeners();
  }
}