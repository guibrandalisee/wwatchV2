// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovieStore on _MovieStoreBase, Store {
  final _$didChangeAtom = Atom(name: '_MovieStoreBase.didChange');

  @override
  bool get didChange {
    _$didChangeAtom.reportRead();
    return super.didChange;
  }

  @override
  set didChange(bool value) {
    _$didChangeAtom.reportWrite(value, super.didChange, () {
      super.didChange = value;
    });
  }

  final _$pageAtom = Atom(name: '_MovieStoreBase.page');

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$languageAtom = Atom(name: '_MovieStoreBase.language');

  @override
  String get language {
    _$languageAtom.reportRead();
    return super.language;
  }

  @override
  set language(String value) {
    _$languageAtom.reportWrite(value, super.language, () {
      super.language = value;
    });
  }

  final _$moviesAtom = Atom(name: '_MovieStoreBase.movies');

  @override
  List<SimpleMovie> get movies {
    _$moviesAtom.reportRead();
    return super.movies;
  }

  @override
  set movies(List<SimpleMovie> value) {
    _$moviesAtom.reportWrite(value, super.movies, () {
      super.movies = value;
    });
  }

  final _$errorAtom = Atom(name: '_MovieStoreBase.error');

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

  final _$totalPagesAtom = Atom(name: '_MovieStoreBase.totalPages');

  @override
  int? get totalPages {
    _$totalPagesAtom.reportRead();
    return super.totalPages;
  }

  @override
  set totalPages(int? value) {
    _$totalPagesAtom.reportWrite(value, super.totalPages, () {
      super.totalPages = value;
    });
  }

  final _$movieAtom = Atom(name: '_MovieStoreBase.movie');

  @override
  CompleteMovie? get movie {
    _$movieAtom.reportRead();
    return super.movie;
  }

  @override
  set movie(CompleteMovie? value) {
    _$movieAtom.reportWrite(value, super.movie, () {
      super.movie = value;
    });
  }

  final _$searchStringAtom = Atom(name: '_MovieStoreBase.searchString');

  @override
  String get searchString {
    _$searchStringAtom.reportRead();
    return super.searchString;
  }

  @override
  set searchString(String value) {
    _$searchStringAtom.reportWrite(value, super.searchString, () {
      super.searchString = value;
    });
  }

  final _$temporarySearchStringAtom =
      Atom(name: '_MovieStoreBase.temporarySearchString');

  @override
  String get temporarySearchString {
    _$temporarySearchStringAtom.reportRead();
    return super.temporarySearchString;
  }

  @override
  set temporarySearchString(String value) {
    _$temporarySearchStringAtom.reportWrite(value, super.temporarySearchString,
        () {
      super.temporarySearchString = value;
    });
  }

  final _$emptyAtom = Atom(name: '_MovieStoreBase.empty');

  @override
  bool get empty {
    _$emptyAtom.reportRead();
    return super.empty;
  }

  @override
  set empty(bool value) {
    _$emptyAtom.reportWrite(value, super.empty, () {
      super.empty = value;
    });
  }

  final _$recommendationsAtom = Atom(name: '_MovieStoreBase.recommendations');

  @override
  List<SimpleMovie> get recommendations {
    _$recommendationsAtom.reportRead();
    return super.recommendations;
  }

  @override
  set recommendations(List<SimpleMovie> value) {
    _$recommendationsAtom.reportWrite(value, super.recommendations, () {
      super.recommendations = value;
    });
  }

  final _$seasonAtom = Atom(name: '_MovieStoreBase.season');

  @override
  TvSeason? get season {
    _$seasonAtom.reportRead();
    return super.season;
  }

  @override
  set season(TvSeason? value) {
    _$seasonAtom.reportWrite(value, super.season, () {
      super.season = value;
    });
  }

  final _$loadingSeasonAtom = Atom(name: '_MovieStoreBase.loadingSeason');

  @override
  bool get loadingSeason {
    _$loadingSeasonAtom.reportRead();
    return super.loadingSeason;
  }

  @override
  set loadingSeason(bool value) {
    _$loadingSeasonAtom.reportWrite(value, super.loadingSeason, () {
      super.loadingSeason = value;
    });
  }

  final _$movieAvaliableWatchProvidersAtom =
      Atom(name: '_MovieStoreBase.movieAvaliableWatchProviders');

  @override
  MovieAvaliableWatchProviders? get movieAvaliableWatchProviders {
    _$movieAvaliableWatchProvidersAtom.reportRead();
    return super.movieAvaliableWatchProviders;
  }

  @override
  set movieAvaliableWatchProviders(MovieAvaliableWatchProviders? value) {
    _$movieAvaliableWatchProvidersAtom
        .reportWrite(value, super.movieAvaliableWatchProviders, () {
      super.movieAvaliableWatchProviders = value;
    });
  }

  final _$watchProviderErrorAtom =
      Atom(name: '_MovieStoreBase.watchProviderError');

  @override
  bool get watchProviderError {
    _$watchProviderErrorAtom.reportRead();
    return super.watchProviderError;
  }

  @override
  set watchProviderError(bool value) {
    _$watchProviderErrorAtom.reportWrite(value, super.watchProviderError, () {
      super.watchProviderError = value;
    });
  }

  final _$episodeAtom = Atom(name: '_MovieStoreBase.episode');

  @override
  Episode? get episode {
    _$episodeAtom.reportRead();
    return super.episode;
  }

  @override
  set episode(Episode? value) {
    _$episodeAtom.reportWrite(value, super.episode, () {
      super.episode = value;
    });
  }

  final _$loadingEpisodeAtom = Atom(name: '_MovieStoreBase.loadingEpisode');

  @override
  bool get loadingEpisode {
    _$loadingEpisodeAtom.reportRead();
    return super.loadingEpisode;
  }

  @override
  set loadingEpisode(bool value) {
    _$loadingEpisodeAtom.reportWrite(value, super.loadingEpisode, () {
      super.loadingEpisode = value;
    });
  }

  final _$episodeErrorAtom = Atom(name: '_MovieStoreBase.episodeError');

  @override
  bool get episodeError {
    _$episodeErrorAtom.reportRead();
    return super.episodeError;
  }

  @override
  set episodeError(bool value) {
    _$episodeErrorAtom.reportWrite(value, super.episodeError, () {
      super.episodeError = value;
    });
  }

  final _$personAtom = Atom(name: '_MovieStoreBase.person');

  @override
  Person? get person {
    _$personAtom.reportRead();
    return super.person;
  }

  @override
  set person(Person? value) {
    _$personAtom.reportWrite(value, super.person, () {
      super.person = value;
    });
  }

  final _$fetchDataAsyncAction = AsyncAction('_MovieStoreBase.fetchData');

  @override
  Future<dynamic> fetchData(
      {required String path, required Map<String, dynamic> parameters}) {
    return _$fetchDataAsyncAction
        .run(() => super.fetchData(path: path, parameters: parameters));
  }

  final _$getPopularContentAsyncAction =
      AsyncAction('_MovieStoreBase.getPopularContent');

  @override
  Future<void> getPopularContent() {
    return _$getPopularContentAsyncAction.run(() => super.getPopularContent());
  }

  final _$getMoreContentAsyncAction =
      AsyncAction('_MovieStoreBase.getMoreContent');

  @override
  Future<void> getMoreContent() {
    return _$getMoreContentAsyncAction.run(() => super.getMoreContent());
  }

  final _$getSingleMovieAsyncAction =
      AsyncAction('_MovieStoreBase.getSingleMovie');

  @override
  Future<void> getSingleMovie(int id, int contentType) {
    return _$getSingleMovieAsyncAction
        .run(() => super.getSingleMovie(id, contentType));
  }

  final _$searchAsyncAction = AsyncAction('_MovieStoreBase.search');

  @override
  Future<void> search() {
    return _$searchAsyncAction.run(() => super.search());
  }

  final _$getRecommendationsAsyncAction =
      AsyncAction('_MovieStoreBase.getRecommendations');

  @override
  Future<void> getRecommendations(int id) {
    return _$getRecommendationsAsyncAction
        .run(() => super.getRecommendations(id));
  }

  final _$getEpisodeAsyncAction = AsyncAction('_MovieStoreBase.getEpisode');

  @override
  Future<void> getEpisode(int tvId, int seasonNumber, int episodeNumber) {
    return _$getEpisodeAsyncAction
        .run(() => super.getEpisode(tvId, seasonNumber, episodeNumber));
  }

  final _$getPersonAsyncAction = AsyncAction('_MovieStoreBase.getPerson');

  @override
  Future<void> getPerson(int personId) {
    return _$getPersonAsyncAction.run(() => super.getPerson(personId));
  }

  final _$_MovieStoreBaseActionController =
      ActionController(name: '_MovieStoreBase');

  @override
  void setSearch() {
    final _$actionInfo = _$_MovieStoreBaseActionController.startAction(
        name: '_MovieStoreBase.setSearch');
    try {
      return super.setSearch();
    } finally {
      _$_MovieStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
didChange: ${didChange},
page: ${page},
language: ${language},
movies: ${movies},
error: ${error},
totalPages: ${totalPages},
movie: ${movie},
searchString: ${searchString},
temporarySearchString: ${temporarySearchString},
empty: ${empty},
recommendations: ${recommendations},
season: ${season},
loadingSeason: ${loadingSeason},
movieAvaliableWatchProviders: ${movieAvaliableWatchProviders},
watchProviderError: ${watchProviderError},
episode: ${episode},
loadingEpisode: ${loadingEpisode},
episodeError: ${episodeError},
person: ${person}
    ''';
  }
}
