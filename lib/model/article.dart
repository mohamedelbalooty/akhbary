import 'package:akhbary_app/utils/app_constants.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Article {
  final String author, title, url, imageUrl, publishedAt;
  final String source;

  Article({
    required this.author,
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.source,
  });

  factory Article.fromRemoteJson(Map<String, dynamic> json) {
    return Article(
        author: json['author'] ?? '',
        title: json['title'] ?? 'null title'.tr(),
        url: json['url'] ?? nullUrl,
        imageUrl: json['urlToImage'] ?? nullImage,
        publishedAt: json['publishedAt'] ?? DateFormat.yMMMd().format(nullDate),
        source: json['source']['name']);
  }

  factory Article.fromLocalJson(Map<String, dynamic> json) {
    return Article(
        author: json['author'] ?? '',
        title: json['title'] ?? 'null title'.tr(),
        url: json['url'] ?? nullUrl,
        imageUrl: json['urlToImage'] ?? nullImage,
        publishedAt: json['publishedAt'] ?? DateFormat.yMMMd().format(nullDate),
        source: json['source']);
  }

  Map<String, dynamic> toJson() {
    return {
      dbColumnTitle: title,
      dbColumnUrl: url,
      dbColumnImageUrl: imageUrl,
      dbColumnPublishedAt: publishedAt,
      dbColumnAuthor: author,
      dbColumnSource: source
    };
  }
}
