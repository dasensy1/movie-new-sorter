class Film {
  final int id;
  final String title;
  final String genre;
  final double rating;
  final int year;
  final String posterUrl;

  const Film({
    required this.id,
    required this.title,
    required this.genre,
    required this.rating,
    required this.year,
    required this.posterUrl,
  });

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      id: json['id'] as int,
      title: json['title'] as String,
      genre: json['genre'] as String,
      rating: (json['rating'] as num).toDouble(),
      year: json['year'] as int,
      posterUrl: json['posterUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'genre': genre,
      'rating': rating,
      'year': year,
      'posterUrl': posterUrl,
    };
  }
}
