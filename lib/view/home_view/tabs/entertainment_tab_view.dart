import 'package:akhbary_app/states/article_states.dart';
import 'package:akhbary_app/view_model/article_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_components.dart';
import '../home_view_components.dart';

class EntertainmentTabView extends StatelessWidget {
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleViewModel>(
      builder: (context, provider, child) {
        if (provider.entertainmentStates == EntertainmentStates.InitialState) {
          provider.getEntertainmentArticles(country: provider.language!);
          return const BuildLoadingWidget();
        } else if (provider.entertainmentStates ==
            EntertainmentStates.LoadingState) {
          return const BuildLoadingWidget();
        } else if (provider.entertainmentStates ==
            EntertainmentStates.LoadedState) {
          return buildTabViewBody(
            refreshKey: refreshKey,
            refresh: () {
              return provider.getEntertainmentArticles(
                  country: provider.language!);
            },
            articles: provider.entertainmentArticles!,
          );
        } else {
          return BuildErrorWidget(
            refresh: () {
              return provider.getEntertainmentArticles(
                  country: provider.language!);
            },
            image: provider.entertainmentErrorResult!.errorImage,
            errorMessage: provider.entertainmentErrorResult!.errorMessage,
          );
        }
      },
    );
  }
}
