import 'package:flash_news_getx/models/article_model.dart';

class NewsModel {
  NewsModel(this.status, this.totalResults, this.articles);

  String status;
  int totalResults;
  List<ArticleModel> articles;

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': articles,
    };
  }

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        json['status'],
        json['totalResults'],
        (json['articles'] as List<dynamic>)
            .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
