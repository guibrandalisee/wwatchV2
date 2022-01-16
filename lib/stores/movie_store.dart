import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:wwatch/Shared/models/movie_images_model.dart';
import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/Shared/models/movie_video_model.dart';
import 'package:wwatch/api.dart';
import 'package:wwatch/stores/settings_store.dart';
part 'movie_store.g.dart';

enum ContentType { TVSHOW, MOVIE }

class MovieStore = _MovieStoreBase with _$MovieStore;
final SettingsStore settingsStore = GetIt.I<SettingsStore>();

abstract class _MovieStoreBase with Store {
  String apiKey = API().apiKey;

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
    if (_settingsStore.selectedGenres.isNotEmpty) {
      String genres = '';
      for (var item in _settingsStore.selectedGenres) {
        genres += item.toString() + ',';
      }
      parameters = {
        'api_key': apiKey,
        'language': language,
        'page': page,
        'sort_by': settingsStore.selectedSortBy,
        'include_adult': settingsStore.adultContent,
        'with_genres': genres
      };
      print("Genres: $genres");
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
            releaseDate: e['release_date'],
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
    print("Sort By: ${settingsStore.selectedSortBy}");
  }

  @action
  Future<void> getMorePopularMovies() async {
    final SettingsStore _settingsStore = GetIt.I<SettingsStore>();
    page++;
    if (searchString.isEmpty) {
      print("More Results-----------------------");
      Map<String, dynamic> parameters = {};
      if (_settingsStore.selectedGenres.isNotEmpty) {
        String genres = '';
        for (var item in _settingsStore.selectedGenres) {
          genres += item.toString() + ',';
        }
        print("Genres: $genres");
        parameters = {
          'api_key': apiKey,
          'language': language,
          'page': page,
          'sort_by': settingsStore.selectedSortBy,
          'include_adult': settingsStore.adultContent,
          'with_genres': genres
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
              releaseDate: e['release_date'],
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
              popularity: e['popularity'],
              voteAverage: e['vote_average'] + 0.0,
              originalLanguage: e['original_language'],
              title: e['title'],
              overview: e['overview'],
              releaseDate: e['release_date'],
              backdropPath: e['backdrop_path'],
              posterPath: e['poster_path'],
              adult: e['adult']);
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

  @observable
  bool backToTheTopVisible = false;

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
      );
    } catch (e) {
      error = true;
      print(e);
    }
  }

  @observable
  String searchString = '';

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
            popularity: e['popularity'],
            voteAverage: e['vote_average'] + 0.0,
            originalLanguage: e['original_language'],
            title: e['title'],
            overview: e['overview'],
            releaseDate: e['release_date'],
            backdropPath: e['backdrop_path'],
            posterPath: e['poster_path'],
            adult: e['adult']);
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

  @action
  void setSearch(String value) => searchString = value;

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
}
