import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teta_test/locator.dart';
import 'package:teta_test/providers/articles_provider.dart';
import 'package:teta_test/widgets/newsfeed.dart';
import 'package:teta_test/services/bookmarks_service.dart';

class BookmarksRoute extends StatefulWidget {
  const BookmarksRoute({super.key});

  @override
  State<BookmarksRoute> createState() => _BookmarksRouteState();
}

class _BookmarksRouteState extends State<BookmarksRoute> {
  @override
  Widget build(BuildContext context) {
    final articles =
        locator.get<BookMarksService>().listBookmarks().values.toList();
    return ChangeNotifierProvider(
      create: (context) => ArticlesProvider(articles),
      child: const Newsfeed(
        showOnlyBookmarked: true,
      ),
    );
  }
}
