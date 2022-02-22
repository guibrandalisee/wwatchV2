import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:wwatch/Shared/models/movie_images_model.dart';
import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/Shared/models/movie_video_model.dart';
import 'package:wwatch/Shared/models/tv_season_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wwatch/stores/settings_store.dart';
part 'movie_store.g.dart';

enum ContentType { TVSHOW, MOVIE }

class MovieStore = _MovieStoreBase with _$MovieStore;
final SettingsStore settingsStore = GetIt.I<SettingsStore>();

abstract class _MovieStoreBase with Store {
  String apiKey = env['API_KEY']!;

  @observable
  bool didChange = false;
  //Default http request function
  @action
  Future fetchData(
      {required String path, required Map<String, dynamic> parameters}) async {
    var options = BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      connectTimeout: 5000,
      receiveTimeout: 3000,
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

  @observable
  int page = 1;

  @observable
  String language = 'en-US';

  //List of movies that will be displayed on front page
  @observable
  List<SimpleMovie> movies = [];

  @observable
  bool error = false;

  @observable
  int? totalPages;

  @action
  Future<void> getPopularMovies() async {
    movies = [];
    final SettingsStore _settingsStore = GetIt.I<SettingsStore>();
    empty = false;
    page = 1;
    Map<String, dynamic> parameters = {};
    if (_settingsStore.selectedMovieGenres.isNotEmpty &&
        _settingsStore.selectedContentType == 0) {
      String genres = '';
      for (var item in _settingsStore.selectedMovieGenres) {
        genres += item.toString() + ',';
      }
      parameters = {
        'api_key': apiKey,
        'language': language,
        'page': page,
        'sort_by': settingsStore.selectedSortBy,
        'include_adult': settingsStore.adultContent,
        'with_genres': genres,
        'with_runtime.lte': settingsStore.runTimeActive
            ? settingsStore.runTimeMax == 180
                ? 999
                : settingsStore.runTimeMax
            : 999,
        'with_runtime.gte':
            settingsStore.runTimeActive ? settingsStore.runTimeMin : 0,
        'vote_count.lte': settingsStore.voteCountActive
            ? settingsStore.voteCountMax == 15000
                ? 999999
                : settingsStore.voteCountMax
            : 999999,
        'vote_count.gte':
            settingsStore.voteCountActive ? settingsStore.voteCountMin : 0,
        'vote_average.gte':
            settingsStore.voteAvgActive ? settingsStore.voteAvgMin : 0,
        'vote_average.lte':
            settingsStore.voteAvgActive ? settingsStore.voteAvgMax : 10
      };
      print("Genres: $genres");
    } else if (_settingsStore.selectedTvShowGenres.isNotEmpty &&
        _settingsStore.selectedContentType == 1) {
      String genres = '';
      for (var item in _settingsStore.selectedTvShowGenres) {
        genres += item.toString() + ',';
      }
      parameters = {
        'api_key': apiKey,
        'language': language,
        'page': page,
        'sort_by': settingsStore.selectedSortBy,
        'include_adult': settingsStore.adultContent,
        'with_genres': genres,
        'with_runtime.lte': settingsStore.runTimeActive
            ? settingsStore.runTimeMax == 180
                ? 999
                : settingsStore.runTimeMax
            : 999,
        'with_runtime.gte':
            settingsStore.runTimeActive ? settingsStore.runTimeMin : 0,
        'vote_count.lte': settingsStore.voteCountActive
            ? settingsStore.voteCountMax == 15000
                ? 999999
                : settingsStore.voteCountMax
            : 999999,
        'vote_count.gte':
            settingsStore.voteCountActive ? settingsStore.voteCountMin : 0,
        'vote_average.gte':
            settingsStore.voteAvgActive ? settingsStore.voteAvgMin : 0,
        'vote_average.lte':
            settingsStore.voteAvgActive ? settingsStore.voteAvgMax : 10
      };
      print("Genres: $genres");
    } else {
      print(
          'with_runtime.lte: ${settingsStore.runTimeActive ? settingsStore.runTimeMax == 180 ? 99999 : settingsStore.runTimeMax : 99999}');
      print(
          'with_runtime.gte: ${settingsStore.runTimeActive ? settingsStore.runTimeMin : 0}');
      print(
          'vote_count.lte: ${settingsStore.voteCountActive ? settingsStore.voteCountMax == 15000 ? 99999 : settingsStore.voteCountMax : 99999}');
      print(
          'vote_count.gte: ${settingsStore.voteCountActive ? settingsStore.voteCountMin : 0}');

      print(
          'vote_average.lte: ${settingsStore.voteAvgActive ? settingsStore.voteAvgMax : 10}');
      print(
          'vote_average.gte: ${settingsStore.voteAvgActive ? settingsStore.voteAvgMin : 0}');
      parameters = {
        'api_key': apiKey,
        'language': language,
        'page': page,
        'sort_by': settingsStore.selectedSortBy,
        'include_adult': settingsStore.adultContent,
        'with_runtime.lte': settingsStore.runTimeActive
            ? settingsStore.runTimeMax == 180
                ? 999
                : settingsStore.runTimeMax
            : 999,
        'with_runtime.gte':
            settingsStore.runTimeActive ? settingsStore.runTimeMin : 0,
        'vote_count.lte': settingsStore.voteCountActive
            ? settingsStore.voteCountMax == 15000
                ? 999999
                : settingsStore.voteCountMax
            : 999999,
        'vote_count.gte':
            settingsStore.voteCountActive ? settingsStore.voteCountMin : 0,
        'vote_average.gte':
            settingsStore.voteAvgActive ? settingsStore.voteAvgMin : 0,
        'vote_average.lte':
            settingsStore.voteAvgActive ? settingsStore.voteAvgMax : 10
      };
    }
    final response;
    if (settingsStore.selectedContentType == 0) {
      response =
          await fetchData(path: '/discover/movie', parameters: parameters);
    } else {
      response = await fetchData(path: '/discover/tv', parameters: parameters);
    }
    error = false;
    try {
      totalPages = response.data['total_pages'];
      movies = response.data['results'].map<SimpleMovie>((e) {
        return SimpleMovie(
          genreIds: e['genre_ids'],
          id: e['id'],
          popularity: e['popularity'] + 0.0,
          voteAverage: e['vote_average'] + 0.0,
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
    print("Include adult: ${settingsStore.adultContent}");
    print("Page: $page");
    print("Query: $searchString");
    print("Language: $language");
    print("Error: $error");
    print("Results: ${movies.length}");
    print("Sort By: ${settingsStore.selectedSortBy}");
  }

  @action
  Future<void> getMorePopularMovies() async {
    final SettingsStore _settingsStore = GetIt.I<SettingsStore>();
    page++;
    if (searchString.isEmpty) {
      print("More Results-----------------------");
      Map<String, dynamic> parameters = {};

      if (_settingsStore.selectedMovieGenres.isNotEmpty &&
          _settingsStore.selectedContentType == 0) {
        String genres = '';
        for (var item in _settingsStore.selectedMovieGenres) {
          genres += item.toString() + ',';
        }
        print("Genres: $genres");
        parameters = {
          'api_key': apiKey,
          'language': language,
          'page': page,
          'sort_by': settingsStore.selectedSortBy,
          'include_adult': settingsStore.adultContent,
          'with_genres': genres,
          'with_runtime.lte': settingsStore.runTimeActive
              ? settingsStore.runTimeMax == 180
                  ? 999
                  : settingsStore.runTimeMax
              : 999,
          'with_runtime.gte':
              settingsStore.runTimeActive ? settingsStore.runTimeMin : 0,
          'vote_count.lte': settingsStore.voteCountActive
              ? settingsStore.voteCountMax == 15000
                  ? 999999
                  : settingsStore.voteCountMax
              : 999999,
          'vote_count.gte':
              settingsStore.voteCountActive ? settingsStore.voteCountMin : 0,
          'vote_average.gte':
              settingsStore.voteAvgActive ? settingsStore.voteAvgMin : 0,
          'vote_average.lte':
              settingsStore.voteAvgActive ? settingsStore.voteAvgMax : 10
        };
      } else if (_settingsStore.selectedTvShowGenres.isNotEmpty &&
          _settingsStore.selectedContentType == 1) {
        String genres = '';
        for (var item in _settingsStore.selectedTvShowGenres) {
          genres += item.toString() + ',';
        }
        print("Genres: $genres");
        parameters = {
          'api_key': apiKey,
          'language': language,
          'page': page,
          'sort_by': settingsStore.selectedSortBy,
          'include_adult': settingsStore.adultContent,
          'with_genres': genres,
          'with_runtime.lte': settingsStore.runTimeActive
              ? settingsStore.runTimeMax == 180
                  ? 999
                  : settingsStore.runTimeMax
              : 999,
          'with_runtime.gte':
              settingsStore.runTimeActive ? settingsStore.runTimeMin : 0,
          'vote_count.lte': settingsStore.voteCountActive
              ? settingsStore.voteCountMax == 15000
                  ? 999999
                  : settingsStore.voteCountMax
              : 999999,
          'vote_count.gte':
              settingsStore.voteCountActive ? settingsStore.voteCountMin : 0,
          'vote_average.gte':
              settingsStore.voteAvgActive ? settingsStore.voteAvgMin : 0,
          'vote_average.lte':
              settingsStore.voteAvgActive ? settingsStore.voteAvgMax : 10
        };
      } else {
        parameters = {
          'api_key': apiKey,
          'language': language,
          'page': page,
          'sort_by': settingsStore.selectedSortBy,
          'include_adult': settingsStore.adultContent,
        };
      }
      final response;
      if (settingsStore.selectedContentType == 0) {
        response =
            await fetchData(path: '/discover/movie', parameters: parameters);
      } else {
        response =
            await fetchData(path: '/discover/tv', parameters: parameters);
      }
      error = false;
      try {
        final newMovies = response.data['results'].map<SimpleMovie>((e) {
          return SimpleMovie(
              genreIds: e['genre_ids'],
              id: e['id'],
              popularity: e['popularity'] + 0.0,
              voteAverage: e['vote_average'] + 0.0,
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
      print("Include adult: ${settingsStore.adultContent}");
      print("Page: $page");
      print("Query: $searchString");
      print("Language: $language");
      print("Error: $error");
      print("Total Results: ${movies.length}");
      print("Sort By: ${settingsStore.selectedSortBy}");
    } else {
      final response;
      if (settingsStore.selectedContentType == 0) {
        response = await fetchData(path: '/search/movie', parameters: {
          'api_key': apiKey,
          'language': language,
          'page': page,
          'query': searchString,
          'include_adult': settingsStore.adultContent,
        });
      } else {
        response = await fetchData(path: '/search/tv', parameters: {
          'api_key': apiKey,
          'language': language,
          'page': page,
          'query': searchString,
          'include_adult': settingsStore.adultContent,
        });
      }
      error = false;
      try {
        final newMovies = response.data['results'].map<SimpleMovie>((e) {
          return SimpleMovie(
              genreIds: e['genre_ids'],
              id: e['id'],
              popularity: e['popularity'] + 0.0,
              voteAverage: e['vote_average'] + 0.0,
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
      print("More Results-----------------------");
      print("Include adult: ${settingsStore.adultContent}");
      print("Page: $page");
      print("Query: $searchString");
      print("Language: $language");
      print("Error: $error");
      print("Total Results: ${movies.length}");
    }
  }

  @observable
  String country = 'US';

  @observable
  CompleteMovie? movie;

  @action
  Future<void> getSingleMovie(int id, int contentType) async {
    final mainResponse;
    final videoResponse;
    final imageResponse;
    print("ID: $id");
    print("Selected Content Type: $contentType");
    if (contentType == 0) {
      mainResponse = await fetchData(path: '/movie/$id', parameters: {
        'api_key': apiKey,
        'language': language,
      });
      videoResponse = await fetchData(path: '/movie/$id/videos', parameters: {
        'api_key': apiKey,
        'language': language,
      });
      imageResponse = await fetchData(path: '/movie/$id/images', parameters: {
        'api_key': apiKey,
        'language': language.substring(0, 2),
      });
    } else {
      mainResponse = await fetchData(path: '/tv/$id', parameters: {
        'api_key': apiKey,
        'language': language,
      });
      videoResponse = await fetchData(path: '/tv/$id/videos', parameters: {
        'api_key': apiKey,
        'language': language,
      });
      imageResponse = await fetchData(path: '/tv/$id/images', parameters: {
        'api_key': apiKey,
        'language': language.substring(0, 2),
      });
    }

    try {
      //TODO get watchProviders, cast and reviews
      final data = mainResponse.data;
      final videos = videoResponse.data['results'].map<MovieVideo>((e) {
        return MovieVideo(
            name: e['name'],
            site: e['site'],
            language: e['iso_639_1'],
            key: e['key'],
            type: e['type'],
            publishedAt: e['published_at'],
            official: e['official']);
      }).toList();
      final images = imageResponse.data['posters'].map<MovieImage>((e) {
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
      movie = CompleteMovie(
        images: images,
        videos: videos,
        genres: data['genres'],
        id: id,
        adult: data['adult'],
        popularity: data['popularity'] + 0.0,
        voteAverage: data['vote_average'] + 0.0,
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
      );
    } catch (e) {
      error = true;
      print(e);
    }
  }

  @observable
  String searchString = '';

  @observable
  String temporarySearchString = '';

  @action
  void setSearch() {
    searchString = temporarySearchString;
  }

  @observable
  bool empty = false;

  @action
  Future<void> search() async {
    empty = false;
    movies = [];
    page = 1;
    if (searchString.isEmpty) {
      getPopularMovies();
      return;
    }
    final response;
    if (settingsStore.selectedContentType == 0) {
      response = await fetchData(path: '/search/movie', parameters: {
        'api_key': apiKey,
        'language': language,
        'query': searchString,
        'page': page,
        'include_adult': settingsStore.adultContent,
      });
    } else {
      response = await fetchData(path: '/search/tv', parameters: {
        'api_key': apiKey,
        'language': language,
        'query': searchString,
        'page': page,
        'include_adult': settingsStore.adultContent,
      });
    }

    error = false;
    try {
      totalPages = response.data['total_pages'];
      movies = response.data['results'].map<SimpleMovie>((e) {
        return SimpleMovie(
            genreIds: e['genre_ids'],
            id: e['id'],
            popularity: e['popularity'] + 0.0,
            voteAverage: e['vote_average'] + 0.0,
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
    print("Include adult: ${settingsStore.adultContent}");
    print("Page: $page");
    print("Query: $searchString");
    print("Language: $language");
    print("Error: $error");
    print("Results: ${movies.length}");
  }

  @observable
  List<SimpleMovie> recommendations = [];

  @action
  Future<void> getRecommendations(int id) async {
    recommendations = [];
    Map<String, dynamic> parameters = {};
    parameters = {
      'api_key': apiKey,
      'language': language,
      'page': 1,
    };
    final response;
    if (settingsStore.selectedContentType == 0) {
      response = await fetchData(
          path: '/movie/$id/recommendations', parameters: parameters);
    } else {
      response = await fetchData(
          path: '/tv/$id/recommendations', parameters: parameters);
    }
    error = false;
    try {
      recommendations = response.data['results'].map<SimpleMovie>((e) {
        return SimpleMovie(
            genreIds: e['genre_ids'],
            id: e['id'],
            popularity: e['popularity'] + 0.0,
            voteAverage: e['vote_average'] + 0.0,
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

  @observable
  TvSeason? season;

  @observable
  bool loadingSeason = false;

  @action
  Future<void> getSeasonEpisodes(
      {required int tvId, required int seasonNumber}) async {
    loadingSeason = true;
    Map<String, dynamic> parameters = {};
    parameters = {
      'api_key': apiKey,
      'language': language,
      'page': 1,
    };
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
}
