class NewsModel {
  final String title;
  final String description;
  final String imageUrl;
  final String author;
  final String publishedAt;
  final String articleUrl;

  NewsModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.author,
    required this.publishedAt,
    required this.articleUrl,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      author: json['author'] ?? 'Unknown',
      publishedAt: json['publishedAt'] ?? '',
      articleUrl: json['url'] ?? '',
    );
  }
}
