import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/data/api/news_service.dart';
import 'package:news_app/features/presentation/view_model/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final NewsService newsService = NewsService();

  String selectedCategory = 'general';

  HomeCubit() : super(HomeInitial());

  Future<void> getNews({String category = 'general'}) async {
    selectedCategory = category;

    emit(HomeLoading());

    try {
      final news = await newsService.getNews(category: category);

      emit(HomeSuccess(news: news, selectedCategory: category));
    } catch (error) {
      emit(HomeError(message: error.toString()));
    }
  }
}
