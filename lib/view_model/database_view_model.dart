import 'package:akhbary_app/model/article.dart';
import 'package:akhbary_app/utils/helper/database_helper.dart';
import 'package:akhbary_app/states/database_sates.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class DatabaseViewModel extends ChangeNotifier {
  DatabaseStates databaseStates = DatabaseStates.InitialState;

  List<Article> get savedArticles => _savedArticles;
  List<Article> _savedArticles = [];

  DatabaseHelper _databaseHelper = DatabaseHelper.dbHelper;

  Future<void> getSavedArticlesFromDatabase() async {
    await _databaseHelper.getAllSavedArticles().then((value) {
      _savedArticles = value;
      databaseStates = DatabaseStates.LoadedState;
    });
    notifyListeners();
  }

  DatabaseMessagesStates databaseMessagesStates;

  String _successMessage;

  String get successMessage => _successMessage;

  String _errorMessage;

  String get errorMessage => _errorMessage;

  Future<void> addNewArticle(Article article) async {
    for (int i = 0; i < _savedArticles.length; i++) {
      if (article.title == _savedArticles[i].title) {
        _errorMessage = 'item saved error'.tr();
        databaseMessagesStates = DatabaseMessagesStates.Error;
        return;
      }
    }
    await _databaseHelper.insertArticle(article);
    _savedArticles.add(article);
    _successMessage = 'item saved'.tr();
    databaseMessagesStates = DatabaseMessagesStates.Success;
    notifyListeners();
  }

  Future<void> deleteSelectedArticle(Article article) async {
    await _databaseHelper.deleteArticle(article.publishedAt);
    _savedArticles.remove(article);
    notifyListeners();
  }
}
