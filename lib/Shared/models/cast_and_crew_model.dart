class Cast {
  bool adult;
  int? gender;
  int id;
  String? knownForFepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  int? castId;
  String? character;
  String creditId;
  int order;
  Cast({
    required this.adult,
    this.gender,
    required this.id,
    this.knownForFepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    required this.order,
  });
}

class Crew {
  bool adult;
  int? gender;
  int id;
  String? knownForFepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  String? creditId;
  String department;
  String job;

  Crew({
    required this.adult,
    this.gender,
    required this.id,
    this.knownForFepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    this.creditId,
    required this.department,
    required this.job,
  });
}

class Credits {
  List<Cast>? cast = [];
  List<Crew>? crew = [];
  Credits({
    this.cast,
    this.crew,
  });
}

class Person {
  String? birthday;
  String? knownForDepartment;
  String? deathDay;
  int id;
  String name;
  int gender;
  String? biography;
  double popularity;
  String? placeOfBirth;
  String? profilePath;
  bool? adult;
  String? homePage;
  List<PersonImage>? images;
  PersonExternalIds? externalIds;
  List<PersonMovieCreditCast>? personMovieCreditCast;
  List<PersonTVCreditCast>? personTVCreditCast;
  Person(
      {this.birthday,
      this.knownForDepartment,
      this.deathDay,
      required this.id,
      required this.name,
      required this.gender,
      this.biography,
      required this.popularity,
      this.placeOfBirth,
      this.profilePath,
      this.adult,
      this.homePage,
      this.images,
      this.externalIds,
      this.personMovieCreditCast,
      this.personTVCreditCast});
}

class PersonImage {
  num? aspectRatio;
  String filePath;
  int height;
  num voteAverage;
  num voteCount;
  int width;

  PersonImage({
    this.aspectRatio,
    required this.filePath,
    required this.height,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });
}

class PersonExternalIds {
  String? imdbId;
  String? facebookId;
  String? freebaseMid;
  String? freebaseId;
  int? tvrageId;
  String? twitterId;
  String? instagramId;
  int id;
  PersonExternalIds({
    this.imdbId,
    this.facebookId,
    this.freebaseMid,
    this.freebaseId,
    this.tvrageId,
    this.twitterId,
    this.instagramId,
    required this.id,
  });
}

class PersonMovieCreditCast {
  String character;
  String creditId;
  String? releaseDate;
  int voteCount;
  double voteAverage;
  String title;
  int id;
  String? backdropPath;
  String? posterPath;
  String overview;
  PersonMovieCreditCast({
    required this.character,
    required this.creditId,
    this.releaseDate,
    required this.voteCount,
    required this.voteAverage,
    required this.title,
    required this.id,
    this.backdropPath,
    this.posterPath,
    required this.overview,
  });
}

class PersonTVCreditCast {
  String creditId;
  int id;
  String character;
  String name;
  String? posterPath;
  int voteCount;
  double voteAverage;
  double popularity;
  int episodeCount;
  String? firstAirDate;
  String? backdropPath;
  String overview;
  PersonTVCreditCast({
    required this.creditId,
    required this.id,
    required this.character,
    required this.name,
    this.posterPath,
    required this.voteCount,
    required this.voteAverage,
    required this.popularity,
    required this.episodeCount,
    this.firstAirDate,
    this.backdropPath,
    required this.overview,
  });
}
