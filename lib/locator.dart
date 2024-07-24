import 'package:get_it/get_it.dart';
import 'package:teta_test/repositories/news_repo/news_api_repo.dart';
import 'package:teta_test/services/news_service.dart';

final locator = GetIt.instance;

void setup() {
  locator
      .registerSingleton<NewsService>(NewsService(repository: NewsApiRepo()));
}