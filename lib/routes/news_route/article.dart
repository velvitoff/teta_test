import 'package:flutter/material.dart';
import 'package:teta_test/models/article_model.dart';

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
              _ArticleHeader(article: article),
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

class _ArticleHeader extends StatelessWidget {
  final ArticleModel article;
  const _ArticleHeader({required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          if (article.source.name != null)
            Text(
              article.source.name!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
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
