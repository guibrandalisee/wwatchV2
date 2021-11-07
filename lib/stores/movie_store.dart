import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:wwatch/Shared/models/movie_images_model.dart';
import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/Shared/models/movie_video_model.dart';
import 'package:wwatch/api.dart';
part 'movie_store.g.dart';

enum ContentType { TVSHOW, MOVIE }

class MovieStore = _MovieStoreBase with _$MovieStore;

abstract class _MovieStoreBase with Store {
  String apiKey = API().apiKey;

  @observable
  Map<String, dynamic> movieGenres = {};
  @observable
  Map<String, dynamic> tvGenres = {};
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

  @observable
  bool includeAdult = false;

  @observable
  List<SimpleMovie> movies = [];

  @observable
  bool error = false;

  @observable
  int? totalPages;

  @action
  Future<void> getPopularMovies() async {
    page = 1;
    final response = await fetchData(path: '/discover/movie', parameters: {
      'api_key': apiKey,
      'language': language,
      'page': page,
      'sort_by': 'popularity.desc',
      'include_adult': includeAdult,
      'include_video': false,
    });
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
    } catch (e) {
      print(e);
      error = true;
    }
  }

  @action
  Future<void> getMorePopularMovies() async {
    page++;
    if (searchString.isEmpty) {
      final response = await fetchData(
          path: selectedContentType == 0 ? '/search/movie' : '/search/tv',
          parameters: {
            'api_key': apiKey,
            'language': language,
            'page': page,
            'sort_by': 'popularity.desc',
            'include_adult': includeAdult,
          });
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
    } else {
      final response = await fetchData(
          path: selectedContentType == 0 ? '/search/movie' : '/search/tv',
          parameters: {
            'api_key': apiKey,
            'language': language,
            'page': page,
            'query': searchString,
            'include_adult': includeAdult,
          });
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
    }
  }

  @action
  Future<void> getGenres(ContentType type) async {
    String t = '';
    if (type == ContentType.MOVIE) {
      t = 'movie';
    } else {
      t = 'tv';
    }
    String path = '/genre/$t/list';
    Map<String, dynamic> parameters = {
      'api_key': apiKey,
      'language': language,
    };
    final response = await fetchData(path: path, parameters: parameters);
    if (response.data != null) {
      if (type == ContentType.MOVIE) {
        movieGenres = response.data;
      } else {
        tvGenres = response.data;
      }
      return Future.value('success');
    }
  }

  @observable
  String country = 'US';

  @observable
  CompleteMovie? movie;

  @observable
  bool backToTheTopVisible = false;

  @action
  Future<void> getSingleMovie(int id) async {
    final mainResponse = await fetchData(path: '/movie/$id', parameters: {
      'api_key': apiKey,
      'language': language,
    });
    final videoResponse =
        await fetchData(path: '/movie/$id/videos', parameters: {
      'api_key': apiKey,
      'language': language,
    });
    final imageResponse =
        await fetchData(path: '/movie/$id/images', parameters: {
      'api_key': apiKey,
      'language': language.substring(0, 2),
    });

    try {
      //TODO get watchProviders, cast, recomendations and reviews
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
        title: data['title'],
        overview: data['overview'],
        releaseDate: data['release_date'],
        budget: data['budget'],
        originalTitle: data['original_title'],
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
    if (searchString.isEmpty) {
      movies = [];
      page = 1;
      getPopularMovies();
      return;
    }
    movies = [];
    page = 1;
    final response = await fetchData(
        path: selectedContentType == 0 ? '/search/movie' : '/search/tv',
        parameters: {
          'api_key': apiKey,
          'language': language,
          'query': searchString,
          'page': page,
          'include_adult': includeAdult,
        });
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
  }

  @action
  void setSearch(String value) => searchString = value;

  @observable
  List genres = ['Genres'];

  @observable
  String selectedGenre = 'Genres';

  @observable
  List sortBy = ['Popularity'];

  @observable
  String selectedSortBy = 'Popularity';

  @observable
  int selectedContentType = 0;

  @action
  void setSelectedContentType(int value) => selectedContentType = value;
}
