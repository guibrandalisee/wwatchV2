// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStoreBase, Store {
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
  void deleteSession() {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.deleteSession');
    try {
      return super.deleteSession();
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getUserDetails() {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.getUserDetails');
    try {
      return super.getUserDetails();
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
  void getFavoriteContent({required ContentType mediaType}) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.getFavoriteContent');
    try {
      return super.getFavoriteContent(mediaType: mediaType);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void markContentAsFavorite(
      {required ContentType mediaType, required bool favorite}) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.markContentAsFavorite');
    try {
      return super
          .markContentAsFavorite(mediaType: mediaType, favorite: favorite);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getRatedContent({required ContentType mediaType}) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.getRatedContent');
    try {
      return super.getRatedContent(mediaType: mediaType);
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
  void rateContent(
      {required num rating,
      required ContentType mediaType,
      bool guest = false}) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.rateContent');
    try {
      return super
          .rateContent(rating: rating, mediaType: mediaType, guest: guest);
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
  void getWatchList() {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.getWatchList');
    try {
      return super.getWatchList();
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addToWatchList(
      {required ContentType mediaType, required bool watchlist}) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.addToWatchList');
    try {
      return super.addToWatchList(mediaType: mediaType, watchlist: watchlist);
    } finally {
      _$_UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void guestGetRatedContent(ContentType mediaType) {
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
  void deleteRateContent(
      {required num rating,
      required ContentType mediaType,
      bool guest = false}) {
    final _$actionInfo = _$_UserStoreBaseActionController.startAction(
        name: '_UserStoreBase.deleteRateContent');
    try {
      return super.deleteRateContent(
          rating: rating, mediaType: mediaType, guest: guest);
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
httpError: ${httpError},
requestToken: ${requestToken},
loading: ${loading},
sessionId: ${sessionId},
authError: ${authError},
loggedIn: ${loggedIn},
loginErrorMessage: ${loginErrorMessage}
    ''';
  }
}
