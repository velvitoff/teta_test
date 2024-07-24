import 'package:flutter/material.dart';
import 'package:teta_test/locator.dart';
import 'package:teta_test/models/article_model.dart';
import 'package:teta_test/routes/news_route/newsfeed.dart';
import 'package:teta_test/services/news_service.dart';
import 'package:teta_test/widgets/loading.dart';

class NewsRoute extends StatefulWidget {
  const NewsRoute({super.key});

  @override
  State<NewsRoute> createState() => _NewsRouteState();
}

class _NewsRouteState extends State<NewsRoute> {
  late final Future<List<ArticleModel>> articles;

  @override
  void initState() {
    super.initState();
    articles = locator.get<NewsService>().getTopHeadlinesUkraine();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: articles,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error getting news articles: ${snapshot.error}",
            ),
          );
        }
        if (snapshot.hasData) {
          return Newsfeed(
            articles: snapshot.data!,
          );
        }
        return const Loading();
      },
    );
  }
}
