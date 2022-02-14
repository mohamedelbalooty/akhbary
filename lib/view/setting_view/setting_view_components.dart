import 'package:akhbary_app/provider/bottom_nav_bar_provider.dart';
import 'package:akhbary_app/provider/app_theme_provider.dart';
import 'package:akhbary_app/provider/tap_bar_provider.dart';
import 'package:akhbary_app/utils/colors.dart';
import 'package:akhbary_app/view_model/article_view_model.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_components.dart';
import 'static_views/about_view.dart';

class BuildVersionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'version'.tr(),
                  style: TextStyle(
                    color: Theme.of(context).tabBarTheme.labelColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${snapshot.data.version}',
                  style: TextStyle(
                    color: Theme.of(context).tabBarTheme.labelColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          default:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'version'.tr(),
                  style: TextStyle(
                    color: Theme.of(context).tabBarTheme.labelColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '1.0.0',
                  style: TextStyle(
                    color: Theme.of(context).tabBarTheme.labelColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
        }
      },
    );
  }
}

class BuildSettingItemWidget extends StatefulWidget {
  final IconData icon;
  final String title;
  final Function onClick;
  final bool isThemeIcon;

  const BuildSettingItemWidget(
      {@required this.icon,
      @required this.title,
      @required this.onClick,
      this.isThemeIcon = false});

  @override
  _BuildSettingItemWidgetState createState() => _BuildSettingItemWidgetState();
}

class _BuildSettingItemWidgetState extends State<BuildSettingItemWidget> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      focusColor: widget.isThemeIcon
          ? Colors.transparent
          : Theme.of(context).highlightColor,
      splashColor: widget.isThemeIcon
          ? Colors.transparent
          : Theme.of(context).splashColor,
      highlightColor: widget.isThemeIcon
          ? Colors.transparent
          : Theme.of(context).highlightColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Icon(
              widget.icon,
              color: Theme.of(context).tabBarTheme.labelColor,
              size: 24.0,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              widget.title,
              style: TextStyle(
                  color: Theme.of(context).tabBarTheme.labelColor,
                  fontSize: 18.0,
                  height: 1.0,
                  fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            widget.isThemeIcon
                ? ThemeSwitcher(
                    builder: (context) {
                      return Consumer<AppThemeProvider>(
                        builder: (context, provider, child) {
                          return FlutterSwitch(
                            width: 50.0,
                            height: 25.0,
                            toggleSize: 15.0,
                            value: provider.isDark,
                            borderRadius: 30.0,
                            padding: 3.0,
                            toggleColor:
                                Theme.of(context).appBarTheme.backgroundColor,
                            switchBorder: Border.all(
                              color: appMainColor,
                              width: 2,
                            ),
                            toggleBorder: Border.all(
                              color: appMainColor,
                              width: 1.5,
                            ),
                            activeColor: secondLightColor,
                            inactiveColor: secondDarkColor,
                            onToggle: (val) {
                              provider.changeAppTheme(switchValue: val);
                              ThemeSwitcher.of(context).changeTheme(
                                theme: provider.isDark ? darkTheme : lightTheme,
                                reverseAnimation:
                                    provider.isDark ? true : false,
                              );
                            },
                          );
                        },
                      );
                    },
                  )
                : Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).tabBarTheme.labelColor,
                    size: 20.0,
                  ),
          ],
        ),
      ),
    );
  }
}

class BuildContactUsItemWidget extends StatelessWidget {
  final String title, imageIcon;
  final Function onClick;

  const BuildContactUsItemWidget(
      {@required this.title, @required this.imageIcon, @required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            imageIcon,
            height: 25.0,
            width: 25.0,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            width: 15.0,
          ),
          Text(
            title,
            style: TextStyle(
                color: Theme.of(context).tabBarTheme.labelColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                height: 1.8),
          ),
        ],
      ),
    );
  }
}

List<BuildSettingItemWidget> settingItems(BuildContext context) {
  return [
    BuildSettingItemWidget(
      title: 'about'.tr(),
      icon: Icons.help_outline,
      onClick: () {
        namedNavigateTo(context: context, routeName: AboutView.id);
      },
    ),
    BuildSettingItemWidget(
      title: 'privacy'.tr(),
      icon: Icons.lock_outline,
      onClick: () {
        launchURL(
            'https://github.com/mohamedelbalooty/Akhbary_Privacy_Policy#readme');
      },
    ),
    BuildSettingItemWidget(
      title: 'country'.tr(),
      icon: Icons.language_outlined,
      onClick: () {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (_) {
              return Container(
                height: 200.0,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 50.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 3.0,
                        width: 100.0,
                        margin: const EdgeInsets.only(top: 15.0, bottom: 20.0),
                        color: appMainColor,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: bottomSheetItems(context).length,
                        itemBuilder: (_, index) {
                          return bottomSheetItems(context)[index];
                        },
                        separatorBuilder: (_, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Divider(
                            height: 5.0,
                            color: Theme.of(context).tabBarTheme.labelColor,
                            thickness: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    ),
    BuildSettingItemWidget(
      title: 'dark_mode'.tr(),
      icon: Icons.wb_incandescent_outlined,
      isThemeIcon: true,
      onClick: () {},
    ),
  ];
}

List<BuildContactUsItemWidget> contactItems() {
  return [
    BuildContactUsItemWidget(
      title: 'Gmail',
      imageIcon: 'assets/images/gmail.png',
      onClick: () {
        launchURL('mailto:mohamedelbalooty123@gmail.com?%20subject&%20body');
      },
    ),
    BuildContactUsItemWidget(
      title: 'Facebook',
      imageIcon: 'assets/images/facebook.png',
      onClick: () {
        launchURL('https://www.facebook.com/mohamed.elbalooty.9');
      },
    ),
    BuildContactUsItemWidget(
      title: 'LinkedIn',
      imageIcon: 'assets/images/linkedin.png',
      onClick: () {
        launchURL('https://www.linkedin.com/in/mohamed-elbalooty/');
      },
    ),
  ];
}

void launchURL(String url) async {
  if (!await launch(url)) throw 'Could not launch';
}

List<BuildBottomSheetItem> bottomSheetItems(BuildContext context) {
  var provider = Provider.of<ArticleViewModel>(context, listen: false);
  return [
    BuildBottomSheetItem(
      title: 'مِصْرَ',
      iconImage: 'assets/images/eg_flag.png',
      onClick: () {
        if (provider.language == 'eg') {
          Navigator.pop(context);
          alarmMessage(context, message: 'بالفعل انت تشاهد اخبار مصر');
        } else {
          provider.changeServiceLang(selectedLang: 'eg');
          translator
              .setNewLanguage(context, newLanguage: 'ar', restart: true)
              .then((value) {
            context.read<BottomNavParProvider>().changeBottomNavBarIndex(0);
            context.read<TapBarProvider>().changeTabBarIndex(0);
          });
        }
      },
    ),
    BuildBottomSheetItem(
      title: 'United states',
      iconImage: 'assets/images/us_flag.png',
      onClick: () {
        if (provider.language == 'us') {
          Navigator.pop(context);
          alarmMessage(context,
              message:
                  'Already you are watching the news of the United States of America');
        } else {
          provider.changeServiceLang(selectedLang: 'us');
          translator
              .setNewLanguage(context, newLanguage: 'en', restart: true)
              .then((value) {
            context.read<BottomNavParProvider>().changeBottomNavBarIndex(0);
            context.read<TapBarProvider>().changeTabBarIndex(0);
          });
        }
      },
    ),
    BuildBottomSheetItem(
      title: 'France',
      iconImage: 'assets/images/fr_flag.png',
      onClick: () {
        if (provider.language == 'fr') {
          Navigator.pop(context);
          alarmMessage(context,
              message: "Vous regardez déjà l'actualité de France");
        } else {
          provider.changeServiceLang(selectedLang: 'fr');
          translator
              .setNewLanguage(context, newLanguage: 'fr', restart: true)
              .then((value) {
            context.read<BottomNavParProvider>().changeBottomNavBarIndex(0);
            context.read<TapBarProvider>().changeTabBarIndex(0);
          });
        }
      },
    ),
  ];
}

class BuildBottomSheetItem extends StatelessWidget {
  final String title, iconImage;
  final Function onClick;

  const BuildBottomSheetItem(
      {@required this.title, @required this.iconImage, @required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Theme.of(context).tabBarTheme.labelColor,
                fontWeight: FontWeight.w500),
          ),
          Container(
            height: 30.0,
            width: 35.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(iconImage),
                fit: BoxFit.fill,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}