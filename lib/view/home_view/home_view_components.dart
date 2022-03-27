import 'dart:io';
import 'package:akhbary_app/model/article.dart';
import 'package:akhbary_app/provider/carousel_slider_provider.dart';
import 'package:akhbary_app/provider/tap_bar_provider.dart';
import 'package:akhbary_app/states/database_sates.dart';
import 'package:akhbary_app/utils/colors.dart';
import 'package:akhbary_app/view_model/database_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:share/share.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../app_components.dart';
import '../web_screen_view.dart';

AppBar buildHomeViewAppBar(BuildContext context, bool isPortrait) {
  return AppBar(
    centerTitle: false,
    title: Text(
      'welcome'.tr(),
      style: TextStyle(
          color: Theme.of(context).tabBarTheme.labelColor,
          fontSize: 28.0,
          fontWeight: FontWeight.w500,
          height: 2),
    ),
    titleSpacing: 20.0,
    actions: [
      Padding(
        padding: const EdgeInsetsDirectional.only(end: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 30.0,
              width: 30.0,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 5.0),
            GradientText(
              'app name'.tr(),
              gradient: LinearGradient(
                colors: [
                  Colors.orange.shade200,
                  appMainColor,
                ],
              ),
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ],
    bottom: TabBar(
      onTap: (int index){
        context.read<TapBarProvider>().changeTabBarIndex(index);
      },
      isScrollable: isPortrait ? true : false,
      indicatorColor: appMainColor,
      indicatorWeight: 3.0,
      indicatorPadding:
          const EdgeInsetsDirectional.only(bottom: 10.0, start: 20.0, end: 20.0),
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

  const BuildHomeViewCarouselSlider({Key? key, required this.articles}) : super(key: key);

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
              arguments: articles[index].url,
            );
          },
          child: SizedBox(
            height: 160.0,
            width: double.infinity,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  child: BuildNetworkImage(
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
                        ConvertToTimeAgo.convertToTimeAgo(
                              DateTime.parse(articles[index].publishedAt),
                            ),
                        style: const TextStyle(
                          color: whiteColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        articles[index].title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: const TextStyle(
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
            context.read<CarouselSliderProvider>().changeCarouselSliderIndex(currentIndex),
        initialPage: context
            .select<CarouselSliderProvider, int>((value) => value.carouselSliderIndex),
        height: 160.0,
        disableCenter: true,
        //to control in width
        viewportFraction: 0.89,
        aspectRatio: 1.0,
        autoPlay: true,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 2000),
        pauseAutoPlayOnTouch: true,
        autoPlayCurve: Curves.easeIn,
      ),
    );
  }
}

class BuildAnimatedSmoothIndicator extends StatelessWidget {
  const BuildAnimatedSmoothIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSmoothIndicator(
        activeIndex: context
            .select<CarouselSliderProvider, int>((value) => value.carouselSliderIndex),
        count: 5,
        effect: ExpandingDotsEffect(
          dotHeight: 7.0,
          dotWidth: 7.0,
          dotColor: Theme.of(context).appBarTheme.backgroundColor!,
          activeDotColor: appMainColor,
          spacing: 8.0,
        ),
      ),
    );
  }
}

class BuildTopHeadlinesTitle extends StatelessWidget {
  const BuildTopHeadlinesTitle({Key? key}) : super(key: key);

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
    width: translator.activeLanguageCode == 'ar' ? 130.0 : translator.activeLanguageCode == 'en' ?
    145.0 : 300.0,
    color: appMainColor,
    margin: const EdgeInsetsDirectional.only(start: 20.0, bottom: 10.0),
  );
}

Widget buildTabViewBody(
    {required refreshKey,
    required Future Function() refresh,
    required List<Article> articles}) {
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

  const BuildListOfItem({Key? key, required this.articles, required this.articlesNumber}) : super(key: key);

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

  const BuildItemOfList({Key? key, required this.article}) : super(key: key);

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
                    article.title,
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
                        ConvertToTimeAgo.convertToTimeAgo(
                              DateTime.parse(article.publishedAt),
                            ),
                        style: const TextStyle(
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
                            onSelect: (value) async {
                              if (value == 'visit') {
                                namedNavigateTo(
                                  context: context,
                                  routeName: WebScreenView.id,
                                  arguments: article.url,
                                );
                              } else if (value == 'save') {
                                if(provider.savedArticles.length == 6){
                                  toastMessage(
                                    message: 'item saved maximum'.tr(),
                                  );
                                }else{
                                  provider.addNewArticle(
                                    Article(
                                        title: article.title,
                                        url: article.url,
                                        imageUrl: article.imageUrl,
                                        publishedAt: article.publishedAt),
                                  ).then((value) {
                                    switch(provider.databaseMessagesStates!){
                                      case DatabaseMessagesStates.Success :
                                        toastMessage(
                                          message: provider.successMessage!,
                                        );
                                        break;
                                      case DatabaseMessagesStates.Error :
                                        toastMessage(
                                          message: provider.errorMessage!,
                                        );
                                        break;
                                    }
                                  });
                                }
                              } else {
                                await Share.share((article.url));
                              }
                            },
                            popupMenuItems: [
                              _buildPopupMenuItem(
                                value: 'visit',
                                title: 'visit item'.tr(),
                                widget: const Icon(
                                  Icons.link,
                                  color: appMainColor,
                                ),
                              ),
                              _buildPopupMenuItem(
                                value: 'save',
                                title: 'save item'.tr(),
                                widget: const Icon(
                                  Icons.bookmark,
                                  color: appMainColor,
                                ),
                              ),
                              _buildPopupMenuItem(
                                value: 'share',
                                title: 'share'.tr(),
                                widget: const Icon(
                                  Icons.share,
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
              child: BuildNetworkImage(
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
  final Future Function() refresh;

  BuildErrorWidget(
      {Key? key, required this.refresh,
      required this.image,
      required this.errorMessage}) : super(key: key);

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
                errorMessage,
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

   const BuildPlatformRefreshIndicator(
      {Key? key, required this.refreshKey,
      required this.onRefresh,
      required this.child}) : super(key: key);

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
  final Function(dynamic) onSelect;
  final List<PopupMenuItem> popupMenuItems;

  const BuildPopupMenuButton(
      {Key? key, required this.icon,
      required this.sizeOfIcon,
      required this.onSelect,
      required this.popupMenuItems}) : super(key: key);

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
    {required String value, required String title, Widget? widget}) {
  return PopupMenuItem(
    value: value,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: appGreyColor, fontWeight: FontWeight.w500),
        ),
        widget!,
      ],
    ),
  );
}
