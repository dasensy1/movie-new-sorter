import '../models/film.dart';

class FilmsService {
  final List<Film> _films = [
    const Film(
      id: 1,
      title: 'The Shawshank Redemption',
      genre: 'Drama',
      rating: 9.3,
      year: 1994,
      posterUrl: 'https://via.placeholder.com/300x450?text=Shawshank',
    ),
    const Film(
      id: 2,
      title: 'The Godfather',
      genre: 'Crime',
      rating: 9.2,
      year: 1972,
      posterUrl: 'https://via.placeholder.com/300x450?text=Godfather',
    ),
    const Film(
      id: 3,
      title: 'The Dark Knight',
      genre: 'Action',
      rating: 9.0,
      year: 2008,
      posterUrl: 'https://via.placeholder.com/300x450?text=Dark+Knight',
    ),
    const Film(
      id: 4,
      title: 'Pulp Fiction',
      genre: 'Crime',
      rating: 8.9,
      year: 1994,
      posterUrl: 'https://via.placeholder.com/300x450?text=Pulp+Fiction',
    ),
    const Film(
      id: 5,
      title: 'Forrest Gump',
      genre: 'Drama',
      rating: 8.8,
      year: 1994,
      posterUrl: 'https://via.placeholder.com/300x450?text=Forrest+Gump',
    ),
    const Film(
      id: 6,
      title: 'Inception',
      genre: 'Sci-Fi',
      rating: 8.8,
      year: 2010,
      posterUrl: 'https://via.placeholder.com/300x450?text=Inception',
    ),
    const Film(
      id: 7,
      title: 'The Matrix',
      genre: 'Sci-Fi',
      rating: 8.7,
      year: 1999,
      posterUrl: 'https://via.placeholder.com/300x450?text=Matrix',
    ),
    const Film(
      id: 8,
      title: 'Goodfellas',
      genre: 'Crime',
      rating: 8.7,
      year: 1990,
      posterUrl: 'https://via.placeholder.com/300x450?text=Goodfellas',
    ),
    const Film(
      id: 9,
      title: 'Interstellar',
      genre: 'Sci-Fi',
      rating: 8.6,
      year: 2014,
      posterUrl: 'https://via.placeholder.com/300x450?text=Interstellar',
    ),
    const Film(
      id: 10,
      title: 'The Silence of the Lambs',
      genre: 'Thriller',
      rating: 8.6,
      year: 1991,
      posterUrl: 'https://via.placeholder.com/300x450?text=Silence',
    ),
  ];

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
