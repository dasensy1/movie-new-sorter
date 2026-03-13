import 'package:flutter/foundation.dart';
import '../models/film.dart';
import '../services/films_service.dart';
import '../utils/sort_type.dart';

class FilmsViewModel extends ChangeNotifier {
  final FilmsService _filmsService;

  List<Film> _films = [];
  List<Film> _sortedFilms = [];
  SortType _currentSortType = SortType.rating;
  bool _isLoading = false;
  String? _error;

  FilmsViewModel(this._filmsService);

  List<Film> get films => _sortedFilms;
  SortType get currentSortType => _currentSortType;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadFilms() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _films = await _filmsService.getFilms();
      _applySorting();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSortType(SortType sortType) {
    if (_currentSortType != sortType) {
      _currentSortType = sortType;
      _applySorting();
      notifyListeners();
    }
  }

  void _applySorting() {
    _sortedFilms = List.from(_films);
    switch (_currentSortType) {
      case SortType.rating:
        _sortedFilms.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case SortType.year:
        _sortedFilms.sort((a, b) => b.year.compareTo(a.year));
        break;
      case SortType.title:
        _sortedFilms.sort((a, b) => a.title.compareTo(b.title));
        break;
    }
  }
}
