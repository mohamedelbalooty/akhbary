import 'package:akhbary_app/states/article_states.dart';
import 'package:akhbary_app/view_model/article_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_components.dart';
import '../home_view_components.dart';

class HealthTabView extends StatelessWidget {
  const HealthTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleViewModel>(
      builder: (context, provider, child) {
        if (provider.healthStates == HealthStates.InitialState) {
          provider.getHealthArticles(country: provider.language!);
          return const BuildLoadingWidget();
        } else if (provider.healthStates == HealthStates.LoadingState) {
          return const BuildLoadingWidget();
        } else if (provider.healthStates == HealthStates.LoadedState) {
          return buildTabViewBody(
            refreshKey: GlobalKey<RefreshIndicatorState>(),
            refresh: () {
              return provider.getHealthArticles(country: provider.language!);
            },
            articles: provider.healthArticles!,
          );
        } else {
          return BuildErrorWidget(
            refresh: () {
              return provider.getHealthArticles(country: provider.language!);
            },
            image: provider.healthErrorResult?.errorImage,
            errorMessage: provider.healthErrorResult?.errorMessage,
          );
        }
      },
    );
  }
}
