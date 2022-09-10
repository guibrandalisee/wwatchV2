// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStoreBase, Store {
  late final _$userAtom = Atom(name: '_UserStoreBase.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$httpErrorAtom =
      Atom(name: '_UserStoreBase.httpError', context: context);

  @override
  bool get httpError {
    _$httpErrorAtom.reportRead();
    return super.httpError;
  }

  @override
  set httpError(bool value) {
    _$httpErrorAtom.reportWrite(value, super.httpError, () {
      super.httpError = value;
    });
  }

  late final _$requestTokenAtom =
      Atom(name: '_UserStoreBase.requestToken', context: context);

  @override
  RequestToken? get requestToken {
    _$requestTokenAtom.reportRead();
    return super.requestToken;
  }

  @override
  set requestToken(RequestToken? value) {
    _$requestTokenAtom.reportWrite(value, super.requestToken, () {
      super.requestToken = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_UserStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$sessionIdAtom =
      Atom(name: '_UserStoreBase.sessionId', context: context);

  @override
  String? get sessionId {
    _$sessionIdAtom.reportRead();
    return super.sessionId;
  }

  @override
  set sessionId(String? value) {
    _$sessionIdAtom.reportWrite(value, super.sessionId, () {
      super.sessionId = value;
    });
  }

  late final _$authErrorAtom =
      Atom(name: '_UserStoreBase.authError', context: context);

  @override
  bool get authError {
    _$authErrorAtom.reportRead();
    return super.authError;
  }

  @override
  set authError(bool value) {
    _$authErrorAtom.reportWrite(value, super.authError, () {
      super.authError = value;
    });
  }

  late final _$loggedInAtom =
      Atom(name: '_UserStoreBase.loggedIn', context: context);

  @override
  bool get loggedIn {
    _$loggedInAtom.reportRead();
    return super.loggedIn;
  }

  @override
  set loggedIn(bool value) {
    _$loggedInAtom.reportWrite(value, super.loggedIn, () {
      super.loggedIn = value;
    });
  }

  late final _$errorAtom = Atom(name: '_UserStoreBase.error', context: context);

  @override
  bool get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(bool value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$loginErrorMessageAtom =
      Atom(name: '_UserStoreBase.loginErrorMessage', context: context);

  @override
  String get loginErrorMessage {
    _$loginErrorMessageAtom.reportRead();
    return super.loginErrorMessage;
  }

  @override
  set loginErrorMessage(String value) {
    _$loginErrorMessageAtom.reportWrite(value, super.loginErrorMessage, () {
      super.loginErrorMessage = value;
    });
  }

  late final _$favoriteMoviesAtom =
      Atom(name: '_UserStoreBase.favoriteMovies', context: context);

  @override
  ObservableList<SimpleMovie> get favoriteMovies {
    _$favoriteMoviesAtom.reportRead();
    return super.favoriteMovies;
  }

  @override
  set favoriteMovies(ObservableList<SimpleMovie> value) {
    _$favoriteMoviesAtom.reportWrite(value, super.favoriteMovies, () {
      super.favoriteMovies = value;
    });
  }

  late final _$favoriteMoviesMaxPagesAtom =
      Atom(name: '_UserStoreBase.favoriteMoviesMaxPages', context: context);

  @override
  int get favoriteMoviesMaxPages {
    _$favoriteMoviesMaxPagesAtom.reportRead();
    return super.favoriteMoviesMaxPages;
  }

  @override
  set favoriteMoviesMaxPages(int value) {
    _$favoriteMoviesMaxPagesAtom
        .reportWrite(value, super.favoriteMoviesMaxPages, () {
      super.favoriteMoviesMaxPages = value;
    });
  }

  late final _$favoriteTvShowsAtom =
      Atom(name: '_UserStoreBase.favoriteTvShows', context: context);

  @override
  ObservableList<SimpleMovie> get favoriteTvShows {
    _$favoriteTvShowsAtom.reportRead();
    return super.favoriteTvShows;
  }

  @override
  set favoriteTvShows(ObservableList<SimpleMovie> value) {
    _$favoriteTvShowsAtom.reportWrite(value, super.favoriteTvShows, () {
      super.favoriteTvShows = value;
    });
  }

  late final _$favoriteTvShowsMaxPagesAtom =
      Atom(name: '_UserStoreBase.favoriteTvShowsMaxPages', context: context);

  @override
  int get favoriteTvShowsMaxPages {
    _$favoriteTvShowsMaxPagesAtom.reportRead();
    return super.favoriteTvShowsMaxPages;
  }

  @override
  set favoriteTvShowsMaxPages(int value) {
    _$favoriteTvShowsMaxPagesAtom
        .reportWrite(value, super.favoriteTvShowsMaxPages, () {
      super.favoriteTvShowsMaxPages = value;
    });
  }

  late final _$fetchDataAsyncAction =
      AsyncAction('_UserStoreBase.fetchData', context: context);

  @override
  Future<dynamic> fetchData(
      {required String path, required Map<String, dynamic> parameters}) {
    return _$fetchDataAsyncAction
        .run(() => super.fetchData(path: path, parameters: parameters));
  }

  late final _$createUserSessionAsyncAction =
      AsyncAction('_UserStoreBase.createUserSession', context: context);

  @override
  Future<void> createUserSession(
      {required String username, required String password}) {
    return _$createUserSessionAsyncAction.run(
        () => super.createUserSession(username: username, password: password));
  }

  late final _$getRequestTokenAsyncAction =
      AsyncAction('_UserStoreBase.getRequestToken', context: context);

  @override
  Future<void> getRequestToken() {
    return _$getRequestTokenAsyncAction.run(() => super.getRequestToken());
  }

  late final _$deleteSessionAsyncAction =
      AsyncAction('_UserStoreBase.deleteSession', context: context);

  @override
  Future<bool> deleteSession() {
    return _$deleteSessionAsyncAction.run(() => super.deleteSession());
  }

  late final _$getUserDetailsAsyncAction =
      AsyncAction('_UserStoreBase.getUserDetails', context: context);

  @override
  Future<void> getUserDetails() {
    return _$getUserDetailsAsyncAction.run(() => super.getUserDetails());
  }

  late final _$getFavoriteContentAsyncAction =
      AsyncAction('_UserStoreBase.getFavoriteContent', context: context);

  @override
  Future<void> getFavoriteContent(
      {required CustomContentType mediaType,
      required int page,
      bool reset = false}) {
    return _$getFavoriteContentAsyncAction.run(() => super
        .getFavoriteContent(mediaType: mediaType, page: page, reset: reset));
  }

  late final _$markContentAsFavoriteAsyncAction =
      AsyncAction('_UserStoreBase.markContentAsFavorite', context: context);

  @override
  Future<Map<String, dynamic>> markContentAsFavorite(
      {required CustomContentType mediaType,
      required bool favorite,
      required int mediaID}) {
    return _$markContentAsFavoriteAsyncAction.run(() => super
        .markContentAsFavorite(
            mediaType: mediaType, favorite: favorite, mediaID: mediaID));
  }

  late final _$getRatedContentAsyncAction =
      AsyncAction('_UserStoreBase.getRatedContent', context: context);

  @override
  Future<void> getRatedContent(
      {required CustomContentType mediaType,
      required int page,
      bool reset = false}) {
    return _$getRatedContentAsyncAction.run(() =>
        super.getRatedContent(mediaType: mediaType, page: page, reset: reset));
  }

  late final _$rateContentAsyncAction =
      AsyncAction('_UserStoreBase.rateContent', context: context);

  @override
  Future<Map<String, dynamic>> rateContent(
      {required num rating,
      required CustomContentType mediaType,
      required int mediaID,
      bool guest = false}) {
    return _$rateContentAsyncAction.run(() => super.rateContent(
        rating: rating, mediaType: mediaType, mediaID: mediaID, guest: guest));
  }

  late final _$getWatchListAsyncAction =
      AsyncAction('_UserStoreBase.getWatchList', context: context);

  @override
  Future<void> getWatchList(
      {required CustomContentType mediaType,
      required int page,
      bool reset = false}) {
    return _$getWatchListAsyncAction.run(() =>
        super.getWatchList(mediaType: mediaType, page: page, reset: reset));
  }

  late final _$addToWatchListAsyncAction =
      AsyncAction('_UserStoreBase.addToWatchList', context: context);

  @override
  Future<Map<String, dynamic>> addToWatchList(
      {required CustomContentType mediaType,
      required bool watchlist,
      required int mediaID}) {
    return _$addToWatchListAsyncAction.run(() => super.addToWatchList(
        mediaType: mediaType, watchlist: watchlist, mediaID: mediaID));
  }

  late final _$deleteRateContentAsyncAction =
      AsyncAction('_UserStoreBase.deleteRateContent', context: context);

  @override
  Future<Map<String, dynamic>> deleteRateContent(
      {required CustomContentType mediaType,
      required int mediaID,
      bool guest = false}) {
    return _$deleteRateContentAsyncAction.run(() => super.deleteRateContent(
        mediaType: mediaType, mediaID: mediaID, guest: guest));
  }

  late final _$_UserStoreBaseActionController =
      ActionController(name: '_UserStoreBase', context: context);

  @override
  void createGuestSession() {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.createGuestSession');
    try {
      return super.createGuestSession();
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getCreatedLists() {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.getCreatedLists');
    try {
      return super.getCreatedLists();
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getRatedEpisodes() {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.getRatedEpisodes');
    try {
      return super.getRatedEpisodes();
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void rateEpisode({required num rating, bool guest = false}) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.rateEpisode');
    try {
      return super.rateEpisode(rating: rating, guest: guest);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void guestGetRatedContent(CustomContentType mediaType) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.guestGetRatedContent');
    try {
      return super.guestGetRatedContent(mediaType);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void guestGetRatedEpisodes() {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.guestGetRatedEpisodes');
    try {
      return super.guestGetRatedEpisodes();
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteRateEpisode({required num rating, bool guest = false}) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.deleteRateEpisode');
    try {
      return super.deleteRateEpisode(rating: rating, guest: guest);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
httpError: ${httpError},
requestToken: ${requestToken},
loading: ${loading},
sessionId: ${sessionId},
authError: ${authError},
loggedIn: ${loggedIn},
error: ${error},
loginErrorMessage: ${loginErrorMessage},
favoriteMovies: ${favoriteMovies},
favoriteMoviesMaxPages: ${favoriteMoviesMaxPages},
favoriteTvShows: ${favoriteTvShows},
favoriteTvShowsMaxPages: ${favoriteTvShowsMaxPages}
    ''';
  }
}
