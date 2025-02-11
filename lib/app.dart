import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teta_test/providers/articles_provider.dart';
import 'package:teta_test/routes/bookmarks_route/bookmarks_route.dart';
import 'package:teta_test/routes/news_route/news_route.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ArticlesProvider(),
      child: const DefaultTabController(
        length: 2,
        child: Scaffold(
          body: SafeArea(
            child: TabBarView(
              children: [NewsRoute(), BookmarksRoute()],
            ),
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                text: "News",
                icon: Icon(Icons.newspaper_outlined),
              ),
              Tab(
                text: "Bookmarks",
                icon: Icon(Icons.bookmark_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
