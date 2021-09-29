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

  final _$includeAdultAtom = Atom(name: '_MovieStoreBase.includeAdult');

  @override
  bool get includeAdult {
    _$includeAdultAtom.reportRead();
    return super.includeAdult;
  }

  @override
  set includeAdult(bool value) {
    _$includeAdultAtom.reportWrite(value, super.includeAdult, () {
      super.includeAdult = value;
    });
  }

  final _$popularMoviesAtom = Atom(name: '_MovieStoreBase.popularMovies');

  @override
  List<Movie> get popularMovies {
    _$popularMoviesAtom.reportRead();
    return super.popularMovies;
  }

  @override
  set popularMovies(List<Movie> value) {
    _$popularMoviesAtom.reportWrite(value, super.popularMovies, () {
      super.popularMovies = value;
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

  final _$getPopularMoviesAsyncAction =
      AsyncAction('_MovieStoreBase.getPopularMovies');

  @override
  Future<void> getPopularMovies() {
    return _$getPopularMoviesAsyncAction.run(() => super.getPopularMovies());
  }

  @override
  String toString() {
    return '''
page: ${page},
language: ${language},
includeAdult: ${includeAdult},
popularMovies: ${popularMovies},
error: ${error}
    ''';
  }
}
