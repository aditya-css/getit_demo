import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../core/service_locator.dart';
import 'favourite_articles.dart';
import 'news_store.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = sl<NewsStore>();
    final articleFuture = store.getArticles();
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      floatingActionButton: Observer(
        builder: (context) => Visibility(
          visible: store.shouldShowFavIcon,
          child: FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const FavouriteArticles(),
              ),
            ),
            child: const Icon(
              Icons.favorite_border_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Observer(
        builder: (context) {
          switch (articleFuture.status) {
            case FutureStatus.pending:
              return const Center(child: CircularProgressIndicator());
            case FutureStatus.rejected:
              return const Center(child: Placeholder());
            case FutureStatus.fulfilled:
              final response = articleFuture.value;
              if (response?.articles == null) {
                return const Center(child: Placeholder());
              }
              final articles = response!.articles!;
              return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onDoubleTap: () => store.favArticles.add(articles[index]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          children: [
                            if (articles[index].imgUrl != null)
                              CachedNetworkImage(
                                imageUrl: articles[index].imgUrl!,
                                fit: BoxFit.cover,
                                errorWidget: (_, __, ___) => const Center(
                                  child: Text(
                                    'Image Failed to Load!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              )
                            else
                              const Center(
                                child: Text(
                                  'No Image Found!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            Positioned.fill(
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: const [0.4, 0.9],
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        articles[index].heading ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      articles[index].date,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
