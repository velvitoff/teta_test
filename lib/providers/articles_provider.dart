import 'package:flutter/material.dart';
import 'package:teta_test/locator.dart';
import 'package:teta_test/models/article_model.dart';
import 'package:teta_test/services/bookmarks_service.dart';

class ArticlesProvider extends ChangeNotifier {
  /// bool value: true if article is bookmarked
  List<(bool, ArticleModel)> allArticles = [];
  String searchQuery = '';

  ArticlesProvider(List<ArticleModel> articles) {
    allArticles = articles
        .map((a) => (
              a.url == null
                  ? false
                  : locator.get<BookMarksService>().isBookmarked(a.url!),
              a,
            ))
        .toList();
  }

  List<ArticleModel> searchArticles({bool showOnlyBookmarked = false}) {
    return allArticles
        .where((item) =>
            (!showOnlyBookmarked || item.$1) &&
            (searchQuery.isEmpty || item.$2.title.contains(searchQuery)))
        .map((item) => item.$2)
        .toList();
  }

  bool isBookmarked(String url) {
    final found = allArticles.where((e) => e.$2.url == url).firstOrNull;
    return found?.$1 ?? false;
  }

  void switchBookmark(String url, ArticleModel article) {
    if (isBookmarked(url)) {
      locator.get<BookMarksService>().removeBookmark(url);
    } else {
      locator.get<BookMarksService>().addBookmark(article);
    }

    //update allArticles
    for (int i = 0; i < allArticles.length; i++) {
      if (allArticles[i].$2.url == url) {
        allArticles[i] = (!allArticles[i].$1, allArticles[i].$2);
        break;
      }
    }

    notifyListeners();
  }

  void setSearchQuery(String query) {
    searchQuery = query;
    notifyListeners();
  }
}
