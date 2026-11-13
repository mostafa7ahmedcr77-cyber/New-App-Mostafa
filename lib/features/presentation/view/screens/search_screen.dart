import 'package:flutter/material.dart';
import 'package:news_app/features/data/api/news_service.dart';
import 'package:news_app/features/data/models/news_model.dart';
import 'package:news_app/features/presentation/view/widgets/news_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final NewsService newsService = NewsService();
  final TextEditingController searchController = TextEditingController();

  List<NewsModel> searchResults = [];
  bool isLoading = false;
  String? errorMessage;
  bool hasSearched = false;

  Future<void> searchNews() async {
    final query = searchController.text.trim();

    if (query.isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
      hasSearched = true;
    });

    try {
      final results = await newsService.searchNews(query);

      if (!mounted) return;

      setState(() {
        searchResults = results;
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        errorMessage = error.toString();
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080D19),
      appBar: AppBar(
        title: const Text(
          'Search News',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF080D19),
        iconTheme: const IconThemeData(color: Color(0xFF60A5FA)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              style: const TextStyle(color: Colors.white),
              cursorColor: const Color(0xFF60A5FA),
              onSubmitted: (_) => searchNews(),
              decoration: InputDecoration(
                hintText: 'Search for news...',
                hintStyle: const TextStyle(color: Color(0xFF8292AE)),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF60A5FA)),
                suffixIcon: IconButton(
                  onPressed: searchNews,
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF60A5FA),
                  ),
                ),
                filled: true,
                fillColor: const Color(0xFF101B30),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Color(0xFF1C3152)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Color(0xFF1C3152)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Color(0xFF2563EB),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF60A5FA)),
                  )
                : errorMessage != null
                ? Center(
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.redAccent),
                      textAlign: TextAlign.center,
                    ),
                  )
                : !hasSearched
                ? const Center(
                    child: Text(
                      'Search for any news',
                      style: TextStyle(color: Color(0xFF9BAAC5), fontSize: 16),
                    ),
                  )
                : searchResults.isEmpty
                ? const Center(
                    child: Text(
                      'No results found',
                      style: TextStyle(color: Color(0xFF9BAAC5)),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      return NewsCard(news: searchResults[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
