import 'package:akhbary_app/provider/carousel_slider_provider.dart';
import 'package:akhbary_app/provider/tap_bar_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../provider/bottom_nav_bar_provider.dart';
import '../provider/app_theme_provider.dart';
import '../provider/web_view_provider.dart';
import '../view_model/article_view_model.dart';
import '../view_model/database_view_model.dart';

class MultiProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<BottomNavParProvider>(
      create: (context) => BottomNavParProvider(),
    ),
    ChangeNotifierProvider<ArticleViewModel>(
      create: (context) => ArticleViewModel(),
    ),
    ChangeNotifierProvider<DatabaseViewModel>(
      create: (context) => DatabaseViewModel(),
    ),
    ChangeNotifierProvider<WebViewProvider>(
      create: (context) => WebViewProvider(),
    ),
    ChangeNotifierProvider<AppThemeProvider>(
      create: (context) => AppThemeProvider(),
    ),
    ChangeNotifierProvider<TapBarProvider>(
      create: (context) => TapBarProvider(),
    ),
    ChangeNotifierProvider<CarouselSliderProvider>(
      create: (context) => CarouselSliderProvider(),
    ),
  ];
}
