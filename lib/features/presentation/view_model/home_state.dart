import 'package:news_app/features/data/models/news_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<NewsModel> news;
  final String selectedCategory;

  HomeSuccess({required this.news, required this.selectedCategory});
}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
