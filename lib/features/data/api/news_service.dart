import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/features/data/models/news_model.dart';

class NewsService {
  Future<List<NewsModel>> getNews() async {
    const String apiKey = '1106745574be4c7aa3e91b8f4ca41a58';

    final url = Uri.parse('https://newsapi.org/v2/top-headlines?country=us');

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
}
