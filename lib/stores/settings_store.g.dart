// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsStore on _SettingsStoreBase, Store {
  late final _$movieGenreModeAtom =
      Atom(name: '_SettingsStoreBase.movieGenreMode', context: context);

  @override
  GenreMode get movieGenreMode {
    _$movieGenreModeAtom.reportRead();
    return super.movieGenreMode;
  }

  @override
  set movieGenreMode(GenreMode value) {
    _$movieGenreModeAtom.reportWrite(value, super.movieGenreMode, () {
      super.movieGenreMode = value;
    });
  }

  late final _$tvShowGenreModeAtom =
      Atom(name: '_SettingsStoreBase.tvShowGenreMode', context: context);

  @override
  GenreMode get tvShowGenreMode {
    _$tvShowGenreModeAtom.reportRead();
    return super.tvShowGenreMode;
  }

  @override
  set tvShowGenreMode(GenreMode value) {
    _$tvShowGenreModeAtom.reportWrite(value, super.tvShowGenreMode, () {
      super.tvShowGenreMode = value;
    });
  }

  late final _$tileDisplayModeAtom =
      Atom(name: '_SettingsStoreBase.tileDisplayMode', context: context);

  @override
  int get tileDisplayMode {
    _$tileDisplayModeAtom.reportRead();
    return super.tileDisplayMode;
  }

  @override
  set tileDisplayMode(int value) {
    _$tileDisplayModeAtom.reportWrite(value, super.tileDisplayMode, () {
      super.tileDisplayMode = value;
    });
  }

  late final _$brightnessAtom =
      Atom(name: '_SettingsStoreBase.brightness', context: context);

  @override
  CustomBrightness get brightness {
    _$brightnessAtom.reportRead();
    return super.brightness;
  }

  @override
  set brightness(CustomBrightness value) {
    _$brightnessAtom.reportWrite(value, super.brightness, () {
      super.brightness = value;
    });
  }

  late final _$dateFormatAtom =
      Atom(name: '_SettingsStoreBase.dateFormat', context: context);

  @override
  String get dateFormat {
    _$dateFormatAtom.reportRead();
    return super.dateFormat;
  }

  @override
  set dateFormat(String value) {
    _$dateFormatAtom.reportWrite(value, super.dateFormat, () {
      super.dateFormat = value;
    });
  }

  late final _$selectedlanguageAtom =
      Atom(name: '_SettingsStoreBase.selectedlanguage', context: context);

  @override
  String get selectedlanguage {
    _$selectedlanguageAtom.reportRead();
    return super.selectedlanguage;
  }

  @override
  set selectedlanguage(String value) {
    _$selectedlanguageAtom.reportWrite(value, super.selectedlanguage, () {
      super.selectedlanguage = value;
    });
  }

  late final _$languageAtom =
      Atom(name: '_SettingsStoreBase.language', context: context);

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

  late final _$secondaryLanguageAtom =
      Atom(name: '_SettingsStoreBase.secondaryLanguage', context: context);

  @override
  String get secondaryLanguage {
    _$secondaryLanguageAtom.reportRead();
    return super.secondaryLanguage;
  }

  @override
  set secondaryLanguage(String value) {
    _$secondaryLanguageAtom.reportWrite(value, super.secondaryLanguage, () {
      super.secondaryLanguage = value;
    });
  }

  late final _$adultContentAtom =
      Atom(name: '_SettingsStoreBase.adultContent', context: context);

  @override
  bool get adultContent {
    _$adultContentAtom.reportRead();
    return super.adultContent;
  }

  @override
  set adultContent(bool value) {
    _$adultContentAtom.reportWrite(value, super.adultContent, () {
      super.adultContent = value;
    });
  }

  late final _$filterBadLanguageAtom =
      Atom(name: '_SettingsStoreBase.filterBadLanguage', context: context);

  @override
  String get filterBadLanguage {
    _$filterBadLanguageAtom.reportRead();
    return super.filterBadLanguage;
  }

  @override
  set filterBadLanguage(String value) {
    _$filterBadLanguageAtom.reportWrite(value, super.filterBadLanguage, () {
      super.filterBadLanguage = value;
    });
  }

  late final _$countryAtom =
      Atom(name: '_SettingsStoreBase.country', context: context);

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

  late final _$movieGenresAtom =
      Atom(name: '_SettingsStoreBase.movieGenres', context: context);

  @override
  List<Genre> get movieGenres {
    _$movieGenresAtom.reportRead();
    return super.movieGenres;
  }

  @override
  set movieGenres(List<Genre> value) {
    _$movieGenresAtom.reportWrite(value, super.movieGenres, () {
      super.movieGenres = value;
    });
  }

  late final _$tvShowGenresAtom =
      Atom(name: '_SettingsStoreBase.tvShowGenres', context: context);

  @override
  List<Genre> get tvShowGenres {
    _$tvShowGenresAtom.reportRead();
    return super.tvShowGenres;
  }

  @override
  set tvShowGenres(List<Genre> value) {
    _$tvShowGenresAtom.reportWrite(value, super.tvShowGenres, () {
      super.tvShowGenres = value;
    });
  }

  late final _$selectedMovieGenresAtom =
      Atom(name: '_SettingsStoreBase.selectedMovieGenres', context: context);

  @override
  ObservableList<int> get selectedMovieGenres {
    _$selectedMovieGenresAtom.reportRead();
    return super.selectedMovieGenres;
  }

  @override
  set selectedMovieGenres(ObservableList<int> value) {
    _$selectedMovieGenresAtom.reportWrite(value, super.selectedMovieGenres, () {
      super.selectedMovieGenres = value;
    });
  }

  late final _$selectedTvShowGenresAtom =
      Atom(name: '_SettingsStoreBase.selectedTvShowGenres', context: context);

  @override
  ObservableList<int> get selectedTvShowGenres {
    _$selectedTvShowGenresAtom.reportRead();
    return super.selectedTvShowGenres;
  }

  @override
  set selectedTvShowGenres(ObservableList<int> value) {
    _$selectedTvShowGenresAtom.reportWrite(value, super.selectedTvShowGenres,
        () {
      super.selectedTvShowGenres = value;
    });
  }

  late final _$avaliableRegionsAtom =
      Atom(name: '_SettingsStoreBase.avaliableRegions', context: context);

  @override
  List<AvaliableWatchProviderRegions> get avaliableRegions {
    _$avaliableRegionsAtom.reportRead();
    return super.avaliableRegions;
  }

  @override
  set avaliableRegions(List<AvaliableWatchProviderRegions> value) {
    _$avaliableRegionsAtom.reportWrite(value, super.avaliableRegions, () {
      super.avaliableRegions = value;
    });
  }

  late final _$rememberWatchProvidersAtom =
      Atom(name: '_SettingsStoreBase.rememberWatchProviders', context: context);

  @override
  bool? get rememberWatchProviders {
    _$rememberWatchProvidersAtom.reportRead();
    return super.rememberWatchProviders;
  }

  @override
  set rememberWatchProviders(bool? value) {
    _$rememberWatchProvidersAtom
        .reportWrite(value, super.rememberWatchProviders, () {
      super.rememberWatchProviders = value;
    });
  }

  late final _$avaliableWatchProvidersMoviesAtom = Atom(
      name: '_SettingsStoreBase.avaliableWatchProvidersMovies',
      context: context);

  @override
  List<AvaliableWatchProvider> get avaliableWatchProvidersMovies {
    _$avaliableWatchProvidersMoviesAtom.reportRead();
    return super.avaliableWatchProvidersMovies;
  }

  @override
  set avaliableWatchProvidersMovies(List<AvaliableWatchProvider> value) {
    _$avaliableWatchProvidersMoviesAtom
        .reportWrite(value, super.avaliableWatchProvidersMovies, () {
      super.avaliableWatchProvidersMovies = value;
    });
  }

  late final _$avaliableWatchProvidersTvShowsAtom = Atom(
      name: '_SettingsStoreBase.avaliableWatchProvidersTvShows',
      context: context);

  @override
  List<AvaliableWatchProvider> get avaliableWatchProvidersTvShows {
    _$avaliableWatchProvidersTvShowsAtom.reportRead();
    return super.avaliableWatchProvidersTvShows;
  }

  @override
  set avaliableWatchProvidersTvShows(List<AvaliableWatchProvider> value) {
    _$avaliableWatchProvidersTvShowsAtom
        .reportWrite(value, super.avaliableWatchProvidersTvShows, () {
      super.avaliableWatchProvidersTvShows = value;
    });
  }

  late final _$loadingWatchProvidersAtom =
      Atom(name: '_SettingsStoreBase.loadingWatchProviders', context: context);

  @override
  bool get loadingWatchProviders {
    _$loadingWatchProvidersAtom.reportRead();
    return super.loadingWatchProviders;
  }

  @override
  set loadingWatchProviders(bool value) {
    _$loadingWatchProvidersAtom.reportWrite(value, super.loadingWatchProviders,
        () {
      super.loadingWatchProviders = value;
    });
  }

  late final _$rememberSelectedWatchPMoviesAtom = Atom(
      name: '_SettingsStoreBase.rememberSelectedWatchPMovies',
      context: context);

  @override
  bool get rememberSelectedWatchPMovies {
    _$rememberSelectedWatchPMoviesAtom.reportRead();
    return super.rememberSelectedWatchPMovies;
  }

  @override
  set rememberSelectedWatchPMovies(bool value) {
    _$rememberSelectedWatchPMoviesAtom
        .reportWrite(value, super.rememberSelectedWatchPMovies, () {
      super.rememberSelectedWatchPMovies = value;
    });
  }

  late final _$rememberSelectedWatchPTVShowsAtom = Atom(
      name: '_SettingsStoreBase.rememberSelectedWatchPTVShows',
      context: context);

  @override
  bool get rememberSelectedWatchPTVShows {
    _$rememberSelectedWatchPTVShowsAtom.reportRead();
    return super.rememberSelectedWatchPTVShows;
  }

  @override
  set rememberSelectedWatchPTVShows(bool value) {
    _$rememberSelectedWatchPTVShowsAtom
        .reportWrite(value, super.rememberSelectedWatchPTVShows, () {
      super.rememberSelectedWatchPTVShows = value;
    });
  }

  late final _$selectedWatchProvidersMoviesAtom = Atom(
      name: '_SettingsStoreBase.selectedWatchProvidersMovies',
      context: context);

  @override
  ObservableList<int> get selectedWatchProvidersMovies {
    _$selectedWatchProvidersMoviesAtom.reportRead();
    return super.selectedWatchProvidersMovies;
  }

  @override
  set selectedWatchProvidersMovies(ObservableList<int> value) {
    _$selectedWatchProvidersMoviesAtom
        .reportWrite(value, super.selectedWatchProvidersMovies, () {
      super.selectedWatchProvidersMovies = value;
    });
  }

  late final _$selectedWatchProvidersTVShowsAtom = Atom(
      name: '_SettingsStoreBase.selectedWatchProvidersTVShows',
      context: context);

  @override
  ObservableList<int> get selectedWatchProvidersTVShows {
    _$selectedWatchProvidersTVShowsAtom.reportRead();
    return super.selectedWatchProvidersTVShows;
  }

  @override
  set selectedWatchProvidersTVShows(ObservableList<int> value) {
    _$selectedWatchProvidersTVShowsAtom
        .reportWrite(value, super.selectedWatchProvidersTVShows, () {
      super.selectedWatchProvidersTVShows = value;
    });
  }

  late final _$avaliableContentLanguagesAtom = Atom(
      name: '_SettingsStoreBase.avaliableContentLanguages', context: context);

  @override
  List<AvaliableContentLanguages> get avaliableContentLanguages {
    _$avaliableContentLanguagesAtom.reportRead();
    return super.avaliableContentLanguages;
  }

  @override
  set avaliableContentLanguages(List<AvaliableContentLanguages> value) {
    _$avaliableContentLanguagesAtom
        .reportWrite(value, super.avaliableContentLanguages, () {
      super.avaliableContentLanguages = value;
    });
  }

  late final _$selectedSortByAtom =
      Atom(name: '_SettingsStoreBase.selectedSortBy', context: context);

  @override
  String get selectedSortBy {
    _$selectedSortByAtom.reportRead();
    return super.selectedSortBy;
  }

  @override
  set selectedSortBy(String value) {
    _$selectedSortByAtom.reportWrite(value, super.selectedSortBy, () {
      super.selectedSortBy = value;
    });
  }

  late final _$selectedContentTypeAtom =
      Atom(name: '_SettingsStoreBase.selectedContentType', context: context);

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

  late final _$voteCountActiveAtom =
      Atom(name: '_SettingsStoreBase.voteCountActive', context: context);

  @override
  bool get voteCountActive {
    _$voteCountActiveAtom.reportRead();
    return super.voteCountActive;
  }

  @override
  set voteCountActive(bool value) {
    _$voteCountActiveAtom.reportWrite(value, super.voteCountActive, () {
      super.voteCountActive = value;
    });
  }

  late final _$voteCountMinAtom =
      Atom(name: '_SettingsStoreBase.voteCountMin', context: context);

  @override
  int get voteCountMin {
    _$voteCountMinAtom.reportRead();
    return super.voteCountMin;
  }

  @override
  set voteCountMin(int value) {
    _$voteCountMinAtom.reportWrite(value, super.voteCountMin, () {
      super.voteCountMin = value;
    });
  }

  late final _$voteCountMaxAtom =
      Atom(name: '_SettingsStoreBase.voteCountMax', context: context);

  @override
  int get voteCountMax {
    _$voteCountMaxAtom.reportRead();
    return super.voteCountMax;
  }

  @override
  set voteCountMax(int value) {
    _$voteCountMaxAtom.reportWrite(value, super.voteCountMax, () {
      super.voteCountMax = value;
    });
  }

  late final _$voteAvgActiveAtom =
      Atom(name: '_SettingsStoreBase.voteAvgActive', context: context);

  @override
  bool get voteAvgActive {
    _$voteAvgActiveAtom.reportRead();
    return super.voteAvgActive;
  }

  @override
  set voteAvgActive(bool value) {
    _$voteAvgActiveAtom.reportWrite(value, super.voteAvgActive, () {
      super.voteAvgActive = value;
    });
  }

  late final _$voteAvgMinAtom =
      Atom(name: '_SettingsStoreBase.voteAvgMin', context: context);

  @override
  int get voteAvgMin {
    _$voteAvgMinAtom.reportRead();
    return super.voteAvgMin;
  }

  @override
  set voteAvgMin(int value) {
    _$voteAvgMinAtom.reportWrite(value, super.voteAvgMin, () {
      super.voteAvgMin = value;
    });
  }

  late final _$voteAvgMaxAtom =
      Atom(name: '_SettingsStoreBase.voteAvgMax', context: context);

  @override
  int get voteAvgMax {
    _$voteAvgMaxAtom.reportRead();
    return super.voteAvgMax;
  }

  @override
  set voteAvgMax(int value) {
    _$voteAvgMaxAtom.reportWrite(value, super.voteAvgMax, () {
      super.voteAvgMax = value;
    });
  }

  late final _$runTimeActiveAtom =
      Atom(name: '_SettingsStoreBase.runTimeActive', context: context);

  @override
  bool get runTimeActive {
    _$runTimeActiveAtom.reportRead();
    return super.runTimeActive;
  }

  @override
  set runTimeActive(bool value) {
    _$runTimeActiveAtom.reportWrite(value, super.runTimeActive, () {
      super.runTimeActive = value;
    });
  }

  late final _$runTimeMinAtom =
      Atom(name: '_SettingsStoreBase.runTimeMin', context: context);

  @override
  int get runTimeMin {
    _$runTimeMinAtom.reportRead();
    return super.runTimeMin;
  }

  @override
  set runTimeMin(int value) {
    _$runTimeMinAtom.reportWrite(value, super.runTimeMin, () {
      super.runTimeMin = value;
    });
  }

  late final _$runTimeMaxAtom =
      Atom(name: '_SettingsStoreBase.runTimeMax', context: context);

  @override
  int get runTimeMax {
    _$runTimeMaxAtom.reportRead();
    return super.runTimeMax;
  }

  @override
  set runTimeMax(int value) {
    _$runTimeMaxAtom.reportWrite(value, super.runTimeMax, () {
      super.runTimeMax = value;
    });
  }

  late final _$getMovieGenresAsyncAction =
      AsyncAction('_SettingsStoreBase.getMovieGenres', context: context);

  @override
  Future<void> getMovieGenres() {
    return _$getMovieGenresAsyncAction.run(() => super.getMovieGenres());
  }

  late final _$getTvShowGenresAsyncAction =
      AsyncAction('_SettingsStoreBase.getTvShowGenres', context: context);

  @override
  Future<void> getTvShowGenres() {
    return _$getTvShowGenresAsyncAction.run(() => super.getTvShowGenres());
  }

  late final _$getAvaliableRegionsAsyncAction =
      AsyncAction('_SettingsStoreBase.getAvaliableRegions', context: context);

  @override
  Future<void> getAvaliableRegions() {
    return _$getAvaliableRegionsAsyncAction
        .run(() => super.getAvaliableRegions());
  }

  late final _$getPossibleWatchProvidersAsyncAction = AsyncAction(
      '_SettingsStoreBase.getPossibleWatchProviders',
      context: context);

  @override
  Future<void> getPossibleWatchProviders(bool movie) {
    return _$getPossibleWatchProvidersAsyncAction
        .run(() => super.getPossibleWatchProviders(movie));
  }

  late final _$getAvaliableLanguagesAsyncAction =
      AsyncAction('_SettingsStoreBase.getAvaliableLanguages', context: context);

  @override
  Future<void> getAvaliableLanguages() {
    return _$getAvaliableLanguagesAsyncAction
        .run(() => super.getAvaliableLanguages());
  }

  late final _$_SettingsStoreBaseActionController =
      ActionController(name: '_SettingsStoreBase', context: context);

  @override
  void setMovieGenreMode(GenreMode value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.setMovieGenreMode');
    try {
      return super.setMovieGenreMode(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTvShowGenreMode(GenreMode value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.setTvShowGenreMode');
    try {
      return super.setTvShowGenreMode(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTileMode(int value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.setTileMode');
    try {
      return super.setTileMode(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCountry(String value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.setCountry');
    try {
      return super.setCountry(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setBrightness(CustomBrightness value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.setBrightness');
    try {
      return super.setBrightness(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setdateFormat(String value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.setdateFormat');
    try {
      return super.setdateFormat(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSecondaryLanguage(String value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.setSecondaryLanguage');
    try {
      return super.setSecondaryLanguage(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAdultContent(String value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.setAdultContent');
    try {
      return super.setAdultContent(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilterBadLanguage(String value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.setFilterBadLanguage');
    try {
      return super.setFilterBadLanguage(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addSelectedTvShowGenre(int value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.addSelectedTvShowGenre');
    try {
      return super.addSelectedTvShowGenre(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeSelectedTvShowGenre(int value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.removeSelectedTvShowGenre');
    try {
      return super.removeSelectedTvShowGenre(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addSelectedMovieGenre(int value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.addSelectedMovieGenre');
    try {
      return super.addSelectedMovieGenre(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeSelectedMovieGenre(int value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.removeSelectedMovieGenre');
    try {
      return super.removeSelectedMovieGenre(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRememberSelectedWatchPMovies(bool value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.setRememberSelectedWatchPMovies');
    try {
      return super.setRememberSelectedWatchPMovies(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRememberSelectedWatchPTVShows(bool value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.setRememberSelectedWatchPTVShows');
    try {
      return super.setRememberSelectedWatchPTVShows(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void saveSelectedWatchProviders() {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.saveSelectedWatchProviders');
    try {
      return super.saveSelectedWatchProviders();
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSortBy(String value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.setSortBy');
    try {
      return super.setSortBy(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedContentType(int value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.setSelectedContentType');
    try {
      return super.setSelectedContentType(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void switchContentType() {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.switchContentType');
    try {
      return super.switchContentType();
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toogleVoteCountFilter(bool value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.toogleVoteCountFilter');
    try {
      return super.toogleVoteCountFilter(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toogleVoteAvgFilter(bool value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.toogleVoteAvgFilter');
    try {
      return super.toogleVoteAvgFilter(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toogleRunTimeFilter(bool value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.toogleRunTimeFilter');
    try {
      return super.toogleRunTimeFilter(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
movieGenreMode: ${movieGenreMode},
tvShowGenreMode: ${tvShowGenreMode},
tileDisplayMode: ${tileDisplayMode},
brightness: ${brightness},
dateFormat: ${dateFormat},
selectedlanguage: ${selectedlanguage},
language: ${language},
secondaryLanguage: ${secondaryLanguage},
adultContent: ${adultContent},
filterBadLanguage: ${filterBadLanguage},
country: ${country},
movieGenres: ${movieGenres},
tvShowGenres: ${tvShowGenres},
selectedMovieGenres: ${selectedMovieGenres},
selectedTvShowGenres: ${selectedTvShowGenres},
avaliableRegions: ${avaliableRegions},
rememberWatchProviders: ${rememberWatchProviders},
avaliableWatchProvidersMovies: ${avaliableWatchProvidersMovies},
avaliableWatchProvidersTvShows: ${avaliableWatchProvidersTvShows},
loadingWatchProviders: ${loadingWatchProviders},
rememberSelectedWatchPMovies: ${rememberSelectedWatchPMovies},
rememberSelectedWatchPTVShows: ${rememberSelectedWatchPTVShows},
selectedWatchProvidersMovies: ${selectedWatchProvidersMovies},
selectedWatchProvidersTVShows: ${selectedWatchProvidersTVShows},
avaliableContentLanguages: ${avaliableContentLanguages},
selectedSortBy: ${selectedSortBy},
selectedContentType: ${selectedContentType},
voteCountActive: ${voteCountActive},
voteCountMin: ${voteCountMin},
voteCountMax: ${voteCountMax},
voteAvgActive: ${voteAvgActive},
voteAvgMin: ${voteAvgMin},
voteAvgMax: ${voteAvgMax},
runTimeActive: ${runTimeActive},
runTimeMin: ${runTimeMin},
runTimeMax: ${runTimeMax}
    ''';
  }
}
