import '../data/films_database.dart';
import '../models/film.dart';

class FilmsService {
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

  Future<List<Film>> getFilms() async {
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
}
