import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teta_test/locator.dart';
import 'package:teta_test/models/article_model.dart';
import 'package:teta_test/providers/articles_provider.dart';
import 'package:teta_test/widgets/newsfeed.dart';
import 'package:teta_test/services/news_service.dart';
import 'package:teta_test/widgets/loading.dart';

class NewsRoute extends StatefulWidget {
  const NewsRoute({super.key});

  @override
  State<NewsRoute> createState() => _NewsRouteState();
}

class _NewsRouteState extends State<NewsRoute>
    with AutomaticKeepAliveClientMixin {
  late final Future<List<ArticleModel>> articles;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    articles = locator.get<NewsService>().getTopHeadlinesUkraine();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          return ChangeNotifierProvider(
            create: (context) => ArticlesProvider(snapshot.data!),
            child: const Newsfeed(
              showOnlyBookmarked: false,
            ),
          );
        }
        return const Loading();
      },
    );
  }
}
