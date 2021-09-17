import 'package:akhbary_app/model/article.dart';
import 'package:akhbary_app/model/error_result.dart';
import 'package:akhbary_app/services/local_services/cache_helper.dart';
import 'package:akhbary_app/services/remote_services/article_services.dart';
import 'package:akhbary_app/states/article_states.dart';
import 'package:akhbary_app/utils/app_constants.dart';
import 'package:flutter/material.dart';

class ArticleViewModel extends ChangeNotifier {
  String cacheLang = CacheHelper.getStringData(key: sharedPrefsLanguageKey);

  TopHeadlinesStates topHeadlinesStates;
  BusinessStates businessStates;
  TechStates techStates;
  SportsStates sportsStates;
  HealthStates healthStates;
  EntertainmentStates entertainmentStates;
  SearchingStates searchingStates;

  ///INITIALIZE STATES VALUE
  ArticleViewModel() {
    changeServiceLang(currentLang: cacheLang);
    topHeadlinesStates = TopHeadlinesStates.InitialState;
    businessStates = BusinessStates.InitialState;
    techStates = TechStates.InitialState;
    sportsStates = SportsStates.InitialState;
    healthStates = HealthStates.InitialState;
    entertainmentStates = EntertainmentStates.InitialState;
    searchingStates = SearchingStates.InitialState;
  }

  String language;

  void changeServiceLang({String selectedLang = 'eg', String currentLang}) {
    if (currentLang != null) {
      language = cacheLang;
      notifyListeners();
    } else {
      language = selectedLang;
      CacheHelper.setStringData(key: sharedPrefsLanguageKey, value: language);
      changeServicesStates();
      notifyListeners();
    }
  }

  void changeServicesStates() {
    topHeadlinesStates = TopHeadlinesStates.InitialState;
    businessStates = BusinessStates.InitialState;
    techStates = TechStates.InitialState;
    sportsStates = SportsStates.InitialState;
    healthStates = HealthStates.InitialState;
    entertainmentStates = EntertainmentStates.InitialState;
  }

  List<Article> get topHeadlinesArticles => _topHeadlinesArticles;

  List<Article> get businessArticles => _businessArticles;

  List<Article> get techArticles => _techArticles;

  List<Article> get sportsArticles => _sportsArticles;

  List<Article> get healthArticles => _healthArticles;

  List<Article> get entertainmentArticles => _entertainmentArticles;

  List<Article> get searchArticles => _searchArticles;

  ErrorResult get topHeadlineErrorResult => _topHeadlineErrorResult;

  ErrorResult get businessErrorResult => _businessErrorResult;

  ErrorResult get techErrorResult => _techErrorResult;

  ErrorResult get sportsErrorResult => _sportsErrorResult;

  ErrorResult get healthErrorResult => _healthErrorResult;

  ErrorResult get entertainmentErrorResult => _entertainmentErrorResult;

  ErrorResult get searchErrorResult => _searchErrorResult;

  List<Article> _topHeadlinesArticles;
  List<Article> _businessArticles;
  List<Article> _techArticles;
  List<Article> _sportsArticles;
  List<Article> _healthArticles;
  List<Article> _entertainmentArticles;
  List<Article> _searchArticles;

  ErrorResult _topHeadlineErrorResult;
  ErrorResult _businessErrorResult;
  ErrorResult _techErrorResult;
  ErrorResult _sportsErrorResult;
  ErrorResult _healthErrorResult;
  ErrorResult _entertainmentErrorResult;
  ErrorResult _searchErrorResult;

  ArticleServicesImplementation _articleServicesImplementation =
      ArticleServicesImplementation();

  Future<void> getTopHeadlineArticles({@required String country}) async {
    topHeadlinesStates = TopHeadlinesStates.LoadingState;
    await _articleServicesImplementation
        .getTopHeadlineArticles(country: country)
        .then(
      (value) {
        value.fold(
          (left) {
            _topHeadlinesArticles = left;
            topHeadlinesStates = TopHeadlinesStates.LoadedState;
          },
          (right) {
            _topHeadlineErrorResult = right;
            topHeadlinesStates = TopHeadlinesStates.ErrorState;
          },
        );
      },
    );
    notifyListeners();
  }

  Future<void> getBusinessArticles({@required String country}) async {
    businessStates = BusinessStates.LoadingState;
    await _articleServicesImplementation
        .getArticlesByCategory(country: country, category: 'business')
        .then((value) {
      value.fold((left) {
        _businessArticles = left;
        businessStates = BusinessStates.LoadedState;
      }, (right) {
        _businessErrorResult = right;
        businessStates = BusinessStates.ErrorState;
      });
    });
    notifyListeners();
  }

  Future<void> getTechArticles({@required String country}) async {
    techStates = TechStates.LoadingState;
    await _articleServicesImplementation
        .getArticlesByCategory(country: country, category: 'technology')
        .then((value) {
      value.fold((left) {
        _techArticles = left;
        techStates = TechStates.LoadedState;
      }, (right) {
        _techErrorResult = right;
        techStates = TechStates.ErrorState;
      });
    });
    notifyListeners();
  }

  Future<void> getSportsArticles({@required String country}) async {
    sportsStates = SportsStates.LoadingState;
    await _articleServicesImplementation
        .getArticlesByCategory(country: country, category: 'sports')
        .then((value) {
      value.fold((left) {
        _sportsArticles = left;
        sportsStates = SportsStates.LoadedState;
      }, (right) {
        _sportsErrorResult = right;
        sportsStates = SportsStates.ErrorState;
      });
    });
    notifyListeners();
  }

  Future<void> getHealthArticles({@required String country}) async {
    healthStates = HealthStates.LoadingState;
    await _articleServicesImplementation
        .getArticlesByCategory(country: country, category: 'health')
        .then((value) {
      value.fold((left) {
        _healthArticles = left;
        healthStates = HealthStates.LoadedState;
      }, (right) {
        _healthErrorResult = right;
        healthStates = HealthStates.ErrorState;
      });
    });
    notifyListeners();
  }

  Future<void> getEntertainmentArticles({@required String country}) async {
    entertainmentStates = EntertainmentStates.LoadingState;
    await _articleServicesImplementation
        .getArticlesByCategory(country: country, category: 'entertainment')
        .then((value) {
      value.fold((left) {
        _entertainmentArticles = left;
        entertainmentStates = EntertainmentStates.LoadedState;
      }, (right) {
        _entertainmentErrorResult = right;
        entertainmentStates = EntertainmentStates.ErrorState;
      });
    });
    notifyListeners();
  }

  Future<void> getArticlesFromSearching({@required String searchValue}) async {
    searchingStates = SearchingStates.LoadingState;
    if (searchValue.isNotEmpty) {
      await _articleServicesImplementation
          .getArticlesFromSearch(searchValue: searchValue)
          .then(
        (value) {
          value.fold((left) {
            _searchArticles = left;
            searchingStates = SearchingStates.LoadedState;
          }, (right) {
            _searchErrorResult = right;
            searchingStates = SearchingStates.ErrorState;
          });
        },
      );
    } else {
      searchingStates = SearchingStates.EmptyState;
    }
    notifyListeners();
  }
}
