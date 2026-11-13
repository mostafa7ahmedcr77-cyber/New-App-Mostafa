import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/features/data/models/news_model.dart';

class NewsService {
  static const String apiKey = '1106745574be4c7aa3e91b8f4ca41a58';

  Future<List<NewsModel>> getNews({String category = 'general'}) async {
    final url = Uri.https('newsapi.org', '/v2/top-headlines', {
      'country': 'us',
      'category': category,
    });

    final response = await http.get(url, headers: {'X-Api-Key': apiKey});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List articles = data['articles'];

      return articles.map((article) {
        return NewsModel.fromJson(article);
      }).toList();
    } else {
      throw Exception('Failed to load news: ${response.statusCode}');
    }
  }

  Future<List<NewsModel>> searchNews(String query) async {
    final url = Uri.https('newsapi.org', '/v2/everything', {
      'q': query,
      'sortBy': 'publishedAt',
      'language': 'en',
    });

    final response = await http.get(url, headers: {'X-Api-Key': apiKey});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List articles = data['articles'];

      return articles.map((article) {
        return NewsModel.fromJson(article);
      }).toList();
    } else {
      throw Exception('Failed to search news: ${response.statusCode}');
    }
  }
}
