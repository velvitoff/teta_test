import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teta_test/providers/articles_provider.dart';
import 'package:teta_test/widgets/newsfeed.dart';
import 'package:teta_test/widgets/loading.dart';

class NewsRoute extends StatefulWidget {
  const NewsRoute({super.key});

  @override
  State<NewsRoute> createState() => _NewsRouteState();
}

class _NewsRouteState extends State<NewsRoute>
    with AutomaticKeepAliveClientMixin {
  late final Future<bool> future;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    future = context.read<ArticlesProvider>().updateNetworkArticles();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error getting news articles: ${snapshot.error}",
            ),
          );
        }
        if (snapshot.hasData) {
          return const Newsfeed(
            showOnlyBookmarked: false,
          );
        }
        return const Loading();
      },
    );
  }
}
