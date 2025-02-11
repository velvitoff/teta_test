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

  ArticleModel? _modelFromKey(dynamic key) {
    if (key == null) return null;
    final value = bookmarkBox.get(key);
    if (value == null) return null;
    return ArticleModel.fromJson(jsonDecode(value));
  }

  @override
  void addBookmark(ArticleModel article) {
    bookmarkBox.add(jsonEncode(article.toJson()));
  }

  @override
  void removeBookmark(String url) {
    final key = bookmarkBox.keys
        .where((key) => _modelFromKey(key)!.url == url)
        .firstOrNull;
    if (key == null) return;
    bookmarkBox.delete(key);
  }

  @override
  bool isBookmarked(String url) {
    final key = bookmarkBox.keys
        .where((key) => _modelFromKey(key)!.url == url)
        .firstOrNull;
    return key != null;
  }

  @override
  Map<dynamic, ArticleModel> listBookmarks() {
    return Map<dynamic, ArticleModel>.fromEntries(bookmarkBox.keys.map(
        (key) => MapEntry<dynamic, ArticleModel>(key, _modelFromKey(key)!)));
  }
}
