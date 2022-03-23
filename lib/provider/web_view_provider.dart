import 'package:flutter/cupertino.dart';

class WebViewProvider extends ChangeNotifier{
  int stackWidgetsPosition = 1;

  void openWebView() async{
    await Future.delayed(Duration(seconds: 5)).then((value) {stackWidgetsPosition = 0;});
    stackWidgetsPosition = 0;
  }

  // downLoadingWebView() {
  //   stackWidgetsPosition = 0;
  //   notifyListeners();
  // }
  //
  // startWebView() {
  //   stackWidgetsPosition = 1;
  //   notifyListeners();
  // }
}