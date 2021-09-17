import 'package:flutter/material.dart';
import 'view/layout_view/layout_view.dart';
import 'view/splash_view.dart';
import 'view/web_screen_view.dart';

class Routs {
  static Map<String, WidgetBuilder> routs = {
    SplashView.id: (_) => SplashView(),
    LayoutView.id: (_) => LayoutView(),
    WebScreenView.id: (_) => WebScreenView(),
  };
}
