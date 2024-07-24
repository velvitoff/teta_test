import 'package:flutter/material.dart';
import 'package:teta_test/models/article_model.dart';
import 'package:teta_test/routes/news_route/article.dart';

class Newsfeed extends StatelessWidget {
  final List<ArticleModel> articles;

  const Newsfeed({
    super.key,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return Article(
            article: articles[index],
          );
        },
      ),
    );
  }
}
