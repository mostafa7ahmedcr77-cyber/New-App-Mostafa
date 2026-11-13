import 'package:flutter/material.dart';
import 'package:news_app/features/data/models/news_model.dart';
import 'package:news_app/features/data/api/favorites_service.dart';
import 'package:news_app/features/presentation/view/screens/details_screen.dart';

class NewsCard extends StatelessWidget {
  final NewsModel news;

  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF101B30),
      margin: const EdgeInsets.only(bottom: 18),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF1C3152), width: 0.7),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsScreen(news: news)),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.imageUrl.isNotEmpty)
              Image.network(
                news.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: const Color(0xFF172B4D),
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Color(0xFF60A5FA),
                        size: 40,
                      ),
                    ),
                  );
                },
              ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    news.description.isNotEmpty
                        ? news.description
                        : 'No description available',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF9BAAC5),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        color: Color(0xFF60A5FA),
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          news.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF60A5FA),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ValueListenableBuilder<List<NewsModel>>(
                        valueListenable: FavoritesService.favorites,
                        builder: (context, favorites, child) {
                          final isFavorite = FavoritesService.isFavorite(news);

                          return IconButton(
                            onPressed: () {
                              FavoritesService.toggleFavorite(news);
                            },
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite
                                  ? Colors.redAccent
                                  : const Color(0xFF60A5FA),
                            ),
                          );
                        },
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF60A5FA),
                        size: 14,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
