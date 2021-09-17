
import 'package:akhbary_app/model/article.dart';
import 'package:akhbary_app/services/local_services/database_helper.dart';
import 'package:akhbary_app/states/database_sates.dart';
import 'package:flutter/material.dart';

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

  Future<void> addNewArticle(Article article) async {
    await _databaseHelper.insertArticle(article);
    await getSavedArticlesFromDatabase();
    notifyListeners();
  }

  Future<void> deleteSelectedArticle(String publishedAt) async {
    await _databaseHelper.deleteArticle(publishedAt);
    await getSavedArticlesFromDatabase();
    notifyListeners();
  }
}
