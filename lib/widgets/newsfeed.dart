import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teta_test/models/article_model.dart';
import 'package:teta_test/providers/articles_provider.dart';
import 'package:teta_test/widgets/article.dart';
import 'package:teta_test/widgets/my_search_bar.dart';

class Newsfeed extends StatelessWidget {
  final bool showOnlyBookmarked;
  const Newsfeed({
    super.key,
    required this.showOnlyBookmarked,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ArticlesProvider>();
    final List<ArticleModel> articles;
    if (showOnlyBookmarked) {
      articles = model.searchLocalArticles();
    } else {
      articles = model.searchNetworkArticles();
    }

    void searchCallback(String query) {
      model.setSearchQuery(query);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Column(
        children: [
          MySearchBar(callback: searchCallback),
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return Article(
                  article: articles[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
