import 'package:flutter/material.dart';

class TapBarProvider extends ChangeNotifier {
  int tabBarIndex = 0;

  void changeTabBarIndex(int currentIndex) {
    tabBarIndex = currentIndex;
    notifyListeners();
  }
}
