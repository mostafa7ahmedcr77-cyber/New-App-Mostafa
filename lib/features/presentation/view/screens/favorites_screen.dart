import 'package:flutter/material.dart';
import 'package:news_app/features/data/api/favorites_service.dart';
import 'package:news_app/features/data/models/news_model.dart';
import 'package:news_app/features/presentation/view/widgets/news_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080D19),
      appBar: AppBar(
        title: const Text(
          'My Favorites',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF080D19),
        iconTheme: const IconThemeData(color: Color(0xFF60A5FA)),
      ),
      body: ValueListenableBuilder<List<NewsModel>>(
        valueListenable: FavoritesService.favorites,
        builder: (context, favorites, child) {
          if (favorites.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: Color(0xFF60A5FA),
                    size: 65,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No favorite news yet',
                    style: TextStyle(color: Color(0xFF9BAAC5), fontSize: 17),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              return NewsCard(news: favorites[index]);
            },
          );
        },
      ),
    );
  }
}
