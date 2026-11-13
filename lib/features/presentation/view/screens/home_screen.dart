import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/presentation/view/screens/favorites_screen.dart';
import 'package:news_app/features/presentation/view/screens/search_screen.dart';
import 'package:news_app/features/presentation/view/widgets/news_card.dart';
import 'package:news_app/features/presentation/view_model/home_cubit.dart';
import 'package:news_app/features/presentation/view_model/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Map<String, String>> categories = [
    {'name': 'General', 'value': 'general'},
    {'name': 'Technology', 'value': 'technology'},
    {'name': 'Sports', 'value': 'sports'},
    {'name': 'Business', 'value': 'business'},
    {'name': 'Entertainment', 'value': 'entertainment'},
    {'name': 'Health', 'value': 'health'},
    {'name': 'Science', 'value': 'science'},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getNews(),
      child: Scaffold(
        backgroundColor: const Color(0xFF080D19),
        appBar: AppBar(
          title: const Text(
            'News App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 23,
            ),
          ),
          backgroundColor: const Color(0xFF080D19),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoritesScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.redAccent,
                size: 25,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              icon: const Icon(
                Icons.search,
                color: Color(0xFF60A5FA),
                size: 28,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 60,
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  final selectedCategory = context
                      .read<HomeCubit>()
                      .selectedCategory;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = selectedCategory == category['value'];

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(category['name']!),
                          selected: isSelected,
                          selectedColor: const Color(0xFF2563EB),
                          backgroundColor: const Color(0xFF101B30),
                          side: BorderSide.none,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF9BAAC5),
                            fontWeight: FontWeight.w600,
                          ),
                          onSelected: (_) {
                            context.read<HomeCubit>().getNews(
                              category: category['value']!,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading || state is HomeInitial) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF60A5FA),
                      ),
                    );
                  }

                  if (state is HomeError) {
                    return Center(
                      child: Text(
                        'Error: ${state.message}',
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  if (state is HomeSuccess) {
                    if (state.news.isEmpty) {
                      return const Center(
                        child: Text(
                          'No news available',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.news.length,
                      itemBuilder: (context, index) {
                        return NewsCard(news: state.news[index]);
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
