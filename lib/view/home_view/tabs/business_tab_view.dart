import 'package:akhbary_app/states/article_states.dart';
import 'package:akhbary_app/view_model/article_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_components.dart';
import '../home_view_components.dart';

class BusinessTabView extends StatelessWidget {
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleViewModel>(
      builder: (context, provider, child) {
        if (provider.businessStates == BusinessStates.InitialState) {
          provider.getBusinessArticles(country: provider.language!);
          return const BuildLoadingWidget();
        } else if (provider.businessStates == BusinessStates.LoadingState) {
          return const BuildLoadingWidget();
        } else if (provider.businessStates == BusinessStates.LoadedState) {
          return buildTabViewBody(
              refreshKey: refreshKey,
              refresh: () {
                return provider.getBusinessArticles(country: provider.language!);
              },
              articles: provider.businessArticles!);
        } else {
          return BuildErrorWidget(
            refresh: () {
              return provider.getBusinessArticles(country: provider.language!);
            },
            image: provider.businessErrorResult!.errorImage,
            errorMessage: provider.businessErrorResult!.errorMessage,
          );
        }
      },
    );
  }
}
