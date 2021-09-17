import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  int bottomNavBarIndex = 0;

  void changeBottomNavBarIndex(int currentIndex) {
    bottomNavBarIndex = currentIndex;
    notifyListeners();
  }

  int tabBarIndex = 0;

  void changeTabBarIndex(int currentIndex) {
    bottomNavBarIndex = currentIndex;
    notifyListeners();
  }

  int carouselSliderIndex = 0;

  void changeCarouselSliderIndex(int currentIndex) {
    carouselSliderIndex = currentIndex;
    notifyListeners();
  }
}
