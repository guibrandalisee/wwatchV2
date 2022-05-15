import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:wwatch/Shared/models/cast_and_crew_model.dart';
import 'package:wwatch/Shared/models/configuration_models.dart';
import 'package:wwatch/Shared/models/movie_images_model.dart';
import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/Shared/models/movie_video_model.dart';
import 'package:wwatch/Shared/models/tv_season_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/Shared/models/movie_watch_providers_model.dart';

part 'movie_store.g.dart';

enum ContentType { TVSHOW, MOVIE }

class MovieStore = _MovieStoreBase with _$MovieStore;
final SettingsStore settingsStore = GetIt.I<SettingsStore>();

abstract class _MovieStoreBase with Store {
  String apiKey = dotenv.env['API_KEY']!;
  String token = dotenv.env['TOKEN']!;

  //!Global Variables ----------------------------------------------------------------------------------

  @observable
  bool didChange = false;

  @observable
  int page = 1;

  @observable
  String language = settingsStore.language;

  //List of movies that will be displayed on front page
  @observable
  List<SimpleMovie> movies = [];

  @observable
  bool error = false;

  @observable
  int? totalPages;

  @observable
  CompleteMovie? movie;

  @observable
  String searchString = '';

  //Used to prevent new loaded content to use search string before the user click on search
  @observable
  String temporarySearchString = '';

  @observable
  bool empty = false;

  @observable
  List<SimpleMovie> recommendations = [];

  @observable
  TvSeason? season;

  @observable
  bool loadingSeason = false;

  @observable
  MovieAvaliableWatchProviders? movieAvaliableWatchProviders;

  @observable
  bool watchProviderError = false;

  //!---------------------------------------------------------------------------------------------------

  //*Default http request function
  @action
  Future fetchData(
      {required String path, required Map<String, dynamic> parameters}) async {
    var options = BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json;charset=utf-8'
      },
    );

    try {
      Dio dio = Dio(options);

      final response = await dio.get(path, queryParameters: parameters);
      return response;
    } on DioError catch (e) {
      print(e);
      error = true;
    }
  }

  String setUpGenres() {
    final SettingsStore _settingsStore = GetIt.I<SettingsStore>();
    String genres = '';
    if (_settingsStore.selectedMovieGenres.isNotEmpty &&
        _settingsStore.selectedContentType == 0) {
      for (var item in _settingsStore.selectedMovieGenres) {
        genres += item.toString() + ',';
      }
    } else if (_settingsStore.selectedTvShowGenres.isNotEmpty &&
        _settingsStore.selectedContentType == 1) {
      for (var item in _settingsStore.selectedTvShowGenres) {
        genres += item.toString() + ',';
      }
    }
    return genres;
  }

  Map<String, dynamic> setupFilters() {
    Map<String, dynamic> filters = {};

    if (settingsStore.runTimeActive &&
        settingsStore.runTimeMax != FilterDefaultValues.runTimeMaxValue)
      filters.addEntries({
        'with_runtime.lte': settingsStore.runTimeMax,
      }.entries);

    if (settingsStore.runTimeActive &&
        settingsStore.runTimeMin > FilterDefaultValues.runTimeMinValue) {
      filters.addEntries({
        'with_runtime.gte': settingsStore.runTimeMin,
      }.entries);
    } else if (settingsStore.runTimeActive) {
      filters.addEntries({
        'with_runtime.gte': 3,
      }.entries);
    }

    if (settingsStore.voteCountActive &&
        settingsStore.voteCountMax != FilterDefaultValues.voteCountMaxValue)
      filters.addEntries({
        'vote_count.lte': settingsStore.voteCountMax,
      }.entries);

    if (settingsStore.voteCountActive &&
        settingsStore.voteCountMin != FilterDefaultValues.voteCountMinValue)
      filters.addEntries({
        'vote_count.gte': settingsStore.voteCountMin,
      }.entries);

    if (settingsStore.voteAvgActive)
      filters.addEntries({
        'vote_average.gte': settingsStore.voteAvgActive
            ? settingsStore.voteAvgMin
            : FilterDefaultValues.voteAvgMinValue,
        'vote_average.lte': settingsStore.voteAvgActive
            ? settingsStore.voteAvgMax
            : FilterDefaultValues.voteAvgMaxValue
      }.entries);
    return filters;
  }

//*GetContent
  @action
  Future<void> getPopularContent() async {
    //?setup
    movies = [];
    empty = false;
    page = 1;
    Map<String, dynamic> parameters = {};
    String genres = '';
    //?-----

    //!Setup params
    genres = setUpGenres();
    parameters.addEntries({
      'language': language,
      'page': page,
      'sort_by': settingsStore.selectedSortBy,
      'include_adult': settingsStore.adultContent,
      'with_genres': genres,
    }.entries);

    Map<String, dynamic> filters = setupFilters();
    parameters.addAll(filters);

    if (genres != '' && genres.isNotEmpty)
      parameters.addEntries({'with_genres': genres}.entries);

    //!------------

    //*http request
    final response = settingsStore.selectedContentType == 0
        ? await fetchData(path: '/discover/movie', parameters: parameters)
        : await fetchData(path: '/discover/tv', parameters: parameters);
    error = false;

    try {
      totalPages = response.data['total_pages'];
      movies = response.data['results'].map<SimpleMovie>((e) {
        return SimpleMovie(
          genreIds: e['genre_ids'],
          id: e['id'],
          popularity: e['popularity'],
          voteAverage: e['vote_average'],
          originalLanguage: e['original_language'],
          title: e['title'] != null ? e['title'] : e['name'],
          overview: e['overview'],
          releaseDate: e['release_date'] != null
              ? e['release_date']
              : e['first_air_date'],
          backdropPath: e['backdrop_path'],
          posterPath: e['poster_path'],
          adult: e['adult'] != null ? e['adult'] : false,
        );
      }).toList();
      if (movies.length == 0) {
        empty = true;
      }
    } catch (e) {
      print(e);
      error = true;
    }
    //*----

    //?debug

    print("Include adult: ${settingsStore.adultContent}");
    print("Page: $page");
    print("Query: $searchString");
    print("Language: $language");
    print("Error: $error");
    print("Results: ${movies.length}");
    print("Sort By: ${settingsStore.selectedSortBy}");

    if (genres != '' && genres.isNotEmpty) print("Genres: $genres");
    if (settingsStore.runTimeActive)
      print(
          'with_runtime.lte: ${settingsStore.runTimeActive ? settingsStore.runTimeMax == FilterDefaultValues.runTimeMaxValue ? 99999 : settingsStore.runTimeMax : 99999}');
    if (settingsStore.runTimeActive)
      print(
          'with_runtime.gte: ${settingsStore.runTimeActive ? settingsStore.runTimeMin : 0}');
    if (settingsStore.voteCountActive)
      print(
          'vote_count.lte: ${settingsStore.voteCountActive ? settingsStore.voteCountMax == FilterDefaultValues.voteCountMaxValue ? 99999 : settingsStore.voteCountMax : 99999}');
    if (settingsStore.voteCountActive)
      print(
          'vote_count.gte: ${settingsStore.voteCountActive ? settingsStore.voteCountMin : 0}');
    if (settingsStore.voteAvgActive)
      print(
          'vote_average.lte: ${settingsStore.voteAvgActive ? settingsStore.voteAvgMax : FilterDefaultValues.voteAvgMaxValue}');
    if (settingsStore.voteAvgActive)
      print(
          'vote_average.gte: ${settingsStore.voteAvgActive ? settingsStore.voteAvgMin : 0}');

    //?-----
  }

//*GetMoreContent
  @action
  Future<void> getMoreContent() async {
//?setup
    Map<String, dynamic> parameters = {};
    page++;
    String genres = '';
//?-----

//!Setup Params
    if (searchString.isEmpty) {
      genres = setUpGenres();
      parameters.addEntries({
        'language': language,
        'page': page,
        'sort_by': settingsStore.selectedSortBy,
        'include_adult': settingsStore.adultContent,
        'with_genres': genres,
      }.entries);

      Map<String, dynamic> filters = setupFilters();
      parameters.addAll(filters);

      if (genres != '' && genres.isNotEmpty)
        parameters.addEntries({'with_genres': genres}.entries);
    } else {
      parameters = {
        'language': language,
        'page': page,
        'query': searchString,
        'include_adult': settingsStore.adultContent,
      };
    }
//!------------

//*http request

    final response;
    if (settingsStore.selectedContentType == 0 && searchString.isEmpty) {
      response =
          await fetchData(path: '/discover/movie', parameters: parameters);
    } else if (settingsStore.selectedContentType == 1 && searchString.isEmpty) {
      response = await fetchData(path: '/discover/tv', parameters: parameters);
    } else if (settingsStore.selectedContentType == 0) {
      response = await fetchData(path: '/search/movie', parameters: parameters);
    } else {
      response = await fetchData(path: '/search/tv', parameters: parameters);
    }
    error = false;
    try {
      final newMovies = response.data['results'].map<SimpleMovie>((e) {
        return SimpleMovie(
            genreIds: e['genre_ids'],
            id: e['id'],
            popularity: e['popularity'],
            voteAverage: e['vote_average'],
            originalLanguage: e['original_language'],
            title: e['title'] != null ? e['title'] : e['name'],
            overview: e['overview'],
            releaseDate: e['release_date'] != null
                ? e['release_date']
                : e['first_air_date'],
            backdropPath: e['backdrop_path'],
            posterPath: e['poster_path'],
            adult: e['adult'] != null ? e['adult'] : false);
      }).toList();
      movies.addAll(newMovies);
    } catch (e) {
      print(e);
      error = true;
    }

//?debug
    print(' ');
    print("More Results-----------------------");
    print(' ');

    print("Include adult: ${settingsStore.adultContent}");
    print("Page: $page");
    print("Query: $searchString");
    print("Language: $language");
    print("Error: $error");
    print("Results: ${movies.length}");
    print("Sort By: ${settingsStore.selectedSortBy}");

    if (genres != '' && genres.isNotEmpty) print("Genres: $genres");
    if (settingsStore.runTimeActive)
      print(
          'with_runtime.lte: ${settingsStore.runTimeActive ? settingsStore.runTimeMax == FilterDefaultValues.runTimeMaxValue ? 99999 : settingsStore.runTimeMax : 99999}');
    if (settingsStore.runTimeActive)
      print(
          'with_runtime.gte: ${settingsStore.runTimeActive ? settingsStore.runTimeMin : 0}');
    if (settingsStore.voteCountActive)
      print(
          'vote_count.lte: ${settingsStore.voteCountActive ? settingsStore.voteCountMax == FilterDefaultValues.voteCountMaxValue ? 99999 : settingsStore.voteCountMax : 99999}');
    if (settingsStore.voteCountActive)
      print(
          'vote_count.gte: ${settingsStore.voteCountActive ? settingsStore.voteCountMin : 0}');
    if (settingsStore.voteAvgActive)
      print(
          'vote_average.lte: ${settingsStore.voteAvgActive ? settingsStore.voteAvgMax : FilterDefaultValues.voteAvgMaxValue}');
    if (settingsStore.voteAvgActive)
      print(
          'vote_average.gte: ${settingsStore.voteAvgActive ? settingsStore.voteAvgMin : 0}');
//?-----
  }

//*getSingleMovie
  @action
  Future<void> getSingleMovie(int id, int contentType) async {
    //?setup

    String strContentType = contentType == 0 ? 'movie' : 'tv';
    //?-----
    //TODO Use Append To Response
    //*http requests

    final response = await Future.wait([
      fetchData(path: '/$strContentType/$id', parameters: {
        'language': language,
      }),
      fetchData(path: '/$strContentType/$id/videos', parameters: {
        'language': language,
      }),
      fetchData(path: '/$strContentType/$id/images', parameters: {
        'language': language.substring(0, 2),
      }),
      fetchData(path: '/$strContentType/$id/credits', parameters: {
        'language': language,
      }),
      fetchData(path: '/$strContentType/$id/watch/providers', parameters: {}),
    ]);

    //!Watch Providers
    try {
      final wpData = response[4].data['results'];
      String iso = settingsStore.avaliableRegions
          .firstWhere((element) => element.englishName == settingsStore.country)
          .iso_3166_1;
      if (wpData[iso] != null) {
        final List<AvaliableWatchProvider> flatrate =
            wpData[iso]['flatrate'] != null
                ? wpData[iso]['flatrate'].map<AvaliableWatchProvider>((e) {
                    return AvaliableWatchProvider(
                      displayPriority: e['display_priority'],
                      logoPath: e['logo_path'],
                      providerName: e['provider_name'],
                      providerId: e['provider_id'],
                    );
                  }).toList()
                : [];

        final List<AvaliableWatchProvider> buy = wpData[iso]['buy'] != null
            ? wpData[iso]['buy'].map<AvaliableWatchProvider>((e) {
                return AvaliableWatchProvider(
                  displayPriority: e['display_priority'],
                  logoPath: e['logo_path'],
                  providerName: e['provider_name'],
                  providerId: e['provider_id'],
                );
              }).toList()
            : [];
        final List<AvaliableWatchProvider> rent = wpData[iso]['rent'] != null
            ? wpData[iso]['rent'].map<AvaliableWatchProvider>((e) {
                return AvaliableWatchProvider(
                  displayPriority: e['display_priority'],
                  logoPath: e['logo_path'],
                  providerName: e['provider_name'],
                  providerId: e['provider_id'],
                );
              }).toList()
            : [];
        final List<AvaliableWatchProvider> ads = wpData[iso]['ads'] != null
            ? wpData[iso]['ads'].map<AvaliableWatchProvider>((e) {
                return AvaliableWatchProvider(
                  displayPriority: e['display_priority'],
                  logoPath: e['logo_path'],
                  providerName: e['provider_name'],
                  providerId: e['provider_id'],
                );
              }).toList()
            : [];

        final List<AvaliableWatchProvider> free = wpData[iso]['free'] != null
            ? wpData[iso]['free'].map<AvaliableWatchProvider>((e) {
                return AvaliableWatchProvider(
                  displayPriority: e['display_priority'],
                  logoPath: e['logo_path'],
                  providerName: e['provider_name'],
                  providerId: e['provider_id'],
                );
              }).toList()
            : [];

        movieAvaliableWatchProviders = MovieAvaliableWatchProviders(
          countryIso_3166_1: iso,
          link: wpData[iso]['link'],
          flatrate: flatrate,
          buy: buy,
          rent: rent,
          ads: ads,
          free: free,
        );
      }
    } catch (e) {
      watchProviderError = true;
      print(e);
    }
    // //!---------------

    try {
      //TODO get reviews
      final data = response[0].data;
      final videos = response[1].data['results'].map<MovieVideo>((e) {
        return MovieVideo(
            name: e['name'],
            site: e['site'],
            language: e['iso_639_1'],
            key: e['key'],
            type: e['type'],
            publishedAt: e['published_at'],
            official: e['official']);
      }).toList();
      final images = response[2].data['posters'].map<MovieImage>((e) {
        return MovieImage(filePath: e['file_path'], language: e['iso_639_1']);
      }).toList();
      List<TvSeason>? seasons;
      seasons = data['seasons'] != null
          ? data['seasons'].map<TvSeason>((e) {
              return TvSeason(
                episodeCount: e['episode_count'],
                airDate: e['air_date'],
                name: e['name'],
                posterPath: e['poster_path'],
                id: e['id'],
                seasonNumber: e['season_number'],
                overview: e['overview'],
              );
            }).toList()
          : null;
      final cast = response[3].data['cast'].map<Cast>((e) {
        return Cast(
          adult: e['adult'],
          id: e['id'],
          knownForFepartment: e['known_for_department'],
          name: e['name'],
          originalName: e['original_name'],
          popularity: e['popularity'],
          castId: e['cast_id'],
          character: e['character'],
          creditId: e['credit_id'],
          order: e['order'],
          gender: e['gender'],
          profilePath: e['profile_path'],
        );
      }).toList();

      final crew = response[3].data['crew'].map<Crew>((e) {
        return Crew(
            adult: e['adult'],
            id: e['id'],
            knownForFepartment: e['known_for_department'],
            name: e['name'],
            originalName: e['original_name'],
            popularity: e['popularity'],
            creditId: e['credit_id'],
            department: e['department'],
            job: e['job'],
            gender: e['gender'],
            profilePath: e['profile_path']);
      }).toList();
      final crewIds = Set();
      crew.retainWhere((x) => crewIds.add(x.id));
      final castIds = Set();
      cast.retainWhere((x) => castIds.add(x.id));
      final credits = Credits(
        id: response[3].data['id'],
        cast: cast,
        crew: crew,
      );
      movie = CompleteMovie(
        images: images,
        videos: videos,
        genres: data['genres'],
        id: id,
        adult: data['adult'],
        popularity: data['popularity'],
        voteAverage: data['vote_average'],
        originalLanguage: data['original_language'],
        title: data['title'] != null ? data['title'] : data['name'],
        overview: data['overview'],
        releaseDate: data['release_date'] != null
            ? data['release_date']
            : data['first_air_date'],
        budget: data['budget'],
        originalTitle: data['original_title'] != null
            ? data['original_title']
            : data['original_name'],
        productionCompanies: data['production_companies'],
        productionCountries: data['production_countries'],
        spokenLanguages: data['spoken_languages'],
        revenue: data['revenue'],
        launchStatus: data['status'],
        backdropPath: data['backdrop_path'],
        imdbId: data['imdb_id'],
        posterPath: data['poster_path'],
        runtime: data['runtime'],
        tagline: data['tagline'],
        numberOfEpisodes: data['number_of_episodes'] != null
            ? data['number_of_episodes']
            : null,
        numberOfSeasons: data['number_of_seasons'] != null
            ? data['number_of_seasons']
            : null,
        seasons: seasons,
        voteCount: data['vote_count'],
        credits: credits,
        movieAvaliableWatchProviders: movieAvaliableWatchProviders,
      );
    } catch (e) {
      error = true;
      print(e);
    }

    //*-------------

    //?debug
    print("ID: $id");
    print("Selected Content Type: $contentType");
    //?-----
  }

  @action
  void setSearch() {
    searchString = temporarySearchString;
  }

  //*search
  @action
  Future<void> search() async {
    //?setup
    empty = false;
    movies = [];
    page = 1;
    if (searchString.isEmpty) {
      getPopularContent();
      return;
    }

    final parameters = {
      'language': language,
      'query': searchString,
      'page': page,
      'include_adult': settingsStore.adultContent,
    };

    //?-----

    //*http request
    final response = settingsStore.selectedContentType == 0
        ? await fetchData(path: '/search/movie', parameters: parameters)
        : await fetchData(path: '/search/tv', parameters: parameters);

    error = false;
    try {
      totalPages = response.data['total_pages'];
      movies = response.data['results'].map<SimpleMovie>((e) {
        return SimpleMovie(
            genreIds: e['genre_ids'],
            id: e['id'],
            popularity: e['popularity'],
            voteAverage: e['vote_average'],
            originalLanguage: e['original_language'],
            title: e['title'] != null ? e['title'] : e['name'],
            overview: e['overview'],
            releaseDate: e['release_date'] != null
                ? e['release_date']
                : e['first_air_date'],
            backdropPath: e['backdrop_path'],
            posterPath: e['poster_path'],
            adult: e['adult'] != null ? e['adult'] : false);
      }).toList();
      if (movies.length == 0) {
        empty = true;
      }
    } catch (e) {
      print(e);
      error = true;
    }
    //*------------

    //?debug
    print("Include adult: ${settingsStore.adultContent}");
    print("Page: $page");
    print("Query: $searchString");
    print("Language: $language");
    print("Error: $error");
    print("Results: ${movies.length}");
//?------
  }

  //*getRecommendations
  @action
  Future<void> getRecommendations(int id) async {
    //?setup
    recommendations = [];
    Map<String, dynamic> parameters = {
      'language': language,
      'page': 1,
    };
    final response = settingsStore.selectedContentType == 0
        ? await fetchData(
            path: '/movie/$id/recommendations', parameters: parameters)
        : await fetchData(
            path: '/tv/$id/recommendations', parameters: parameters);

    //?-----

    //*http request
    error = false;
    try {
      recommendations = response.data['results'].map<SimpleMovie>((e) {
        return SimpleMovie(
            genreIds: e['genre_ids'],
            id: e['id'],
            popularity: e['popularity'],
            voteAverage: e['vote_average'],
            originalLanguage: e['original_language'],
            title: e['title'] != null ? e['title'] : e['name'],
            overview: e['overview'],
            releaseDate: e['release_date'] != null
                ? e['release_date']
                : e['first_air_date'],
            backdropPath: e['backdrop_path'],
            posterPath: e['poster_path'],
            adult: e['adult']);
      }).toList();
    } catch (e) {
      print("Similar Movies Error");
      print(e);
    }
  }

  //*getSeasonEpisodes
  Future<void> getSeasonEpisodes(
      {required int tvId, required int seasonNumber}) async {
    //?setup
    loadingSeason = true;
    Map<String, dynamic> parameters = {
      'language': language,
      'page': 1,
    };
    //?-----

    //*http request
    final response = await fetchData(
        path: '/tv/$tvId/season/$seasonNumber', parameters: parameters);

    error = false;
    try {
      List<Episode> episodes = response.data['episodes'].map<Episode>((e) {
        return Episode(
            airDate: e['air_date'],
            episodeNumber: e['episode_number'],
            id: e['id'],
            name: e['name'],
            overview: e['overview'],
            productionCode: e['production_code'],
            seasonNumber: e['season_number'],
            stillPath: e['still_path'],
            voteAverage: e['vote_average'],
            voteCount: e['vote_count']);
      }).toList();
      season = TvSeason(
        airDate: response.data['air_date'],
        episodes: episodes,
        id: response.data['id'],
        idstr: response.data['_id'],
        name: response.data['name'],
        overview: response.data['overview'],
        posterPath: response.data['poster_path'],
        seasonNumber: response.data['season_number'],
      );
      loadingSeason = false;
    } catch (e) {
      error = true;
      loadingSeason = false;
      print("Tv Sesons Error");
      print(e);
    }
  }

  @observable
  Episode? episode;

  @observable
  bool loadingEpisode = false;

  @observable
  bool episodeError = false;

  //*getSingleEpisode
  @action
  Future<void> getEpisode(int tvId, int seasonNumber, int episodeNumber) async {
    //?setup
    loadingEpisode = true;
    Map<String, dynamic> parameters = {
      'language': language,
    };
    //?-----

    final response = await Future.wait([
      fetchData(
          path: '/tv/$tvId/season/$seasonNumber/episode/$episodeNumber',
          parameters: parameters),
      fetchData(
          path: '/tv/$tvId/season/$seasonNumber/episode/$episodeNumber/images',
          parameters: parameters),
    ]);
    List<EpisodeImage>? images;
    try {
      images = response[1].data['stills'].map<EpisodeImage>((e) {
        return EpisodeImage(
            aspectRatio: e['aspect_ratio'],
            filePath: e['file_path'],
            heigth: e['height'],
            voteAverage: e['vote_average'],
            voteCount: e['vote_count'],
            width: e['width']);
      }).toList();
    } catch (e) {
      print('Episode Images Error');
      print(e);
    }
    //*http request

    episodeError = false;
    try {
      episode = Episode(
        airDate: response[0].data['air_date'],
        episodeNumber: response[0].data['episode_number'],
        id: response[0].data['id'],
        name: response[0].data['name'],
        overview: response[0].data['overview'],
        productionCode: response[0].data['production_code'],
        seasonNumber: response[0].data['season_number'],
        voteAverage: response[0].data['vote_average'],
        voteCount: response[0].data['vote_count'],
        stillPath: response[0].data['still_path'],
        images: images,
      );
      loadingEpisode = false;
    } catch (e) {
      episodeError = true;
      loadingEpisode = false;
      print("Episode Error");
      print('TvId: $tvId');
      print("Season Number: $seasonNumber");
      print("Episode Number: $episodeNumber");
      print(e);
    }
  }

  @observable
  Person? person;

  @action
  Future<void> getPerson(int personId) async {
    final response = await Future.wait([
      fetchData(path: '/person/$personId', parameters: {
        'language': language,
      }),
      fetchData(
          path: '/person/$personId/images', parameters: {'language': language}),
      fetchData(
          path: '/person/$personId/external_ids',
          parameters: {'language': language}),
      fetchData(
          path: '/person/$personId/movie_credits',
          parameters: {'language': language}),
      fetchData(
          path: '/person/$personId/tv_credits',
          parameters: {'language': language}),
    ]);

    final data = response[0].data;
    final imageData = response[1].data;
    final externalIdsData = response[2].data;
    final movieCreditsData = response[3].data;
    final tvCreditsData = response[4].data;
    print(externalIdsData);
    try {
      final images = imageData['profiles'].map<PersonImage>((e) {
        return PersonImage(
          filePath: e['file_path'],
          height: e['height'],
          voteAverage: e['vote_average'],
          voteCount: e['vote_count'],
          width: e['width'],
          aspectRatio: e['aspect_ratio'],
        );
      }).toList();
      final externalIds = PersonExternalIds(
        id: externalIdsData['id'],
        facebookId: externalIdsData['facebook_id'],
        freebaseId: externalIdsData['freebase_id'],
        freebaseMid: externalIdsData['freebase_mid'],
        imdbId: externalIdsData['imdb_id'],
        instagramId: externalIdsData['instagram_id'],
        tvrageId: externalIdsData['tvrage_id'],
        twitterId: externalIdsData['twitter_id'],
      );
      final movieCreditsCast =
          movieCreditsData['cast'].map<PersonMovieCreditCast>((e) {
        return PersonMovieCreditCast(
          character: e['character'] != null ? e['character'] : '',
          creditId: e['credit_id'],
          id: e['id'],
          overview: e['overview'],
          title: e['title'],
          voteAverage: e['vote_average'],
          voteCount: e['vote_count'],
          backdropPath: e['backdrop_path'],
          posterPath: e['poster_path'],
          releaseDate: e['release_date'],
        );
      }).toList();
      final tvCreditsCast = tvCreditsData['cast'].map<PersonTVCreditCast>((e) {
        return PersonTVCreditCast(
            creditId: e['credit_id'],
            id: e['id'],
            character: e['character'],
            name: e['name'],
            voteCount: e['vote_count'],
            voteAverage: e['vote_average'],
            popularity: e['popularity'],
            episodeCount: e['episode_count'],
            overview: e['overview'],
            posterPath: e['poster_path']);
      }).toList();
      person = Person(
          id: data['id'],
          name: data['name'],
          gender: data['gender'],
          popularity: data['popularity'],
          adult: data['adult'],
          biography: data['biography'],
          birthday: data['birthday'],
          deathDay: data['deathday'],
          homePage: data['homepage'],
          knownForDepartment: data['known_for_department'],
          placeOfBirth: data['place_of_birth'],
          profilePath: data['profile_path'],
          images: images,
          externalIds: externalIds,
          personMovieCreditCast: movieCreditsCast,
          personTVCreditCast: tvCreditsCast);
    } catch (e) {
      error = true;
      print(e);
    }
  }

  //end
}
