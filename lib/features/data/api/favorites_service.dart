import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news_app/features/data/models/news_model.dart';

class FavoritesService {
  static final ValueNotifier<List<NewsModel>> favorites = ValueNotifier([]);

  static const String favoritesKey = 'favorite_news';

  static Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final savedNews = prefs.getStringList(favoritesKey) ?? [];

    favorites.value = savedNews.map((item) {
      return NewsModel.fromJson(jsonDecode(item));
    }).toList();
  }

  static bool isFavorite(NewsModel news) {
    return favorites.value.any((item) => item.articleUrl == news.articleUrl);
  }

  static Future<void> toggleFavorite(NewsModel news) async {
    final currentFavorites = [...favorites.value];

    if (isFavorite(news)) {
      currentFavorites.removeWhere(
        (item) => item.articleUrl == news.articleUrl,
      );
    } else {
      currentFavorites.add(news);
    }

    favorites.value = currentFavorites;

    final prefs = await SharedPreferences.getInstance();

    final savedNews = currentFavorites.map((item) {
      return jsonEncode({
        'title': item.title,
        'description': item.description,
        'urlToImage': item.imageUrl,
        'author': item.author,
        'publishedAt': item.publishedAt,
        'url': item.articleUrl,
      });
    }).toList();

    await prefs.setStringList(favoritesKey, savedNews);
  }
}
