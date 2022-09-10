// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MovieStore on _MovieStoreBase, Store {
  late final _$didChangeAtom =
      Atom(name: '_MovieStoreBase.didChange', context: context);

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

  late final _$pageAtom = Atom(name: '_MovieStoreBase.page', context: context);

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

  late final _$languageAtom =
      Atom(name: '_MovieStoreBase.language', context: context);

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

  late final _$moviesAtom =
      Atom(name: '_MovieStoreBase.movies', context: context);

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

  late final _$errorAtom =
      Atom(name: '_MovieStoreBase.error', context: context);

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

  late final _$totalPagesAtom =
      Atom(name: '_MovieStoreBase.totalPages', context: context);

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

  late final _$movieAtom =
      Atom(name: '_MovieStoreBase.movie', context: context);

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

  late final _$searchStringAtom =
      Atom(name: '_MovieStoreBase.searchString', context: context);

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

  late final _$temporarySearchStringAtom =
      Atom(name: '_MovieStoreBase.temporarySearchString', context: context);

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

  late final _$emptyAtom =
      Atom(name: '_MovieStoreBase.empty', context: context);

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

  late final _$recommendationsAtom =
      Atom(name: '_MovieStoreBase.recommendations', context: context);

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

  late final _$seasonAtom =
      Atom(name: '_MovieStoreBase.season', context: context);

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

  late final _$loadingSeasonAtom =
      Atom(name: '_MovieStoreBase.loadingSeason', context: context);

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

  late final _$movieAvaliableWatchProvidersAtom = Atom(
      name: '_MovieStoreBase.movieAvaliableWatchProviders', context: context);

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

  late final _$watchProviderErrorAtom =
      Atom(name: '_MovieStoreBase.watchProviderError', context: context);

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

  late final _$episodeAtom =
      Atom(name: '_MovieStoreBase.episode', context: context);

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

  late final _$loadingEpisodeAtom =
      Atom(name: '_MovieStoreBase.loadingEpisode', context: context);

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

  late final _$episodeErrorAtom =
      Atom(name: '_MovieStoreBase.episodeError', context: context);

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

  late final _$personAtom =
      Atom(name: '_MovieStoreBase.person', context: context);

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

  late final _$allCountriesWatchProvidersAtom = Atom(
      name: '_MovieStoreBase.allCountriesWatchProviders', context: context);

  @override
  AllCountriesWatchProviders? get allCountriesWatchProviders {
    _$allCountriesWatchProvidersAtom.reportRead();
    return super.allCountriesWatchProviders;
  }

  @override
  set allCountriesWatchProviders(AllCountriesWatchProviders? value) {
    _$allCountriesWatchProvidersAtom
        .reportWrite(value, super.allCountriesWatchProviders, () {
      super.allCountriesWatchProviders = value;
    });
  }

  late final _$fetchDataAsyncAction =
      AsyncAction('_MovieStoreBase.fetchData', context: context);

  @override
  Future<dynamic> fetchData(
      {required String path, required Map<String, dynamic> parameters}) {
    return _$fetchDataAsyncAction
        .run(() => super.fetchData(path: path, parameters: parameters));
  }

  late final _$getPopularContentAsyncAction =
      AsyncAction('_MovieStoreBase.getPopularContent', context: context);

  @override
  Future<void> getPopularContent() {
    return _$getPopularContentAsyncAction.run(() => super.getPopularContent());
  }

  late final _$getMoreContentAsyncAction =
      AsyncAction('_MovieStoreBase.getMoreContent', context: context);

  @override
  Future<void> getMoreContent() {
    return _$getMoreContentAsyncAction.run(() => super.getMoreContent());
  }

  late final _$getSingleMovieAsyncAction =
      AsyncAction('_MovieStoreBase.getSingleMovie', context: context);

  @override
  Future<void> getSingleMovie(int id, CustomContentType contentType) {
    return _$getSingleMovieAsyncAction
        .run(() => super.getSingleMovie(id, contentType));
  }

  late final _$searchAsyncAction =
      AsyncAction('_MovieStoreBase.search', context: context);

  @override
  Future<void> search() {
    return _$searchAsyncAction.run(() => super.search());
  }

  late final _$getRecommendationsAsyncAction =
      AsyncAction('_MovieStoreBase.getRecommendations', context: context);

  @override
  Future<void> getRecommendations(int id) {
    return _$getRecommendationsAsyncAction
        .run(() => super.getRecommendations(id));
  }

  late final _$getEpisodeAsyncAction =
      AsyncAction('_MovieStoreBase.getEpisode', context: context);

  @override
  Future<void> getEpisode(int tvId, int seasonNumber, int episodeNumber) {
    return _$getEpisodeAsyncAction
        .run(() => super.getEpisode(tvId, seasonNumber, episodeNumber));
  }

  late final _$getPersonAsyncAction =
      AsyncAction('_MovieStoreBase.getPerson', context: context);

  @override
  Future<void> getPerson(int personId) {
    return _$getPersonAsyncAction.run(() => super.getPerson(personId));
  }

  late final _$_MovieStoreBaseActionController =
      ActionController(name: '_MovieStoreBase', context: context);

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
  void getAllCountriesWatchProviders(Map<String, dynamic> data) {
    final _$actionInfo = _$_MovieStoreBaseActionController.startAction(
        name: '_MovieStoreBase.getAllCountriesWatchProviders');
    try {
      return super.getAllCountriesWatchProviders(data);
    } finally {
      _$_MovieStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateFavorite(bool value) {
    final _$actionInfo = _$_MovieStoreBaseActionController.startAction(
        name: '_MovieStoreBase.updateFavorite');
    try {
      return super.updateFavorite(value);
    } finally {
      _$_MovieStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateWatchlist(bool value) {
    final _$actionInfo = _$_MovieStoreBaseActionController.startAction(
        name: '_MovieStoreBase.updateWatchlist');
    try {
      return super.updateWatchlist(value);
    } finally {
      _$_MovieStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateRate(num? value) {
    final _$actionInfo = _$_MovieStoreBaseActionController.startAction(
        name: '_MovieStoreBase.updateRate');
    try {
      return super.updateRate(value);
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
person: ${person},
allCountriesWatchProviders: ${allCountriesWatchProviders}
    ''';
  }
}
