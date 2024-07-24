import 'package:teta_test/models/article_model.dart';

abstract interface class LocalStorageRepoInterface {
  void addBookmark(String url, ArticleModel article);
  void removeBookmark(String url);
  bool isBookmarked(String url);
  Map<String, ArticleModel> listBookmarks();
}
