import 'package:akhbary_app/states/article_states.dart';
import 'package:akhbary_app/utils/colors.dart';
import 'package:akhbary_app/view/home_view/home_view_components.dart';
import 'package:akhbary_app/view_model/article_view_model.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import '../app_components.dart';
import 'search_view_components.dart';

class SearchView extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(title: 'searching for articles'.tr()),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          verticalDistance(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: BuildTextFormField(
              controller: _controller,
              changed: (String value) {
                Provider.of<ArticleViewModel>(context, listen: false)
                    .getArticlesFromSearching(searchValue: value);
              },
            ),
          ),
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              color: appGreyColor,
              thickness: 2.0,
            ),
          ),
          Consumer<ArticleViewModel>(
            builder: (context, provider, child) {
              if (provider.searchingStates == SearchingStates.InitialState) {
                return BuildSearchInitialWidget();
              } else if (provider.searchingStates ==
                  SearchingStates.LoadingState) {
                return Expanded(
                  child: BuildLoadingWidget(),
                );
              } else if (provider.searchingStates ==
                  SearchingStates.LoadedState) {
                return Expanded(
                  child: ListView(
                    children: [
                      BuildListOfItem(
                        articlesNumber: 0,
                        articles: provider.searchArticles,
                      ),
                    ],
                  ),
                );
              } else if (provider.searchingStates ==
                  SearchingStates.EmptyState) {
                return BuildSearchEmptyWidget();
              } else {
                return BuildSearchErrorWidget(
                  errorMessage: provider.searchErrorResult.errorMessage,
                  image: provider.searchErrorResult.errorImage,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
