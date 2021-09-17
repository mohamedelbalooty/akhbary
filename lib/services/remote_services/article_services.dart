import 'package:akhbary_app/core/status_code_errors.dart';
import 'package:akhbary_app/model/article.dart';
import 'package:akhbary_app/model/error_result.dart';
import 'package:akhbary_app/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

abstract class ArticleServices {
  ///THIS ABSTRACT CLASS FOR SHOWING SERVICES METHODS
  Future<Either<List<Article>, ErrorResult>> getTopHeadlineArticles();

  Future<Either<List<Article>, ErrorResult>> getArticlesByCategory();

  Future<Either<List<Article>, ErrorResult>> getArticlesFromSearch();
}

class ArticleServicesImplementation extends ArticleServices {
  @override
  Future<Either<List<Article>, ErrorResult>> getTopHeadlineArticles(
      {@required String country}) async {
    Uri url = Uri.parse('$baseUrl?country=$country&apiKey=$apiKey');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        List<dynamic> data = jsonData['articles'];
        List<Article> articles =
            data.map((item) => Article.fromJson(item)).toList();
        return Left(articles);
      } else {
        return Right(returnResponse(response));
      }
    } on SocketException {
      ErrorResult errors = ErrorResult(
          errorMessage: 'socketException'.tr(),
          errorImage: 'assets/images/socket_error.png');
      return Right(errors);
    } on FormatException {
      ErrorResult errorResult = ErrorResult(
          errorMessage: 'formatException'.tr(),
          errorImage: 'assets/images/format_error.png');
      return Right(errorResult);
    }
  }

  @override
  Future<Either<List<Article>, ErrorResult>> getArticlesByCategory(
      {@required String country, @required String category}) async {
    Uri url = Uri.parse(
        '$baseUrl?country=$country&category=$category&apiKey=$apiKey');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        List<dynamic> data = jsonData['articles'];
        List<Article> articles =
            data.map((item) => Article.fromJson(item)).toList();
        return Left(articles);
      } else {
        return Right(returnResponse(response));
      }
    } on SocketException {
      ErrorResult errorResult = ErrorResult(
          errorMessage: 'socketException'.tr(),
          errorImage: 'assets/images/socket_error.png');
      return Right(errorResult);
    } on FormatException {
      ErrorResult errorResult = ErrorResult(
          errorMessage: 'formatException'.tr(),
          errorImage: 'assets/images/format_error.png');
      return Right(errorResult);
    }
  }

  @override
  Future<Either<List<Article>, ErrorResult>> getArticlesFromSearch(
      {@required String searchValue}) async {
    Uri url = Uri.parse(
        '$searchBaseUrl?q=$searchValue&from=2021-08-21&sortBy=popularity&apiKey=$apiKey');
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        List<dynamic> data = jsonData['articles'];
        List<Article> searchArticles = data
            .map(
              (item) => Article.fromJson(item),
            )
            .toList();
        return Left(searchArticles);
      } else {
        return Right(returnResponse(response.statusCode));
      }
    } on SocketException {
      ErrorResult errorResult = ErrorResult(
          errorMessage: 'socketException'.tr(),
          errorImage: 'assets/images/socket_error.png');
      return Right(errorResult);
    } on FormatException {
      ErrorResult errorResult = ErrorResult(
          errorMessage: 'formatException'.tr(),
          errorImage: 'assets/images/format_error.png');
      return Right(errorResult);
    }
  }
}
