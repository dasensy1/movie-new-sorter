import 'package:go_router/go_router.dart';
import '../views/films_list_screen.dart';
import '../views/film_detail_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        final selectedFilmId = state.uri.queryParameters['filmId'];
        return FilmsListScreen(
          selectedFilmId: selectedFilmId != null ? int.parse(selectedFilmId) : null,
        );
      },
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
