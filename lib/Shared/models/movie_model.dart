class Movie {
  final List genreIds;
  final int id;
  final String? posterPath;
  final double popularity;
  final double voteAverage;
  final String originalLanguage;
  final String title;
  final String overview;
  final String releaseDate;
  final String? backdropPath;
  Movie({
    required this.genreIds,
    required this.id,
    this.posterPath,
    required this.popularity,
    required this.voteAverage,
    required this.originalLanguage,
    required this.title,
    required this.overview,
    required this.releaseDate,
    this.backdropPath,
  });
}
