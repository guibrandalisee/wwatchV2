class SimpleMovie {
  final List genreIds;
  final int id;
  final bool adult;
  final String? posterPath;
  final double popularity;
  final double voteAverage;
  final String originalLanguage;
  final String title;
  final String overview;
  final String releaseDate;
  final String? backdropPath;
  SimpleMovie({
    required this.genreIds,
    required this.id,
    required this.adult,
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

class CompleteMovie {
  CompleteMovie({
    required this.genres,
    required this.id,
    required this.adult,
    this.posterPath,
    required this.popularity,
    required this.voteAverage,
    required this.originalLanguage,
    required this.title,
    required this.overview,
    required this.releaseDate,
    this.backdropPath,
    required this.budget,
    this.imdbId,
    required this.originalTitle,
    required this.productionCompanies,
    required this.productionCountries,
    required this.spokenLanguages,
    required this.revenue,
    this.runtime,
    required this.launchStatus,
    this.tagline,
    this.images,
    this.videos,
    this.cast,
    this.recomendations,
    this.reviews,
    this.translations,
    this.watchProviders,
  });
  final Map<String, dynamic> genres;
  final int id;
  final bool adult;
  final String? posterPath;
  final double popularity;
  final double voteAverage;
  final String originalLanguage;
  final String title;
  final String overview;
  final String releaseDate;
  final String? backdropPath;
  final int budget;
  final String? imdbId;
  final String originalTitle;
  final Map<String, dynamic> productionCompanies;
  final Map<String, dynamic> productionCountries;
  final Map<String, dynamic> spokenLanguages;
  final int revenue;
  final int? runtime;
  final String launchStatus;
  final String? tagline;
  //TODO Create a model to images, videos, watch providers and reviews;
  final Map<String, dynamic>? images;
  final Map<String, dynamic>? videos;
  final Map<String, dynamic>? watchProviders;
  final Map<String, dynamic>? recomendations;
  final Map<String, dynamic>? translations;
  final Map<String, dynamic>? reviews;
  final Map<String, dynamic>? cast;
}
