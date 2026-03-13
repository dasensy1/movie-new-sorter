import '../models/film.dart';
import 'tmdb_api_service.dart';

class FilmsService {
  final TmdbApiService _tmdbApiService = TmdbApiService();

  final List<Film> _fallbackFilms = [
    const Film(
      id: 1,
      title: 'The Shawshank Redemption',
      genre: 'Drama',
      rating: 9.3,
      year: 1994,
      posterUrl: 'https://image.tmdb.org/t/p/w300/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg',
    ),
    const Film(
      id: 2,
      title: 'The Godfather',
      genre: 'Crime',
      rating: 9.2,
      year: 1972,
      posterUrl: 'https://image.tmdb.org/t/p/w300/3bhkrj58Vtu7enYsRolD1fZdja1.jpg',
    ),
    const Film(
      id: 3,
      title: 'The Dark Knight',
      genre: 'Action',
      rating: 9.0,
      year: 2008,
      posterUrl: 'https://image.tmdb.org/t/p/w300/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
    ),
    const Film(
      id: 4,
      title: 'Pulp Fiction',
      genre: 'Crime',
      rating: 8.9,
      year: 1994,
      posterUrl: 'https://image.tmdb.org/t/p/w300/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg',
    ),
    const Film(
      id: 5,
      title: 'Forrest Gump',
      genre: 'Drama',
      rating: 8.8,
      year: 1994,
      posterUrl: 'https://image.tmdb.org/t/p/w300/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg',
    ),
    const Film(
      id: 6,
      title: 'Inception',
      genre: 'Sci-Fi',
      rating: 8.8,
      year: 2010,
      posterUrl: 'https://image.tmdb.org/t/p/w300/9gk7admal4ZLcnwnCSNPYtbnQT.jpg',
    ),
    const Film(
      id: 7,
      title: 'The Matrix',
      genre: 'Sci-Fi',
      rating: 8.7,
      year: 1999,
      posterUrl: 'https://image.tmdb.org/t/p/w300/f89Z4L8ZN8Z8Z8Z8Z8Z8Z8Z8Z8Z.jpg',
    ),
    const Film(
      id: 8,
      title: 'Goodfellas',
      genre: 'Crime',
      rating: 8.7,
      year: 1990,
      posterUrl: 'https://image.tmdb.org/t/p/w300/aKuFiU82s5ISJpGZp7YkIr3kCUd.jpg',
    ),
    const Film(
      id: 9,
      title: 'Interstellar',
      genre: 'Sci-Fi',
      rating: 8.6,
      year: 2014,
      posterUrl: 'https://image.tmdb.org/t/p/w300/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
    ),
    const Film(
      id: 10,
      title: 'The Silence of the Lambs',
      genre: 'Thriller',
      rating: 8.6,
      year: 1991,
      posterUrl: 'https://image.tmdb.org/t/p/w300/uS9m8OBk1A8eM9I042bx8XXpqAq.jpg',
    ),
  ];

  Future<List<Film>> getFilms() async {
    try {
      final films = await _tmdbApiService.getPopularMovies();
      if (films.isEmpty) {
        return _fallbackFilms;
      }
      return films;
    } catch (_) {
      return _fallbackFilms;
    }
  }

  Future<Film?> getFilmById(int id) async {
    try {
      final films = await getFilms();
      return films.firstWhere((film) => film.id == id, orElse: () => _fallbackFilms.first);
    } catch (_) {
      return _fallbackFilms.first;
    }
  }

  Future<List<Film>> searchFilms(String query) async {
    try {
      final films = await _tmdbApiService.searchMovies(query);
      if (films.isEmpty) {
        return _fallbackFilms
            .where((film) =>
                film.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      return films;
    } catch (_) {
      return _fallbackFilms
          .where((film) =>
              film.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
