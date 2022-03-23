import 'package:akhbary_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:transparent_image/transparent_image.dart';

///THIS METHOD TO BUILD CUSTOM THEMES
ThemeData buildAppCustomTheme(
    {required Color scaffoldBackgroundColor,
    required Color appBarColor,
    required Color tabBarLabelColor,
    required Color bottomNavBarColor}) {
  return ThemeData(
    primaryColor: appMainColor,
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    fontFamily: 'Tajawal',
    appBarTheme: AppBarTheme(
      backgroundColor: appBarColor,
      centerTitle: true,
      elevation: 5.0,
      iconTheme: const IconThemeData(color: appMainColor, size: 26.0),
      titleTextStyle: const TextStyle(
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
      unselectedLabelStyle: const TextStyle(
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
AppBar buildCustomAppBar({required String title}) {
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
      {required this.imageUrl, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: height,
          width: width,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset(
                'assets/images/loading.png',
                color: Colors.grey.shade300,
              ),
            ),
          ),
        ),
        FadeInImage.memoryNetwork(
          height: height,
          width: width,
          image: imageUrl,
          fit: BoxFit.fill,
          placeholder: kTransparentImage,
          placeholderErrorBuilder: (_, value, error) {
            return SizedBox(
              height: height,
              width: width,
              child: const Center(
                child: Icon(
                  Icons.error,
                  size: 28.0,
                  color: Colors.red,
                ),
              ),
            );
          },
          imageErrorBuilder: (_, value, error) {
            return SizedBox(
              height: height,
              width: width,
              child: const Center(
                child: Icon(
                  Icons.error,
                  size: 28.0,
                  color: Colors.red,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

///CUSTOM LOADING WIDGET
class BuildLoadingWidget extends StatelessWidget {
  const BuildLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

SizedBox verticalDistance() {
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

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

///NAVIGATE METHOD TO NAVIGATE FOR NEWS SCREEN VIEW
void namedNavigateTo(
    {required BuildContext context, required String routeName, arguments}) {
  Navigator.pushNamed(context, routeName, arguments: arguments);
}

void toastMessage({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.black87.withOpacity(0.5),
      fontSize: 16.0
  );
}
