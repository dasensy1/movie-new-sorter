import 'package:flutter/foundation.dart';
import '../models/film.dart';
import '../services/films_service.dart';
import '../utils/sort_type.dart';
import '../utils/view_mode.dart';

class FilmsViewModel extends ChangeNotifier {
  final FilmsService _filmsService;

  List<Film> _films = [];
  List<Film> _sortedFilms = [];
  SortType _currentSortType = SortType.rating;
  ViewMode _viewMode = ViewMode.vertical;
  int _displayLimit = 20;
  bool _isLoading = false;
  String? _error;

  FilmsViewModel(this._filmsService);

  List<Film> get films => _sortedFilms.take(_displayLimit).toList();
  SortType get currentSortType => _currentSortType;
  ViewMode get viewMode => _viewMode;
  int get displayLimit => _displayLimit;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasMore => _displayLimit < _sortedFilms.length;

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

  void setViewMode(ViewMode mode) {
    if (_viewMode != mode) {
      _viewMode = mode;
      notifyListeners();
    }
  }

  void setDisplayLimit(int limit) {
    if (_displayLimit != limit) {
      _displayLimit = limit;
      notifyListeners();
    }
  }

  void loadMore() {
    if (_displayLimit < _sortedFilms.length) {
      _displayLimit = (_displayLimit + 20).clamp(0, _sortedFilms.length);
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
      case SortType.smart:
        _sortedFilms.sort((a, b) {
          final currentYear = DateTime.now().year;
          final aAge = currentYear - a.year;
          final bAge = currentYear - b.year;
          final aRecencyScore = 1.0 / (aAge + 1);
          final bRecencyScore = 1.0 / (bAge + 1);
          final aCombinedScore = (a.rating * 0.7) + (aRecencyScore * 10 * 0.3);
          final bCombinedScore = (b.rating * 0.7) + (bRecencyScore * 10 * 0.3);
          return bCombinedScore.compareTo(aCombinedScore);
        });
        break;
    }
    _displayLimit = 20;
  }
}
