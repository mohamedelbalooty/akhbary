import 'package:akhbary_app/model/article.dart';
import 'package:akhbary_app/utils/app_constants.dart';
import 'package:akhbary_app/utils/colors.dart';
import 'package:akhbary_app/view_model/database_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:toast/toast.dart';
import '../app_components.dart';
import '../web_screen_view.dart';

class BuildListOfSavedItem extends StatelessWidget {
  final List<Article> articles;

  BuildListOfSavedItem({@required this.articles});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: articles.length,
      separatorBuilder: (_, index) => Divider(
        color: appMainColor,
      ),
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(start: 20.0, end: 20.0, top: 15.0),
          child: BuildItemOfSavedList(
            article: articles[index],
            onDismiss: (DismissDirection direction) {
              context
                  .read<DatabaseViewModel>()
                  .deleteSelectedArticle(articles[index]);
              Toast.show('item deleted'.tr(), context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            },
          ),
        );
      },
    );
  }
}

class BuildItemOfSavedList extends StatelessWidget {
  final Article article;
  final Function onDismiss;

  BuildItemOfSavedList({@required this.article, @required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        namedNavigateTo(
            context: context,
            routeName: WebScreenView.id,
            arguments: article.url ?? nullUrl);
      },
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: onDismiss,
        background: buildDirectionDismissibleBackground(
          context,
          alignment: translator.activeLanguageCode == 'ar'
              ? Alignment.centerRight
              : Alignment.centerLeft,
          startPadding: 25.0,
          endPadding: 0.0,
        ),
        secondaryBackground: buildDirectionDismissibleBackground(
          context,
          alignment: translator.activeLanguageCode == 'ar'
              ? Alignment.centerLeft
              : Alignment.centerRight,
          startPadding: 0.0,
          endPadding: 25.0,
        ),
        child: Container(
          height: 125.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          margin: const EdgeInsetsDirectional.only(bottom: 5.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 25.0,
                          width: 90.0,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                appMainColor,
                                Color(0xFFFFB400),
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${ConvertToTimeAgo.convertToTimeAgo(
                                    DateTime.parse(article.publishedAt),
                                  )}' ??
                                  '${ConvertToTimeAgo.convertToTimeAgo(nullDate)}',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          article.title ?? 'null title'.tr(),
                          style: TextStyle(
                            color: Theme.of(context).tabBarTheme.labelColor,
                            fontSize: 18.0,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  child: BuildCachedNetworkImage(
                    height: 125.0,
                    width: 125.0,
                    imageUrl: article.imageUrl,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildDirectionDismissibleBackground(BuildContext context,
      {@required AlignmentGeometry alignment,
      @required double startPadding,
      @required double endPadding}) {
    return Container(
      alignment: alignment,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Padding(
        padding:
            EdgeInsetsDirectional.only(start: startPadding, end: endPadding),
        child: CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.redAccent,
          child: Icon(
            Icons.delete,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}

class BuildNoSavedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalDistance(),
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              child: Image.asset(
                'assets/images/no items.png',
                height: 300.0,
                width: 250.0,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Container(
              height: 50.0,
              width: 250.0,
              decoration: const BoxDecoration(
                color: appMainColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: Center(
                child: Text(
                  'no item saved'.tr(),
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
