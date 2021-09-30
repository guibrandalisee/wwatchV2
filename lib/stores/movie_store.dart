import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/api.dart';
part 'movie_store.g.dart';

enum ContentType { TVSHOW, MOVIE }

class MovieStore = _MovieStoreBase with _$MovieStore;

abstract class _MovieStoreBase with Store {
  String apiKey = API().apiKey;
  @action
  Future getGenres(ContentType type) async {
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
    var options = BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    Dio dio = Dio(options);
    final response = await dio.get(path, queryParameters: parameters);
    if (response.data != null) {
      if (type == ContentType.MOVIE) {
        movieGenres = response.data;
      } else {
        tvGenres = response.data;
      }
      return Future.value('success');
    } else {
      error = true;
      return Future.error('Connection Error');
    }
  }

  @observable
  Map<String, dynamic> movieGenres = {};
  @observable
  Map<String, dynamic> tvGenres = {};

  Future getMovies(
      {required int page,
      required String path,
      Map<String, dynamic>? parameters}) async {
    var options = BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    Dio dio = Dio(options);

    final response = await dio.get(path, queryParameters: parameters);
    return response;
  }

  @observable
  int page = 1;

  @observable
  String language = 'en-US';

  @observable
  bool includeAdult = false;

  @observable
  List<SimpleMovie> popularMovies = [];

  @observable
  bool error = false;

  //TODO use the path '/movie/popular' instead of '/discover/movie' - See API Documentation
  //https://developers.themoviedb.org/3/movies/get-popular-movies
  //you can also add filter by option on top of the page and get top rated, upcoming, and now playing movies
  @action
  Future<void> getPopularMovies() async {
    final response =
        await getMovies(path: '/discover/movie', page: page, parameters: {
      'api_key': apiKey,
      'language': language,
      'sort_by': 'popularity.desc',
      'include_adult': includeAdult,
    });
    error = false;
    try {
      popularMovies = response.data['results'].map<SimpleMovie>((e) {
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
}
