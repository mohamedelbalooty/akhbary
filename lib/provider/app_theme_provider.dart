import 'package:akhbary_app/services/local_services/cache_helper.dart';
import 'package:akhbary_app/utils/app_constants.dart';
import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  bool cacheTheme = CacheHelper.getBooleanData(key: sharedPrefsThemeKey);

  AppThemeProvider() {
    changeAppTheme(currentTheme: cacheTheme);
  }

  bool isDark = true;

  void changeAppTheme({bool currentTheme}) {
    if (currentTheme != null) {
      isDark = currentTheme;
      notifyListeners();
    } else {
      isDark = !isDark;
      CacheHelper.setBooleanData(key: sharedPrefsThemeKey, value: isDark);
      notifyListeners();
    }
  }
}
