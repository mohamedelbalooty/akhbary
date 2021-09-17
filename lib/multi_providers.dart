import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'provider/app_provider.dart';
import 'provider/app_theme_provider.dart';
import 'provider/web_view_provider.dart';
import 'view_model/article_view_model.dart';
import 'view_model/database_view_model.dart';

class MultiProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
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
  ];
}
