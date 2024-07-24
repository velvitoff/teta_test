import 'package:flutter/material.dart';
import 'package:teta_test/locator.dart';
import 'package:teta_test/routes/news_route/newsfeed.dart';
import 'package:teta_test/services/bookmarks_service.dart';

class BookmarksRoute extends StatelessWidget {
  const BookmarksRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final articles =
        locator.get<BookMarksService>().listBookmarks().values.toList();
    if (articles.isEmpty) {
      return const Center(
        child: Text("No bookmarks found"),
      );
    }
    return Newsfeed(articles: articles);
  }
}
