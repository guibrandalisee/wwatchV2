import 'package:wwatch/Shared/models/cast_and_crew_model.dart';
import 'package:wwatch/Shared/models/movie_images_model.dart';
import 'package:wwatch/Shared/models/movie_video_model.dart';
import 'package:wwatch/Shared/models/movie_watch_providers_model.dart';
import 'package:wwatch/Shared/models/tv_season_model.dart';

class Genre {
  final int id;
  final String name;
  Genre({
    required this.id,
    required this.name,
  });
}

//A simple version of a Movie or TV Show, only getting enough values to display the movie tile on Home Screen
class SimpleMovie {
  final num? rating;
  final List genreIds;
  final int id;
  final bool adult;
  final String? posterPath;
  final num popularity;
  final num voteAverage;
  final String originalLanguage;
  //Title works as name for TV Shows
  final String title;
  final String overview;
  //releaseDate works as first_air_date to TV Shows
  final String? releaseDate;
  final String? backdropPath;
  SimpleMovie({
    this.rating,
    required this.genreIds,
    required this.id,
    required this.adult,
    this.posterPath,
    required this.popularity,
    required this.voteAverage,
    required this.originalLanguage,
    required this.title,
    required this.overview,
    this.releaseDate,
    this.backdropPath,
  });
}

//A complete version of a Movie or TV Show, to display in depth info about it on Movie Screen
class CompleteMovie {
  CompleteMovie(
      {required this.genres,
      required this.id,
      required this.adult,
      this.posterPath,
      required this.popularity,
      required this.voteAverage,
      required this.voteCount,
      required this.originalLanguage,
      required this.title,
      required this.overview,
      this.releaseDate,
      this.backdropPath,
      this.budget,
      this.imdbId,
      required this.originalTitle,
      required this.productionCompanies,
      required this.productionCountries,
      required this.spokenLanguages,
      this.revenue,
      this.runtime,
      required this.launchStatus,
      this.tagline,
      this.images,
      this.videos,
      this.numberOfSeasons,
      this.numberOfEpisodes,
      this.seasons,
      this.recomendations,
      this.reviews,
      required this.credits,
      this.movieAvaliableWatchProviders,
      this.allWatchProviders,
      this.favorite,
      this.watchlist,
      this.rate,
      this.translations,
      this.secondaryLanguageContent});

  final List genres;
  final int id;
  final bool adult;
  final String? posterPath;
  final num popularity;
  final num voteAverage;
  final int voteCount;
  final String originalLanguage;
  final String title;
  final String overview;
  final String? releaseDate;
  final String? backdropPath;
  final int? budget;
  final String? imdbId;
  final String originalTitle;
  final List productionCompanies;
  final List productionCountries;
  final List spokenLanguages;
  final int? revenue;
  final int? runtime;
  final String launchStatus;
  final String? tagline;
  final List<MovieImage>? images;
  final List<MovieVideo>? videos;
  final int? numberOfSeasons;
  final int? numberOfEpisodes;
  final List<TvSeason>? seasons;
  final Map<String, dynamic>? recomendations;
  final Map<String, dynamic>? reviews;
  final Credits credits;
  final MovieAvaliableWatchProviders? movieAvaliableWatchProviders;
  final Map<String, dynamic>? allWatchProviders;
  bool? favorite;
  bool? watchlist;
  num? rate;
  final List<ContentTranslation>? translations;
  final TranslationData? secondaryLanguageContent;
}

class ContentTranslation {
  final String iso_3166_1;
  final String iso_639_1;
  final String name;
  final TranslationData data;
  ContentTranslation({
    required this.iso_3166_1,
    required this.iso_639_1,
    required this.name,
    required this.data,
  });
}

class TranslationData {
  final String? title;
  final String overview;
  final String homepage;
  final String? tagline;
  TranslationData(
      {required this.homepage,
      required this.overview,
      this.title,
      this.tagline});
}
