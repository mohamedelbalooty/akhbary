import 'package:akhbary_app/states/article_states.dart';
import 'package:akhbary_app/view_model/article_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_components.dart';
import '../home_view_components.dart';

class TopHeadlinesTabView extends StatelessWidget {
  const TopHeadlinesTabView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleViewModel>(
      builder: (context, provider, child) {
        if (provider.topHeadlinesStates == TopHeadlinesStates.InitialState) {
          provider.getTopHeadlineArticles(country: provider.language!);
          return const BuildLoadingWidget();
        } else if (provider.topHeadlinesStates ==
            TopHeadlinesStates.LoadingState) {
          return const BuildLoadingWidget();
        } else if (provider.topHeadlinesStates ==
            TopHeadlinesStates.LoadedState) {
          return BuildPlatformRefreshIndicator(
            refreshKey: GlobalKey<RefreshIndicatorState>(),
            onRefresh: () {
              return provider.getTopHeadlineArticles(
                  country: provider.language!);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalDistance(),
                  BuildHomeViewCarouselSlider(
                      articles: provider.topHeadlinesArticles!),
                  const SizedBox(height: 15.0),
                  const BuildAnimatedSmoothIndicator(),
                  const BuildTopHeadlinesTitle(),
                  buildTopHeadlineTitleDivider(),
                  BuildListOfItem(
                    articles: provider.topHeadlinesArticles!,
                    articlesNumber: 5,
                  ),
                ],
              ),
            ),
          );
        } else {
          return BuildErrorWidget(
            refresh: () {
              return provider.getTopHeadlineArticles(
                  country: provider.language!);
            },
            image: provider.topHeadlineErrorResult?.errorImage,
            errorMessage: provider.topHeadlineErrorResult?.errorMessage,
          );
        }
      },
    );
  }
}
