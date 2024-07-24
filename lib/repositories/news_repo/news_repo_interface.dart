import 'package:teta_test/models/article_model.dart';

abstract interface class NewsRepoInterface {
  Future<List<ArticleModel>> getTopHeadlinesUkraine();
}
