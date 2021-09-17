import 'package:akhbary_app/utils/app_constants.dart';
import 'package:akhbary_app/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

///THIS METHOD TO BUILD CUSTOM THEMES
ThemeData buildAppCustomTheme(
    {@required Color scaffoldBackgroundColor,
    @required Color appBarColor,
    @required Color tabBarLabelColor,
    @required Color bottomNavBarColor}) {
  return ThemeData(
    primaryColor: appMainColor,
    primarySwatch: appMainColor,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    fontFamily: 'Tajawal',
    appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      backgroundColor: appBarColor,
      centerTitle: true,
      elevation: 5.0,
      iconTheme: IconThemeData(color: appMainColor, size: 26.0),
      titleTextStyle: TextStyle(
        color: appMainColor,
        fontSize: 22.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'Tajawal',
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: tabBarLabelColor,
      labelStyle: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'Tajawal',
      ),
      unselectedLabelColor: appGreyColor,
      unselectedLabelStyle: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'Tajawal',
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: bottomNavBarColor,
      selectedItemColor: appMainColor,
      unselectedItemColor: appGreyColor,
      elevation: 50.0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
  );
}

///APP LIGHT THEME
final ThemeData lightTheme = buildAppCustomTheme(
    scaffoldBackgroundColor: secondLightColor,
    appBarColor: mainLightColor,
    tabBarLabelColor: blackColor,
    bottomNavBarColor: mainLightColor);

///APP DARK THEME
final ThemeData darkTheme = buildAppCustomTheme(
    scaffoldBackgroundColor: secondDarkColor,
    appBarColor: mainDarkColor,
    tabBarLabelColor: whiteColor,
    bottomNavBarColor: mainDarkColor);

///THIS METHOD TO BUILD SHARED APPBAR
AppBar buildCustomAppBar({@required String title}) {
  return AppBar(
    centerTitle: true,
    elevation: 5.0,
    title: Text(
      title,
    ),
  );
}

///BUILD CACHED NETWORK IMAGE CUSTOM WIDGET
class BuildCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height, width;

  BuildCachedNetworkImage(
      {@required this.imageUrl, @required this.height, @required this.width});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl ?? nullImage,
      fit: BoxFit.fill,
      placeholder: (_, url) {
        return Container(
          height: height,
          width: width,
          color: greyColor,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      errorWidget: (_, url, error) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const NetworkImage(
                  'https://dab1nmslvvntp.cloudfront.net/wp-content/uploads/2015/12/1450973046wordpress-errors.png'),
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }
}

///CUSTOM LOADING WIDGET
class BuildLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

///CONSTANT PADDING
Widget verticalDistance() {
  return const SizedBox(
    height: 15.0,
  );
}

///THIS CLASS CONVERTING DATE FROM STRING FORMAT TO TIME AGO
class ConvertToTimeAgo {
  static String convertToTimeAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      return translator.activeLanguageCode == 'en'
          ? '${diff.inDays} ${('day').tr()} ${'ago'.tr()}'
          : '${'ago'.tr()} ${diff.inDays} ${'day'.tr()}';
    } else if (diff.inHours == 2 || diff.inHours <= 10) {
      return translator.activeLanguageCode == 'en'
          ? '${diff.inHours} ${'hours'.tr()} ${'ago'.tr()}'
          : '${'ago'.tr()} ${diff.inHours} ${'hours'.tr()}';
    } else if (diff.inHours == 1 || diff.inHours >= 11) {
      return translator.activeLanguageCode == 'en'
          ? '${diff.inHours} ${'hour'.tr()} ${'ago'.tr()}'
          : '${'ago'.tr()} ${diff.inHours} ${'hour'.tr()}';
    } else if (diff.inMinutes >= 1) {
      return translator.activeLanguageCode == 'en'
          ? '${diff.inMinutes} ${'minute'.tr()} ${'ago'.tr()}'
          : '${'ago'.tr()} ${diff.inMinutes} ${'minute'.tr()}';
    } else if (diff.inSeconds >= 1) {
      return translator.activeLanguageCode == 'en'
          ? '${diff.inSeconds} ${'second'.tr()} ${'ago'.tr()}'
          : '${'ago'.tr()} ${diff.inSeconds} ${'second'.tr()}';
    } else {
      return '${'just now'.tr()}';
    }
  }
}

///NAVIGATE METHOD TO NAVIGATE FOR NEWS SCREEN VIEW
void namedNavigateTo(
    {@required BuildContext context, @required String routeName, arguments}) {
  Navigator.pushNamed(context, routeName, arguments: arguments);
}
