import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/Shared/models/user_model.dart';
import 'package:wwatch/stores/movie_store.dart';
part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  String token = dotenv.env['TOKEN']!;
  String apiKey = dotenv.env['API_KEY']!;
  final SharedPreferences? prefs;

  _UserStoreBase({required this.prefs}) {
    if (prefs!.containsKey("sessionId")) {
      sessionId = prefs!.getString("sessionId");
    }
  }

  @observable
  User? user;

  @observable
  bool httpError = false;

  @observable
  RequestToken? requestToken;

  @observable
  bool loading = false;

  @observable
  String? sessionId;

  @observable
  bool authError = false;

  @observable
  bool loggedIn = false;

  @observable
  bool error = false;

  @observable
  String loginErrorMessage = "";

  @observable
  ObservableList<SimpleMovie> favoriteMovies = ObservableList();

  @observable
  int favoriteMoviesMaxPages = 1;

  @observable
  ObservableList<SimpleMovie> favoriteTvShows = ObservableList<SimpleMovie>();

  @observable
  int favoriteTvShowsMaxPages = 1;

  //*Default http request function
  @action
  Future fetchData(
      {required String path, required Map<String, dynamic> parameters}) async {
    var options = BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: {
          //'Authorization': 'Bearer $token',
          'Content-Type': 'application/json;charset=utf-8'
        },
        queryParameters: {
          "api_key": apiKey
        });

    try {
      Dio dio = Dio(options);

      final response = await dio.get(
        path,
        queryParameters: parameters,
      );
      return response;
    } on DioError catch (e) {
      print(e);
      print(e.error);
      print(e.message);
      httpError = true;
    }
  }

  Future postData(
      {required String path,
      required Map<String, dynamic> data,
      Map<String, dynamic>? parameters}) async {
    if (parameters != null) {
      parameters.addAll(
        {"api_key": apiKey},
      );
    }
    var options = BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      connectTimeout: 5000,
      receiveTimeout: 3000,
      queryParameters: parameters != null ? parameters : {"api_key": apiKey},
      headers: {
        //'Authorization': 'Bearer $token',
        'Content-Type': 'application/json;charset=utf-8'
      },
    );

    try {
      Dio dio = Dio(options);

      final response = await dio.post(path, data: data);
      return response;
    } on DioError catch (e) {
      print(e);
      if (e.response != null && e.response!.data['status_message'] != null) {
        loginErrorMessage = e.response!.data['status_message'];
        print(loginErrorMessage);
      }
      httpError = true;
    }
  }

  Future deleteData(
      {required String path, required Map<String, dynamic> parameters}) async {
    var options = BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: {
          //'Authorization': 'Bearer $token',
          'Content-Type': 'application/json;charset=utf-8'
        },
        queryParameters: {
          "api_key": apiKey
        });

    try {
      Dio dio = Dio(options);

      final response = await dio.delete(path, queryParameters: parameters);
      return response;
    } on DioError catch (e) {
      print(e);
    }
  }

  //*Manage Login in TMDB servers ------------------------

  @action
  void createGuestSession() {}

  @action
  Future<void> createUserSession(
      {required String username, required String password}) async {
    authError = false;
    loginErrorMessage = "";
    if (requestToken == null || requestToken!.token.isEmpty) {
      httpError = true;
      loading = false;
      return;
    }

    final authentication = await postData(
        path: "/authentication/token/validate_with_login",
        data: {
          "username": username,
          "password": password,
          "request_token": requestToken!.token
        });

    try {
      if (authentication != null &&
          authentication.data['success'] != null &&
          authentication.data['success']) {
        requestToken!.authenticated = true;
        print("Authenticated");
        final createSession =
            await postData(path: "/authentication/session/new", data: {
          "request_token": requestToken!.token,
        });

        if (createSession.data['success']) {
          sessionId = createSession.data['session_id'];
          loggedIn = true;
          print("Session Created");
          print("Session ID: $sessionId");
          prefs!.setString("sessionId", sessionId!);
          loading = false;
        } else {
          print("Failed while creating session");
        }
      } else {
        loading = false;
        authError = true;
        print("Failed while authenticating token");
      }
    } catch (e) {
      loading = false;
      httpError = true;
      print(e);
    }
  }

  @action
  Future<void> getRequestToken() async {
    loading = true;
    final response =
        await fetchData(path: "/authentication/token/new", parameters: {});

    try {
      requestToken = RequestToken(
          expiresAt: response.data['expires_at']
              .toString()
              .substring(0, response.data['expires_at'].toString().length - 4),
          token: response.data['request_token']);

      print("Request Token");
      print(requestToken!.token);
      print("Expires At");
      print(requestToken!.expiresAt);
    } catch (e) {
      print(e);
      httpError = true;
      loading = false;
    }
  }

  @action
  Future<bool> deleteSession() async {
    loading = true;
    final response = await deleteData(
        path: "/authentication/session", parameters: {"session_id": sessionId});

    if (response.data['success']) {
      print("Deleted session $sessionId");
      sessionId = null;
      prefs!.remove("sessionId");
      loading = false;
      return true;
    }
    loading = false;
    return false;
  }

  //*----------------------------------------------------

  //*Get or Change User related content -----------------

  @action
  Future<void> getUserDetails() async {
    loading = true;
    if (sessionId == null) {
      return;
    }
    final response = await fetchData(
        path: "/account", parameters: {"session_id": sessionId});
    final data = response.data;
    try {
      String? avatar;
      AvatarType? avatarType;
      if (data['avatar'] != null &&
          data['avatar']['tmdb'] != null &&
          data['avatar']['tmdb']['avatar_path'] != null) {
        avatar = data['avatar']['tmdb']['avatar_path'];
        avatarType = AvatarType.tmdb;
      } else if (data['avatar'] != null &&
          data['avatar']['gravatar'] != null &&
          data['avatar']['gravatar']['hash'] != null) {
        avatar = data['avatar']['gravatar']['hash'];
        avatarType = AvatarType.gravatar;
      }
      user = User(
        avatarType: avatarType,
        avatar: avatar,
        id: data['id'],
        includeAdult: data['include_adult'],
        iso_3166_1: data['iso_3166_1'],
        iso_639_1: data['iso_639_1'],
        name: data['name'],
        username: data['username'],
      );
      loading = false;
    } catch (e) {
      error = true;
      loading = false;
      print(e);
    }
  }

  //TODO
  @action
  void getCreatedLists() {}

  @action
  Future<void> getFavoriteContent(
      {required CustomContentType mediaType,
      required int page,
      bool reset = false}) async {
    String contentType = mediaType == CustomContentType.MOVIE ? "movies" : "tv";

    final response = await fetchData(
        path: "/account/${user!.id}/favorite/$contentType",
        parameters: {
          "session_id": sessionId,
          "language": settingsStore.language,
          "page": page
        });

    try {
      switch (mediaType) {
        case CustomContentType.MOVIE:
          favoriteMoviesMaxPages = response.data['total_pages'];
          if (reset) {
            favoriteMovies.clear();
          }
          print("Geeting Favorite Movies...");
          favoriteMovies.addAll(response.data['results'].map<SimpleMovie>((e) {
            return SimpleMovie(
                genreIds: e['genre_ids'],
                id: e['id'],
                adult: e['adult'],
                popularity: e['popularity'],
                voteAverage: e['vote_average'],
                originalLanguage: e['original_language'],
                title: e['title'],
                overview: e['overview'],
                backdropPath: e['backdrop_path'],
                posterPath: e['poster_path'],
                releaseDate: e['release_date']);
          }).toList());
          print("Movies: $favoriteMovies");
          break;
        case CustomContentType.TVSHOW:
          favoriteTvShowsMaxPages = response.data['total_pages'];
          print("Geeting Favorite TvShows...");
          if (reset) {
            favoriteTvShows.clear();
          }
          favoriteTvShows.addAll(response.data['results'].map<SimpleMovie>((e) {
            return SimpleMovie(
                genreIds: e['genre_ids'],
                id: e['id'],
                adult: false,
                popularity: e['popularity'],
                voteAverage: e['vote_average'],
                originalLanguage: e['original_language'],
                title: e['name'],
                overview: e['overview'],
                backdropPath: e['backdrop_path'],
                posterPath: e['poster_path'],
                releaseDate: e['first_air_date']);
          }).toList());
          print("TVShows: $favoriteTvShows");

          break;
      }
    } catch (e) {
      print(e);
      error = true;
    }
  }

  @action
  Future<Map<String, dynamic>> markContentAsFavorite(
      {required CustomContentType mediaType,
      required bool favorite,
      required int mediaID}) async {
    try {
      final response =
          await postData(path: "/account/${user!.id}/favorite", data: {
        "media_type": mediaType == CustomContentType.MOVIE ? 'movie' : 'tv',
        'favorite': favorite,
        'media_id': mediaID,
      }, parameters: {
        'session_id': sessionId
      });
      return response.data;
    } catch (e) {
      httpError = true;
      return {'error': e};
    }
  }

  ObservableList<SimpleMovie> ratedMovies = ObservableList<SimpleMovie>();
  ObservableList<SimpleMovie> ratedTvShows = ObservableList<SimpleMovie>();
  int ratedMoviesMaxPages = 0;
  int ratedTvShowsMaxPages = 0;

  //TODO
  @action
  Future<void> getRatedContent(
      {required CustomContentType mediaType,
      required int page,
      bool reset = false}) async {
    //movies and tvShows

    String contentType = mediaType == CustomContentType.MOVIE ? "movies" : "tv";

    final response = await fetchData(
        path: "/account/${user!.id}/rated/$contentType",
        parameters: {
          "session_id": sessionId,
          "language": settingsStore.language,
          "page": page
        });

    try {
      switch (mediaType) {
        case CustomContentType.MOVIE:
          ratedMoviesMaxPages = response.data['total_pages'];
          if (reset) {
            ratedMovies.clear();
          }
          print("Geeting Rated Movies...");
          ratedMovies.addAll(response.data['results'].map<SimpleMovie>((e) {
            return SimpleMovie(
                genreIds: e['genre_ids'],
                id: e['id'],
                adult: e['adult'],
                popularity: e['popularity'],
                voteAverage: e['vote_average'],
                originalLanguage: e['original_language'],
                title: e['title'],
                overview: e['overview'],
                backdropPath: e['backdrop_path'],
                posterPath: e['poster_path'],
                releaseDate: e['release_date'],
                rating: e['rating']);
          }).toList());
          print("Movies: $ratedMovies");
          break;
        case CustomContentType.TVSHOW:
          ratedTvShowsMaxPages = response.data['total_pages'];
          print("Geeting Rated TvShows...");
          if (reset) {
            ratedTvShows.clear();
          }
          ratedTvShows.addAll(response.data['results'].map<SimpleMovie>((e) {
            return SimpleMovie(
                genreIds: e['genre_ids'],
                id: e['id'],
                adult: false,
                popularity: e['popularity'],
                voteAverage: e['vote_average'],
                originalLanguage: e['original_language'],
                title: e['name'],
                overview: e['overview'],
                backdropPath: e['backdrop_path'],
                posterPath: e['poster_path'],
                releaseDate: e['first_air_date'],
                rating: e['rating']);
          }).toList());
          print("TVShows: $ratedTvShows");

          break;
      }
    } catch (e) {
      print(e);
      error = true;
    }
  }

  //TODO
  @action
  void getRatedEpisodes() {
    //need to think how this will be displayed
  }

  @action
  Future<Map<String, dynamic>> rateContent(
      {required num rating,
      required CustomContentType mediaType,
      required int mediaID,
      bool guest = false}) async {
    //movies and tvShows
    final String content =
        mediaType == CustomContentType.MOVIE ? 'movie' : 'tv';
    try {
      await postData(
        path: "/$content/$mediaID/rating",
        parameters: {
          "session_id": sessionId,
        },
        data: {"value": rating},
      );

      return {"message": ''};
    } catch (e) {
      return {'error': e};
    }
  }

  //TODO
  @action
  void rateEpisode({required num rating, bool guest = false}) {}

  ObservableList<SimpleMovie> movieWatchList = ObservableList<SimpleMovie>();
  ObservableList<SimpleMovie> tvShowWatchList = ObservableList<SimpleMovie>();
  int movieWatchListTotalPages = 0;
  int tvShowWatchListTotalPages = 0;

  //TODO
  @action
  Future<void> getWatchList(
      {required CustomContentType mediaType,
      required int page,
      bool reset = false}) async {
    String contentType = mediaType == CustomContentType.MOVIE ? "movies" : "tv";

    try {
      final response = await fetchData(
          path: "/account/${user!.id}/watchlist/$contentType",
          parameters: {
            "session_id": sessionId,
            "language": settingsStore.language,
            "page": page
          });

      switch (mediaType) {
        case CustomContentType.MOVIE:
          if (reset) {
            movieWatchList.clear();
          }
          print("Geeting Movies WatchList...");
          movieWatchListTotalPages = response.data['total_pages'];
          movieWatchList.addAll(response.data['results'].map<SimpleMovie>((e) {
            return SimpleMovie(
                genreIds: e['genre_ids'],
                id: e['id'],
                adult: e['adult'],
                popularity: e['popularity'],
                voteAverage: e['vote_average'],
                originalLanguage: e['original_language'],
                title: e['title'],
                overview: e['overview'],
                backdropPath: e['backdrop_path'],
                posterPath: e['poster_path'],
                releaseDate: e['release_date']);
          }).toList());
          break;
        case CustomContentType.TVSHOW:
          if (reset) {
            tvShowWatchList.clear();
          }
          print("Geeting TvShow WatchList...");
          tvShowWatchListTotalPages = response.data['total_pages'];

          tvShowWatchList.addAll(response.data['results'].map<SimpleMovie>((e) {
            return SimpleMovie(
                genreIds: e['genre_ids'],
                id: e['id'],
                adult: false,
                popularity: e['popularity'],
                voteAverage: e['vote_average'],
                originalLanguage: e['original_language'],
                title: e['name'],
                overview: e['overview'],
                backdropPath: e['backdrop_path'],
                posterPath: e['poster_path'],
                releaseDate: e['first_air_date']);
          }).toList());
          break;
      }
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<Map<String, dynamic>> addToWatchList(
      {required CustomContentType mediaType,
      required bool watchlist,
      required int mediaID}) async {
    //movies and tvShows
    try {
      final response =
          await postData(path: "/account/${user!.id}/watchlist", data: {
        "media_type": mediaType == CustomContentType.MOVIE ? 'movie' : 'tv',
        'watchlist': watchlist,
        'media_id': mediaID,
      }, parameters: {
        'session_id': sessionId
      });

      return response.data;
    } catch (e) {
      httpError = true;
      return {'error': e};
    }
  }

  @action
  void guestGetRatedContent(CustomContentType mediaType) {
    //movies and tvShows
  }

  @action
  void guestGetRatedEpisodes() {}

  //! Deletions -----------------------------

  @action
  Future<Map<String, dynamic>> deleteRateContent(
      {required CustomContentType mediaType,
      required int mediaID,
      bool guest = false}) async {
    //movies and tvShows
    final String content =
        mediaType == CustomContentType.MOVIE ? 'movie' : 'tv';
    try {
      await deleteData(
        path: "/$content/$mediaID/rating",
        parameters: {
          "session_id": sessionId,
        },
      );

      return {"message": ""};
    } catch (e) {
      return {'error': e};
    }
  }

  @action
  void deleteRateEpisode({required num rating, bool guest = false}) {}

  //!----------------------------------------

  //*----------------------------------------------------

}
