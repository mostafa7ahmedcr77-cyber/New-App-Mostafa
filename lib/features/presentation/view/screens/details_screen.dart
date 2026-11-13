import 'package:flutter/material.dart';
import 'package:news_app/features/data/models/news_model.dart';

class DetailsScreen extends StatelessWidget {
  final NewsModel news;

  const DetailsScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080D19),
      appBar: AppBar(
        title: const Text(
          'News Details',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF080D19),
        iconTheme: const IconThemeData(color: Color(0xFF60A5FA)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.imageUrl.isNotEmpty)
              Image.network(
                news.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 250,
                    color: const Color(0xFF172B4D),
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Color(0xFF60A5FA),
                        size: 45,
                      ),
                    ),
                  );
                },
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        color: Color(0xFF60A5FA),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          news.author,
                          style: const TextStyle(
                            color: Color(0xFF60A5FA),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Color(0xFF60A5FA),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          news.publishedAt,
                          style: const TextStyle(color: Color(0xFF9BAAC5)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF60A5FA),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    news.description.isNotEmpty
                        ? news.description
                        : 'No description available',
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.7,
                      color: Color(0xFFB8C5DA),
                    ),
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
