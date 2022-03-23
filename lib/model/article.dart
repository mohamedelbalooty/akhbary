import 'package:akhbary_app/utils/app_constants.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Article {
  final String title, url, imageUrl, publishedAt;

  Article({
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'null title'.tr(),
      url: json['url'] ?? nullUrl,
      imageUrl: json['urlToImage'] ?? nullImage,
      publishedAt: json['publishedAt'] ?? DateFormat.yMMMd().format(nullDate),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    data['urlToImage'] = this.imageUrl;
    data['publishedAt'] =
        this.publishedAt;
    return data;
  }
}
