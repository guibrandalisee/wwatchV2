import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wwatch/Shared/models/user_model.dart';
part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  String token = dotenv.env['TOKEN']!;
  final SharedPreferences? prefs;

  _UserStoreBase({required this.prefs});

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
  String loginErrorMessage = "";

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

  //*Manage Login in TMDB servers ------------------------

  @action
  void createGuestSession() {}

  @action
  Future<void> createUserSession(
      {required String username, required String password}) async {
    authError = false;
    if (requestToken == null || requestToken!.token.isEmpty) {
      loading = false;
      httpError = true;
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
  void deleteSession() {}

  //*----------------------------------------------------

  //*Get or Change User related content -----------------

  @action
  void getUserDetails() {}

  @action
  void getCreatedLists() {}

  @action
  void getFavoriteContent({required ContentType mediaType}) {
    //movies and tvShows
  }

  @action
  void markContentAsFavorite(
      {required ContentType mediaType, required bool favorite}) {
    //movies and tvShows
  }

  @action
  void getRatedContent({required ContentType mediaType}) {
    //movies and tvShows
  }

  @action
  void getRatedEpisodes() {
    //need to think how this will be displayed
  }

  @action
  void rateContent(
      {required num rating,
      required ContentType mediaType,
      bool guest = false}) {
    //movies and tvShows
  }

  @action
  void rateEpisode({required num rating, bool guest = false}) {}

  @action
  void getWatchList() {
    //movies and tvShows
  }

  @action
  void addToWatchList(
      {required ContentType mediaType, required bool watchlist}) {
    //movies and tvShows
  }

  @action
  void guestGetRatedContent(ContentType mediaType) {
    //movies and tvShows
  }

  @action
  void guestGetRatedEpisodes() {}

  //! Deletions -----------------------------

  @action
  void deleteRateContent(
      {required num rating,
      required ContentType mediaType,
      bool guest = false}) {
    //movies and tvShows
  }

  @action
  void deleteRateEpisode({required num rating, bool guest = false}) {}

  //!----------------------------------------

  //*----------------------------------------------------

}
