import 'package:teta_test/models/article_model.dart';

abstract interface class LocalStorageRepoInterface {
  void addBookmark(ArticleModel article);
  void removeBookmark(String url);
  bool isBookmarked(String url);
  Map<dynamic, ArticleModel> listBookmarks();
}
