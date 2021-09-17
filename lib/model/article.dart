import 'package:akhbary_app/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Article {
  final String title, url, imageUrl, publishedAt;

  Article({
    @required this.title,
    @required this.url,
    @required this.imageUrl,
    @required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      url: json['url'],
      imageUrl: json['urlToImage'],
      publishedAt: json['publishedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title ?? 'null title'.tr();
    data['url'] = this.url ?? nullUrl;
    data['urlToImage'] = this.imageUrl ?? nullImage;
    data['publishedAt'] =
        this.publishedAt ?? DateFormat.yMMMd().format(nullDate);
    return data;
  }
}
