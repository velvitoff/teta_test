import 'package:flutter/material.dart';
import 'package:teta_test/routes/bookmarks_route.dart';
import 'package:teta_test/routes/news_route.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [NewsRoute(), BookmarksRoute()],
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
    );
  }
}
