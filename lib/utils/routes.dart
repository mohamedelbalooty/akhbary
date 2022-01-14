import 'package:akhbary_app/view/setting_view/static_views/about_view.dart';
import 'package:flutter/material.dart';
import '../view/setting_view/setting_view.dart';
import '../view/layout_view/layout_view.dart';
import '../view/splash_view.dart';
import '../view/web_screen_view.dart';

class Routs {
  static Map<String, WidgetBuilder> routs = {
    SplashView.id: (_) => SplashView(),
    LayoutView.id: (_) => LayoutView(),
    SettingView.id: (_) => SettingView(),
    WebScreenView.id: (_) => WebScreenView(),
    AboutView.id: (_) => AboutView(),
  };
}
