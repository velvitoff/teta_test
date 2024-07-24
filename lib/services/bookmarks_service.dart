import 'package:teta_test/models/article_model.dart';
import 'package:teta_test/repositories/local_storage_repo/local_storage_repo_interface.dart';

class BookMarksService {
  final LocalStorageRepoInterface localStorage;
  BookMarksService({required this.localStorage});

  void addBookmark(String url, ArticleModel article) {
    localStorage.addBookmark(url, article);
  }

  void removeBookmark(String url) {
    localStorage.removeBookmark(url);
  }

  bool isBookmarked(String url) {
    return localStorage.isBookmarked(url);
  }

  Map<String, ArticleModel> listBookmarks() {
    return localStorage.listBookmarks();
  }
}
