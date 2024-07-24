import 'dart:convert';

import 'package:teta_test/env.dart';
import 'package:teta_test/models/article_model.dart';
import 'package:teta_test/repositories/news_repo/news_repo_interface.dart';
import 'package:http/http.dart' as http;

class NewsApiRepo implements NewsRepoInterface {
  static const String baseUrl = "newsapi.org";
  @override
  Future<List<ArticleModel>> getTopHeadlinesUkraine() async {
    final url = Uri.https(baseUrl, '/v2/top-headlines', {
      'country': 'ua',
      'apiKey': Env.newsApiKey,
    });

    final response = await http.get(url);
    final json = jsonDecode(response.body);
    return List.from(json['articles'])
        .map((e) => ArticleModel.fromJson(e))
        .toList();
  }
}
