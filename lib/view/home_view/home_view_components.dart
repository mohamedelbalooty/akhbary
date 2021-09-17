import 'dart:io';

import 'package:akhbary_app/model/article.dart';
import 'package:akhbary_app/provider/app_provider.dart';
import 'package:akhbary_app/provider/app_theme_provider.dart';
import 'package:akhbary_app/utils/app_constants.dart';
import 'package:akhbary_app/utils/colors.dart';
import 'package:akhbary_app/view_model/article_view_model.dart';
import 'package:akhbary_app/view_model/database_view_model.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:toast/toast.dart';
import '../app_components.dart';
import '../web_screen_view.dart';

AppBar buildHomeViewAppBar(BuildContext context, bool isPortrait) {
  return AppBar(
    centerTitle: false,
    title: Container(
      height: 25.0,
      width: 80,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        children: [
          Container(
            height: 25.0,
            width: translator.activeLanguageCode == 'ar' ? 50.0 : 55.0,
            padding: translator.activeLanguageCode == 'ar'
                ? EdgeInsets.only(right: 10, top: 5.0)
                : EdgeInsets.only(top: 5.0),
            decoration: BoxDecoration(
              color: appMainColor,
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(4.0),
                bottomStart: Radius.circular(4.0),
              ),
            ),
            child: Center(
              child: Text(
                'homeAppTitlePart1'.tr(),
                style: TextStyle(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  fontSize: translator.activeLanguageCode == 'ar' ? 16.0 : 14.0,
                ),
              ),
            ),
          ),
          Container(
            height: 25.0,
            width: translator.activeLanguageCode == 'ar' ? 30.0 : 25.0,
            padding: translator.activeLanguageCode == 'ar'
                ? EdgeInsets.only(left: 10, top: 5.0)
                : EdgeInsets.only(top: 5.0),
            decoration: BoxDecoration(
              color: Theme.of(context).tabBarTheme.labelColor,
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(4.0),
                bottomEnd: Radius.circular(4.0),
              ),
            ),
            child: Center(
              child: Text(
                'homeAppTitlePart2'.tr(),
                style: TextStyle(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  fontSize: translator.activeLanguageCode == 'ar' ? 16.0 : 14.0,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    titleSpacing: 20.0,
    actions: [
      ThemeSwitcher(
        builder: (context) => Consumer<AppThemeProvider>(
          builder: (context, provider, child) {
            return IconButton(
              icon: Icon(
                provider.isDark ? Icons.wb_sunny_outlined : Icons.wb_sunny,
                color: appMainColor,
              ),
              onPressed: () {
                provider.changeAppTheme();
                ThemeSwitcher.of(context).changeTheme(
                  theme: provider.isDark ? darkTheme : lightTheme,
                  reverseAnimation: provider.isDark ? true : false,
                );
              },
            );
          },
        ),
      ),
      Consumer<ArticleViewModel>(
        builder: (context, provider, child) {
          return BuildPopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: appMainColor,
            ),
            sizeOfIcon: 26.0,
            popupMenuItems: [
              _buildPopupMenuItem(
                value: 'eg',
                title: 'مصر',
                widget: Container(
                  height: 20.0,
                  width: 30.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/eg_flag.png'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                ),
              ),
              _buildPopupMenuItem(
                value: 'us',
                title: 'United states',
                widget: Container(
                  height: 20.0,
                  width: 30.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/us_flag.png'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                ),
              ),
            ],
            onSelect: (selectedValue) {
              if (selectedValue == 'eg') {
                if (provider.language == 'eg') {
                  alarmMessage(context, message: 'بالفعل انت تشاهد اخبار مصر');
                } else {
                  provider.changeServiceLang(selectedLang: selectedValue);
                  translator.setNewLanguage(context,
                      newLanguage: 'ar', restart: true);
                }
              } else {
                if (provider.language == 'us') {
                  alarmMessage(context,
                      message:
                          'Already you are watching the news of the United States of America');
                } else {
                  provider.changeServiceLang(selectedLang: selectedValue);
                  translator.setNewLanguage(context,
                      newLanguage: 'en', restart: true);
                }
              }
            },
          );
        },
      ),
    ],
    bottom: TabBar(
      isScrollable: isPortrait ? true : false,
      indicatorColor: appMainColor,
      indicatorWeight: 3.0,
      indicatorPadding:
          EdgeInsetsDirectional.only(bottom: 10.0, start: 20.0, end: 20.0),
      tabs: [
        _buildTabItem(
          'top news'.tr(),
        ),
        _buildTabItem(
          'business'.tr(),
        ),
        _buildTabItem(
          'tech'.tr(),
        ),
        _buildTabItem(
          'sports'.tr(),
        ),
        _buildTabItem(
          'health'.tr(),
        ),
        _buildTabItem(
          'entertainment'.tr(),
        ),
      ],
    ),
  );
}

Tab _buildTabItem(String tabTitle) {
  return Tab(
    text: tabTitle,
  );
}

class BuildHomeViewCarouselSlider extends StatelessWidget {
  final List<Article> articles;

  BuildHomeViewCarouselSlider({@required this.articles});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 5,
      itemBuilder: (_, index, realIndex) {
        return InkWell(
          onTap: () {
            namedNavigateTo(
              context: context,
              routeName: WebScreenView.id,
              arguments: articles[index].url ?? nullUrl,
            );
          },
          child: Container(
            height: 160.0,
            width: double.infinity,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  child: BuildCachedNetworkImage(
                    height: 160.0,
                    width: double.infinity,
                    imageUrl: articles[index].imageUrl,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${ConvertToTimeAgo.convertToTimeAgo(
                              DateTime.parse(articles[index].publishedAt),
                            )}' ??
                            '${ConvertToTimeAgo.convertToTimeAgo(nullDate)}',
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        articles[index].title ?? 'title'.tr(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 18.0,
                          // fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        onPageChanged: (int currentIndex, reason) =>
            context.read<AppProvider>().changeCarouselSliderIndex(currentIndex),
        initialPage: context
            .select<AppProvider, int>((value) => value.carouselSliderIndex),
        height: 160.0,
        disableCenter: true,
        //to control in width
        viewportFraction: 0.89,
        aspectRatio: 1.0,
        autoPlay: true,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 2000),
        pauseAutoPlayOnTouch: true,
        autoPlayCurve: Curves.easeIn,
      ),
    );
  }
}

class BuildAnimatedSmoothIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSmoothIndicator(
        activeIndex: context
            .select<AppProvider, int>((value) => value.carouselSliderIndex),
        count: 5,
        effect: ExpandingDotsEffect(
          dotHeight: 7.0,
          dotWidth: 7.0,
          dotColor: Theme.of(context).appBarTheme.backgroundColor,
          activeDotColor: appMainColor,
          spacing: 8.0,
        ),
      ),
    );
  }
}

class BuildTopHeadlinesTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 15.0,
        start: 20.0,
      ),
      child: Text(
        'top headlines'.tr(),
        style: TextStyle(
          color: Theme.of(context).tabBarTheme.labelColor,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

Container buildTopHeadlineTitleDivider() {
  return Container(
    height: 3,
    width: translator.activeLanguageCode == 'ar' ? 130.0 : 145.0,
    color: appMainColor,
    margin: const EdgeInsetsDirectional.only(start: 20.0, bottom: 10.0),
  );
}

Widget buildTabViewBody(
    {@required refreshKey,
    @required Function refresh,
    @required List<Article> articles}) {
  return BuildPlatformRefreshIndicator(
    refreshKey: refreshKey,
    onRefresh: refresh,
    child: SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          verticalDistance(),
          BuildListOfItem(
            articlesNumber: 0,
            articles: articles,
          ),
        ],
      ),
    ),
  );
}

class BuildListOfItem extends StatelessWidget {
  final List<Article> articles;
  final int articlesNumber;

  BuildListOfItem({@required this.articles, @required this.articlesNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: articles.length - articlesNumber,
        itemBuilder: (_, index) {
          return BuildItemOfList(
            article: articles[index + articlesNumber],
          );
        },
      ),
    );
  }
}

class BuildItemOfList extends StatelessWidget {
  final Article article;

  BuildItemOfList({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      width: double.infinity,
      color: Colors.transparent,
      margin: const EdgeInsetsDirectional.only(bottom: 10.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 125.0,
            width: double.infinity,
            margin: const EdgeInsetsDirectional.only(start: 15.0),
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(8.0),
                bottomStart: Radius.circular(8.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 125.0,
                top: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title ?? 'null title'.tr(),
                    style: TextStyle(
                      color: Theme.of(context).tabBarTheme.labelColor,
                      fontSize: 18.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textBaseline: TextBaseline.ideographic,
                    children: [
                      Text(
                        '${ConvertToTimeAgo.convertToTimeAgo(
                              DateTime.parse(article.publishedAt),
                            )}' ??
                            '${ConvertToTimeAgo.convertToTimeAgo(nullDate)}',
                        style: TextStyle(
                          color: appGreyColor,
                          fontSize: 16.0,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Consumer<DatabaseViewModel>(
                        builder: (context, provider, child) {
                          return BuildPopupMenuButton(
                            icon: const Icon(
                              Icons.more_vert,
                              color: appGreyColor,
                            ),
                            sizeOfIcon: 22.0,
                            onSelect: (value) {
                              if (value == 'visit') {
                                namedNavigateTo(
                                  context: context,
                                  routeName: WebScreenView.id,
                                  arguments: article.url ?? nullUrl,
                                );
                              } else {
                                List<Article> savedArticles =
                                    provider.savedArticles;
                                bool exist = false;
                                for (var item in savedArticles) {
                                  if (article.title == item.title) {
                                    exist = true;
                                  }
                                }
                                if (exist) {
                                  alarmMessage(
                                    context,
                                    message: 'item saved error'.tr(),
                                  );
                                } else {
                                  if (savedArticles.length < 20) {
                                    provider.addNewArticle(
                                      Article(
                                          title: article.title,
                                          url: article.url,
                                          imageUrl: article.imageUrl,
                                          publishedAt: article.publishedAt),
                                    );
                                    alarmMessage(
                                      context,
                                      message: 'item saved'.tr(),
                                    );
                                  } else {
                                    alarmMessage(
                                      context,
                                      message: 'item saved maximum'.tr(),
                                    );
                                  }
                                }
                              }
                            },
                            popupMenuItems: [
                              _buildPopupMenuItem(
                                value: 'visit',
                                title: 'visit item'.tr(),
                                widget: Icon(
                                  Icons.link,
                                  color: appMainColor,
                                ),
                              ),
                              _buildPopupMenuItem(
                                value: 'save',
                                title: 'save item'.tr(),
                                widget: Icon(
                                  Icons.bookmark,
                                  color: appMainColor,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          PositionedDirectional(
            top: 0.0,
            start: 0.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: BuildCachedNetworkImage(
                height: 125.0,
                width: 125.0,
                imageUrl: article.imageUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildErrorWidget extends StatelessWidget {
  final refreshKey = GlobalKey<RefreshIndicatorState>();
  final String image, errorMessage;
  final Function refresh;

  BuildErrorWidget(
      {@required this.refresh,
      @required this.image,
      @required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return BuildPlatformRefreshIndicator(
      refreshKey: refreshKey,
      onRefresh: refresh,
      child: Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                image,
                height: 300.0,
                width: 300.0,
                fit: BoxFit.fill,
              ),
              Text(
                errorMessage ?? 'null error'.tr(),
                style: TextStyle(
                  color: Theme.of(context).tabBarTheme.labelColor,
                  fontSize: 22.0,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildPlatformRefreshIndicator extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> refreshKey;
  final Future Function() onRefresh;
  final Widget child;

  BuildPlatformRefreshIndicator(
      {@required this.refreshKey,
      @required this.onRefresh,
      @required this.child});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? buildAndroidWidget() : buildIosWidget();
  }

  Widget buildAndroidWidget() {
    return RefreshIndicator(
        key: refreshKey, child: child, onRefresh: onRefresh);
  }

  Widget buildIosWidget() {
    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(
          key: refreshKey,
          onRefresh: onRefresh,
        ),
        SliverToBoxAdapter(
          child: child,
        ),
      ],
    );
  }
}

class BuildPopupMenuButton extends StatelessWidget {
  final Icon icon;
  final double sizeOfIcon;
  final Function onSelect;
  final List<PopupMenuItem> popupMenuItems;

  BuildPopupMenuButton(
      {@required this.icon,
      @required this.sizeOfIcon,
      @required this.onSelect,
      @required this.popupMenuItems});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Theme.of(context).appBarTheme.backgroundColor,
      enableFeedback: true,
      icon: icon,
      iconSize: sizeOfIcon,
      onSelected: onSelect,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      itemBuilder: (_) {
        return popupMenuItems;
      },
    );
  }
}

PopupMenuItem<String> _buildPopupMenuItem(
    {@required String value, @required String title, Widget widget}) {
  return PopupMenuItem(
    value: value,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(color: appGreyColor, fontWeight: FontWeight.w500),
        ),
        widget,
      ],
    ),
  );
}

void alarmMessage(BuildContext context, {@required String message}) {
  Toast.show(message, context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
      backgroundRadius: 10.0);
}
