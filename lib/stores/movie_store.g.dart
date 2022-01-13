// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovieStore on _MovieStoreBase, Store {
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

  final _$countryAtom = Atom(name: '_MovieStoreBase.country');

  @override
  String get country {
    _$countryAtom.reportRead();
    return super.country;
  }

  @override
  set country(String value) {
    _$countryAtom.reportWrite(value, super.country, () {
      super.country = value;
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

  final _$backToTheTopVisibleAtom =
      Atom(name: '_MovieStoreBase.backToTheTopVisible');

  @override
  bool get backToTheTopVisible {
    _$backToTheTopVisibleAtom.reportRead();
    return super.backToTheTopVisible;
  }

  @override
  set backToTheTopVisible(bool value) {
    _$backToTheTopVisibleAtom.reportWrite(value, super.backToTheTopVisible, () {
      super.backToTheTopVisible = value;
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

  final _$selectedContentTypeAtom =
      Atom(name: '_MovieStoreBase.selectedContentType');

  @override
  int get selectedContentType {
    _$selectedContentTypeAtom.reportRead();
    return super.selectedContentType;
  }

  @override
  set selectedContentType(int value) {
    _$selectedContentTypeAtom.reportWrite(value, super.selectedContentType, () {
      super.selectedContentType = value;
    });
  }

  final _$similarMoviesAtom = Atom(name: '_MovieStoreBase.similarMovies');

  @override
  List<SimpleMovie> get similarMovies {
    _$similarMoviesAtom.reportRead();
    return super.similarMovies;
  }

  @override
  set similarMovies(List<SimpleMovie> value) {
    _$similarMoviesAtom.reportWrite(value, super.similarMovies, () {
      super.similarMovies = value;
    });
  }

  final _$fetchDataAsyncAction = AsyncAction('_MovieStoreBase.fetchData');

  @override
  Future<dynamic> fetchData(
      {required String path, required Map<String, dynamic> parameters}) {
    return _$fetchDataAsyncAction
        .run(() => super.fetchData(path: path, parameters: parameters));
  }

  final _$getPopularMoviesAsyncAction =
      AsyncAction('_MovieStoreBase.getPopularMovies');

  @override
  Future<void> getPopularMovies() {
    return _$getPopularMoviesAsyncAction.run(() => super.getPopularMovies());
  }

  final _$getMorePopularMoviesAsyncAction =
      AsyncAction('_MovieStoreBase.getMorePopularMovies');

  @override
  Future<void> getMorePopularMovies() {
    return _$getMorePopularMoviesAsyncAction
        .run(() => super.getMorePopularMovies());
  }

  final _$getSingleMovieAsyncAction =
      AsyncAction('_MovieStoreBase.getSingleMovie');

  @override
  Future<void> getSingleMovie(int id) {
    return _$getSingleMovieAsyncAction.run(() => super.getSingleMovie(id));
  }

  final _$searchAsyncAction = AsyncAction('_MovieStoreBase.search');

  @override
  Future<void> search() {
    return _$searchAsyncAction.run(() => super.search());
  }

  final _$getSimilarMoviesAsyncAction =
      AsyncAction('_MovieStoreBase.getSimilarMovies');

  @override
  Future<void> getSimilarMovies(int id) {
    return _$getSimilarMoviesAsyncAction.run(() => super.getSimilarMovies(id));
  }

  final _$_MovieStoreBaseActionController =
      ActionController(name: '_MovieStoreBase');

  @override
  void setSearch(String value) {
    final _$actionInfo = _$_MovieStoreBaseActionController.startAction(
        name: '_MovieStoreBase.setSearch');
    try {
      return super.setSearch(value);
    } finally {
      _$_MovieStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedContentType(int value) {
    final _$actionInfo = _$_MovieStoreBaseActionController.startAction(
        name: '_MovieStoreBase.setSelectedContentType');
    try {
      return super.setSelectedContentType(value);
    } finally {
      _$_MovieStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
page: ${page},
language: ${language},
movies: ${movies},
error: ${error},
totalPages: ${totalPages},
country: ${country},
movie: ${movie},
backToTheTopVisible: ${backToTheTopVisible},
searchString: ${searchString},
empty: ${empty},
selectedContentType: ${selectedContentType},
similarMovies: ${similarMovies}
    ''';
  }
}
