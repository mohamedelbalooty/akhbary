import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'multi_providers.dart';
import 'provider/app_theme_provider.dart';
import 'routes.dart';
import 'services/local_services/cache_helper.dart';
import 'utils/app_constants.dart';
import 'view/app_components.dart';
import 'view/layout_view/layout_view.dart';
import 'view/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await translator.init(
    localeType: LocalizationDefaultType.device,
    language: setLanguage(),
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/langs/',
  );
  return runApp(
    MultiProvider(
      providers: MultiProviders.providers,
      child: LocalizedApp(
        child: AkhbaryApp(),
      ),
    ),
  );
}

String setLanguage() {
  if (CacheHelper.getStringData(key: sharedPrefsLanguageKey) == null ||
      CacheHelper.getStringData(key: sharedPrefsLanguageKey) == false) {
    return 'ar';
  } else if (CacheHelper.getStringData(key: sharedPrefsLanguageKey) == 'eg') {
    return 'ar';
  } else {
    return 'en';
  }
}

class AkhbaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: context.select<AppThemeProvider, bool>((value) => value.isDark)
          ? darkTheme
          : lightTheme,
      builder: (_, myTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'أخباري',
        initialRoute: CacheHelper.getBooleanData(key: sharedPrefsSplashKey) ==
                    false ||
                CacheHelper.getBooleanData(key: sharedPrefsSplashKey) == null
            ? SplashView.id
            : LayoutView.id,
        routes: Routs.routs,
        localizationsDelegates: translator.delegates,
        locale: translator.activeLocale,
        supportedLocales: translator.locals(),
        theme: myTheme,
      ),
    );
  }
}
