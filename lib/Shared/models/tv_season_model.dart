class TvSeason {
  List<Episode>? episodes;
  String name;
  String overview;
  String? idstr;
  int id;
  String? posterPath;
  int seasonNumber;
  int? episodeCount;
  String? airDate;
  TvSeason({
    this.episodes,
    required this.name,
    required this.overview,
    this.idstr,
    required this.id,
    this.posterPath,
    required this.seasonNumber,
    this.episodeCount,
    this.airDate,
  });
}

class Episode {
  String airDate;
  int episodeNumber;
  int id;
  String name;
  String overview;
  String productionCode;
  int seasonNumber;
  String? stillPath;
  double voteAverage;
  int voteCount;
  Episode({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });
}
