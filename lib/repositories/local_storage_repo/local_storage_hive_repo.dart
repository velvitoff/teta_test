import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:teta_test/models/article_model.dart';
import 'package:teta_test/repositories/local_storage_repo/local_storage_repo_interface.dart';

class LocalStorageHiveRepo implements LocalStorageRepoInterface {
  final Box<String> bookmarkBox;

  LocalStorageHiveRepo._({required this.bookmarkBox});

  static Future<LocalStorageHiveRepo> init() async {
    final Box<String> box = await Hive.openBox('bookmarks');
    return LocalStorageHiveRepo._(bookmarkBox: box);
  }

  @override
  void addBookmark(String url, ArticleModel article) {
    bookmarkBox.put(url, jsonEncode(article.toJson()));
  }

  @override
  void removeBookmark(String url) {
    bookmarkBox.delete(url);
  }

  @override
  bool isBookmarked(String url) {
    final res = bookmarkBox.get(url);
    return res != null;
  }

  @override
  Map<String, ArticleModel> listBookmarks() {
    final res = bookmarkBox.values
        .map((e) => ArticleModel.fromJson(jsonDecode(e)))
        .toList();
    return Map.fromEntries(
      res.map(
        (e) => MapEntry(e.url!, e),
      ),
    );
  }
}
