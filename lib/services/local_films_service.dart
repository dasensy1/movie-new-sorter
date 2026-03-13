import '../data/films_database.dart';
import '../models/film.dart';

class LocalFilmsService {
  final List<Film> _films = FilmsDatabase.films
      .map((data) => Film(
            id: data['id'] as int,
            title: data['title'] as String,
            genre: data['genre'] as String,
            rating: (data['rating'] as num).toDouble(),
            year: data['year'] as int,
            posterUrl: data['posterUrl'] as String,
          ))
      .toList();

  Future<List<Film>> getAllFilms() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _films;
  }

  Future<Film?> getFilmById(int id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _films.firstWhere((film) => film.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<List<Film>> searchFilms(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (query.isEmpty) {
      return _films;
    }
    final lowerQuery = query.toLowerCase();
    return _films
        .where((film) =>
            film.title.toLowerCase().contains(lowerQuery) ||
            film.genre.toLowerCase().contains(lowerQuery))
        .toList();
  }

  Future<List<Film>> getFilmsByGenre(String genre) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _films.where((film) => film.genre == genre).toList();
  }

  Future<List<String>> getAllGenres() async {
    final genres = _films.map((film) => film.genre).toSet().toList();
    genres.sort();
    return genres;
  }
}
