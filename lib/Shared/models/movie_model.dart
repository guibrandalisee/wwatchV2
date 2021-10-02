import 'package:wwatch/Shared/models/movie_images_model.dart';
import 'package:wwatch/Shared/models/movie_video_model.dart';
import 'package:wwatch/Shared/models/movie_watch_providers_model.dart';

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
  final String? releaseDate;
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
    this.watchProviders,
  });
  final List genres;
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
  final List productionCompanies;
  final List productionCountries;
  final List spokenLanguages;
  final int revenue;
  final int? runtime;
  final String launchStatus;
  final String? tagline;
  final List<MovieImage>? images;
  final List<MovieVideo>? videos;
  //TODO try to speak with TMDB to get direct link to movies in the Watch Providers;
  final List<MovieWatchProvider>? watchProviders;
  final Map<String, dynamic>? recomendations;
  final Map<String, dynamic>? reviews;
  final Map<String, dynamic>? cast;
}
