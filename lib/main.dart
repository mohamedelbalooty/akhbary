import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'provider/app_theme_provider.dart';
import 'utils/app_constants.dart';
import 'utils/helper/cache_helper.dart';
import 'utils/multi_providers.dart';
import 'utils/routes.dart';
import 'view/app_components.dart';
import 'view/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await translator.init(
    localeType: LocalizationDefaultType.device,
    language: setLanguage(),
    languagesList: <String>['ar', 'en', 'fr'],
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
  if (CacheHelper.getStringData(key: sharedPrefsLanguageKey) == null) {
    return 'ar';
  } else if (CacheHelper.getStringData(key: sharedPrefsLanguageKey) == 'eg') {
    return 'ar';
  } else if(CacheHelper.getStringData(key: sharedPrefsLanguageKey) == 'us'){
    return 'en';
  }else{
    return 'fr';
  }
}

class AkhbaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Akhbary - أخباري',
      initialRoute: SplashView.id,
      routes: Routs.routs,
      localizationsDelegates: translator.delegates,
      locale: translator.activeLocale,
      supportedLocales: translator.locals(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: context.select<AppThemeProvider, bool>((value) => value.isDark) ? ThemeMode.dark : ThemeMode.light,
    );
  }
}

