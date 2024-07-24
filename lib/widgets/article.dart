import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teta_test/models/article_model.dart';
import 'package:teta_test/providers/articles_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Article extends StatelessWidget {
  final ArticleModel article;

  const Article({super.key, required this.article});

  static const double cardHeight = 130.0;
  static const double imageHeight = 220.0;

  @override
  Widget build(BuildContext context) {
    final height =
        article.urlToImage == null ? cardHeight : cardHeight + imageHeight;
    return SizedBox(
      height: height,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article.urlToImage != null)
                Expanded(
                  child: Center(
                    child: _RoundedNetworkImage(
                      url: article.urlToImage!,
                      height: imageHeight,
                    ),
                  ),
                ),
              _ArticleBody(article: article),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoundedNetworkImage extends StatelessWidget {
  final double height;
  final String url;
  const _RoundedNetworkImage({
    required this.url,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: cache
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        url,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      ),
    );
  }
}

class _ArticleBody extends StatelessWidget {
  final ArticleModel article;
  const _ArticleBody({required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    if (article.source.name != null)
                      Text(
                        article.source.name!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
              _BookmarkIcon(article: article),
              _GoToUrlIcon(url: article.url)
            ],
          ),
          if (article.description != null)
            Text(
              article.description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}

class _GoToUrlIcon extends StatelessWidget {
  final String? url;
  const _GoToUrlIcon({required this.url});

  Future<void> goToUrl() async {
    if (url == null) return;

    final uri = Uri.parse(url!);
    if (!await launchUrl(uri)) {
      // TODO: show dialog
      print('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: goToUrl,
      icon: const Icon(
        Icons.chevron_right_rounded,
      ),
    );
  }
}

class _BookmarkIcon extends StatelessWidget {
  final ArticleModel article;
  const _BookmarkIcon({required this.article});

  void onTap(BuildContext context) {
    if (article.url == null) return;
    context.read<ArticlesProvider>().switchBookmark(article.url!, article);
  }

  @override
  Widget build(BuildContext context) {
    bool isBookmarked =
        context.watch<ArticlesProvider>().isBookmarked(article.url!);
    return IconButton(
      onPressed: () => onTap(context),
      icon: Icon(
        isBookmarked ? Icons.bookmark_added : Icons.bookmark_add_outlined,
      ),
    );
  }
}
