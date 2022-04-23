import 'package:flutter/material.dart';
import '../view/setting_view/about_view/about_view.dart';
import '../view/setting_view/setting_view.dart';
import '../view/layout_view/layout_view.dart';
import '../view/splash_view.dart';

class Routs {
  static Map<String, WidgetBuilder> routs = {
    SplashView.id: (_) => const SplashView(),
    LayoutView.id: (_) => LayoutView(),
    SettingView.id: (_) => const SettingView(),
    AboutView.id: (_) => const AboutView(),
  };
}
