import 'package:flutter/material.dart';
import 'package:news_app/core/routes/app_routes.dart';
import 'package:news_app/features/data/api/favorites_service.dart';
import 'package:news_app/features/presentation/view/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FavoritesService.loadFavorites();

  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF080D19),
        primaryColor: const Color(0xFF2563EB),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF2563EB),
          secondary: Color(0xFF60A5FA),
          surface: Color(0xFF101B30),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF080D19),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: const CardThemeData(color: Color(0xFF101B30), elevation: 2),
      ),
      initialRoute: AppRoutes.home,
      routes: {AppRoutes.home: (context) => const HomeScreen()},
    );
  }
}
