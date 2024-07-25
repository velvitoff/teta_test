import 'package:flutter/material.dart';
import 'package:teta_test/locator.dart';
import 'package:teta_test/models/article_model.dart';
import 'package:teta_test/services/bookmarks_service.dart';
import 'package:teta_test/services/news_service.dart';

class ArticlesProvider extends ChangeNotifier {
  /// bool value: true if article is bookmarked
  List<(bool, ArticleModel)> networkArticles = [];
  List<ArticleModel> localArticles = [];
  String searchQuery = '';

  List<ArticleModel> _getBookmarkedArticles() => locator
      .get<BookMarksService>()
      .listBookmarks()
      .entries
      .map((entry) => entry.value)
      .toList();

  ArticlesProvider() {
    localArticles = _getBookmarkedArticles();
  }

  Future<bool> updateNetworkArticles() async {
    final articles = await locator.get<NewsService>().getTopHeadlinesUkraine();
    networkArticles = articles
        .map((a) => (
              a.url == null
                  ? false
                  : locator.get<BookMarksService>().isBookmarked(a.url!),
              a,
            ))
        .toList();
    notifyListeners();
    return true;
  }

  List<ArticleModel> searchNetworkArticles() {
    return networkArticles
        .where((item) =>
            (searchQuery.isEmpty || item.$2.title.contains(searchQuery)))
        .map((item) => item.$2)
        .toList();
  }

  List<ArticleModel> searchLocalArticles() {
    return localArticles
        .where(
            (item) => (searchQuery.isEmpty || item.title.contains(searchQuery)))
        .toList();
  }

  bool isBookmarked(String url) {
    final found = localArticles.where((e) => e.url == url).firstOrNull;
    return found != null;
  }

  void switchBookmark(String url, ArticleModel article) {
    //update local storage
    if (isBookmarked(url)) {
      locator.get<BookMarksService>().removeBookmark(url);
    } else {
      locator.get<BookMarksService>().addBookmark(article);
    }

    //update networkArticles
    for (int i = 0; i < networkArticles.length; i++) {
      if (networkArticles[i].$2.url == url) {
        networkArticles[i] = (!networkArticles[i].$1, networkArticles[i].$2);
        break;
      }
    }

    //update localArticles
    localArticles = _getBookmarkedArticles();

    notifyListeners();
  }

  void setSearchQuery(String query) {
    searchQuery = query;
    notifyListeners();
  }
}
