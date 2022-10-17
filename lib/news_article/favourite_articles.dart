import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../core/service_locator.dart';
import 'news_store.dart';

class FavouriteArticles extends StatelessObserverWidget {
  const FavouriteArticles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = sl<NewsStore>();
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Favourites'),
      ),
      body: store.favArticles.isEmpty
          ? const Center(
              child: Text(
                'Go ahead and favourite some articles!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            )
          : ListView.builder(
              itemCount: store.favArticles.length,
              itemBuilder: (context, index) => GestureDetector(
                behavior: HitTestBehavior.translucent,
                onDoubleTap: () =>
                    store.favArticles.remove(store.favArticles[index]),
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
                          if (store.favArticles[index].imgUrl != null)
                            CachedNetworkImage(
                              imageUrl: store.favArticles[index].imgUrl!,
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
                                      store.favArticles[index].heading ?? '',
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
                                    store.favArticles[index].date,
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
            ),
    );
  }
}
