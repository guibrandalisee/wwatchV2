import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/api.dart';
part 'movie_store.g.dart';

class MovieStore = _MovieStoreBase with _$MovieStore;

abstract class _MovieStoreBase with Store {
  String apiKey = API().apiKey;

  Future getMovies(
      {required int page,
      required String path,
      Map<String, dynamic>? parameters}) async {
    //TODO set urls
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
  List<Movie> popularMovies = [];

  @observable
  bool error = false;

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
      popularMovies = response.data['results'].map<Movie>((e) {
        return Movie(
            genreIds: e['genre_ids'],
            id: e['id'],
            popularity: e['popularity'],
            voteAverage: e['vote_average'] + 0.0,
            originalLanguage: e['original_language'],
            title: e['title'],
            overview: e['overview'],
            releaseDate: e['release_date'],
            backdropPath: e['backdrop_path'],
            posterPath: e['poster_path']);
      }).toList();
    } catch (e) {
      error = true;
    }
  }

  @observable
  List<Movie> topRatedMovies = [];

  @action
  Future<void> getTopRatedMovies() async {
    final response =
        await getMovies(path: '/discover/movie', page: page, parameters: {
      'api_key': apiKey,
      'language': language,
      'sort_by': 'vote_average.desc',
      'include_adult': includeAdult,
      'vote_average.gte': 6,
      'vote_count.gte': 100
    });
    error = false;
    try {
      topRatedMovies = response.data['results'].map<Movie>((e) {
        return Movie(
            genreIds: e['genre_ids'],
            id: e['id'],
            popularity: e['popularity'],
            voteAverage: e['vote_average'] + 0.0,
            originalLanguage: e['original_language'],
            title: e['title'],
            overview: e['overview'],
            releaseDate: e['release_date'],
            backdropPath: e['backdrop_path'],
            posterPath: e['poster_path']);
      }).toList();
    } catch (e) {
      error = true;
    }
  }
}
