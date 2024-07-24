import 'package:teta_test/models/article_model.dart';
import 'package:teta_test/repositories/news_repo/news_repo_interface.dart';

class NewsService {
  final NewsRepoInterface repository;
  const NewsService({required this.repository});

  Future<List<ArticleModel>> getTopHeadlinesUkraine() {
    // TODO: cache
    return repository.getTopHeadlinesUkraine();
  }
}
