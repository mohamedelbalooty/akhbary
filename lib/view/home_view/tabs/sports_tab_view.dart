
import 'package:akhbary_app/states/article_states.dart';
import 'package:akhbary_app/view_model/article_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_components.dart';
import '../home_view_components.dart';

class SportsTabView extends StatelessWidget {
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleViewModel>(
      builder: (context, provider, child) {
        if (provider.sportsStates == SportsStates.InitialState) {
          provider.getSportsArticles(country: provider.language!);
          return const BuildLoadingWidget();
        } else if (provider.sportsStates == SportsStates.LoadingState) {
          return const BuildLoadingWidget();
        } else if (provider.sportsStates == SportsStates.LoadedState) {
          return buildTabViewBody(
            refreshKey: refreshKey,
            refresh: () {
              return provider.getSportsArticles(country: provider.language!);
            },
            articles: provider.sportsArticles!,
          );
        } else {
          return BuildErrorWidget(
            refresh: () {
              return provider.getSportsArticles(country: provider.language!);
            },
            image: provider.techErrorResult!.errorImage,
            errorMessage: provider.techErrorResult!.errorMessage,
          );
        }
      },
    );
  }
}
