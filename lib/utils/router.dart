import 'package:go_router/go_router.dart';
import '../views/home_screen.dart';
import '../views/film_detail_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'film/:id',
          builder: (context, state) {
            final filmId = int.parse(state.pathParameters['id']!);
            return FilmDetailScreen(filmId: filmId);
          },
        ),
      ],
    ),
  ],
);
