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
  ObservableList<SimpleMovie> favoriteTvShows = ObservableList();

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
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json;charset=utf-8'
      },
    );

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
      {required String path, required Map<String, dynamic> data}) async {
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
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json;charset=utf-8'
      },
    );

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

  //!Have to test
  @action
  Future<void> getFavoriteContent(
      {required CustomContentType mediaType, required int page}) async {
    String contentType = mediaType == CustomContentType.MOVIE ? "movie" : "tv";

    final response = await fetchData(
        path: "/account/${user!.id}/favorite/$contentType",
        parameters: {
          "session__id": sessionId,
          "laguage": settingsStore.language,
          "page": page
        });

    try {
      switch (mediaType) {
        case CustomContentType.MOVIE:
          favoriteMoviesMaxPages = response.data['totalPages'];
          favoriteMovies = response.data['results'].map<SimpleMovie>((e) {
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
          }).toList();
          break;
        case CustomContentType.TVSHOW:
          favoriteTvShowsMaxPages = response.data['totalPages'];
          favoriteTvShows = response.data['results'].map<SimpleMovie>((e) {
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
          }).toList();
          break;
      }
    } catch (e) {
      print(e);
      error = true;
    }
  }

  //!Have to test
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
      });
      return response.data;
    } catch (e) {
      httpError = true;
      return {'error': e};
    }
  }

  //TODO
  @action
  void getRatedContent({required CustomContentType mediaType}) {
    //movies and tvShows
  }

  //TODO
  @action
  void getRatedEpisodes() {
    //need to think how this will be displayed
  }

  //TODO
  @action
  void rateContent(
      {required num rating,
      required CustomContentType mediaType,
      bool guest = false}) {
    //movies and tvShows
  }

  //TODO
  @action
  void rateEpisode({required num rating, bool guest = false}) {}

  //TODO
  @action
  void getWatchList() {
    //movies and tvShows
  }

  //!Have to test
  @action
  Future<Map<String, dynamic>> addToWatchList(
      {required CustomContentType mediaType,
      required bool watchlist,
      required int accID,
      required int mediaID}) async {
    //movies and tvShows
    try {
      final response = await postData(path: "/account/$accID/favorite", data: {
        "media_type": mediaType == CustomContentType.MOVIE ? 'movie' : 'tv',
        'favorite': watchlist,
        'media_id': mediaID,
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
  void deleteRateContent(
      {required num rating,
      required CustomContentType mediaType,
      bool guest = false}) {
    //movies and tvShows
  }

  @action
  void deleteRateEpisode({required num rating, bool guest = false}) {}

  //!----------------------------------------

  //*----------------------------------------------------

}
