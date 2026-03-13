import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/film.dart';
import '../config/api_config.dart';

class TmdbApiService {
  final String _baseUrl = ApiConfig.tmdbBaseUrl;
  final String _apiKey = ApiConfig.tmdbApiKey;
  final String _imageBaseUrl = ApiConfig.imageBaseUrl;

  Future<List<Film>> getPopularMovies() async {
    final url = Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey&language=en-US&page=1');
    
    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        
        return results.take(20).map((movie) {
          return Film(
            id: movie['id'],
            title: movie['title'] ?? 'Unknown',
            genre: movie['genre_ids']?.isNotEmpty == true 
                ? _getGenreName(movie['genre_ids'].first) 
                : 'Unknown',
            rating: movie['vote_average']?.toDouble() ?? 0.0,
            year: movie['release_date']?.substring(0, 4) != null 
                ? int.tryParse(movie['release_date'].substring(0, 4)) ?? 2000
                : 2000,
            posterUrl: movie['poster_path'] != null 
                ? '$_imageBaseUrl${movie['poster_path']}'
                : 'https://via.placeholder.com/300x450?text=No+Image',
          );
        }).toList();
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<List<Film>> getTopRatedMovies() async {
    final url = Uri.parse('$_baseUrl/movie/top_rated?api_key=$_apiKey&language=en-US&page=1');
    
    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        
        return results.take(20).map((movie) {
          return Film(
            id: movie['id'],
            title: movie['title'] ?? 'Unknown',
            genre: movie['genre_ids']?.isNotEmpty == true 
                ? _getGenreName(movie['genre_ids'].first) 
                : 'Unknown',
            rating: movie['vote_average']?.toDouble() ?? 0.0,
            year: movie['release_date']?.substring(0, 4) != null 
                ? int.tryParse(movie['release_date'].substring(0, 4)) ?? 2000
                : 2000,
            posterUrl: movie['poster_path'] != null 
                ? '$_imageBaseUrl${movie['poster_path']}'
                : 'https://via.placeholder.com/300x450?text=No+Image',
          );
        }).toList();
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<List<Film>> searchMovies(String query) async {
    final url = Uri.parse('$_baseUrl/search/movie?api_key=$_apiKey&query=${Uri.encodeComponent(query)}&page=1');
    
    try {
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        
        return results.take(20).map((movie) {
          return Film(
            id: movie['id'],
            title: movie['title'] ?? 'Unknown',
            genre: movie['genre_ids']?.isNotEmpty == true 
                ? _getGenreName(movie['genre_ids'].first) 
                : 'Unknown',
            rating: movie['vote_average']?.toDouble() ?? 0.0,
            year: movie['release_date']?.substring(0, 4) != null 
                ? int.tryParse(movie['release_date'].substring(0, 4)) ?? 2000
                : 2000,
            posterUrl: movie['poster_path'] != null 
                ? '$_imageBaseUrl${movie['poster_path']}'
                : 'https://via.placeholder.com/300x450?text=No+Image',
          );
        }).toList();
      } else {
        throw Exception('Failed to search movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  String _getGenreName(int genreId) {
    const genres = {
      28: 'Action',
      12: 'Adventure',
      16: 'Animation',
      35: 'Comedy',
      80: 'Crime',
      99: 'Documentary',
      18: 'Drama',
      10751: 'Family',
      14: 'Fantasy',
      36: 'History',
      27: 'Horror',
      10402: 'Music',
      9648: 'Mystery',
      10749: 'Romance',
      878: 'Sci-Fi',
      10770: 'TV Movie',
      53: 'Thriller',
      10752: 'War',
      37: 'Western',
    };
    return genres[genreId] ?? 'Unknown';
  }
}
