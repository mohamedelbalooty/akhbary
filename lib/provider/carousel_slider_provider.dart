import 'package:flutter/material.dart';

class CarouselSliderProvider extends ChangeNotifier{
  int carouselSliderIndex = 0;

  void changeCarouselSliderIndex(int currentIndex) {
    carouselSliderIndex = currentIndex;
    notifyListeners();
  }
}