// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsStore on _SettingsStoreBase, Store {
  final _$tileDisplayModeAtom =
      Atom(name: '_SettingsStoreBase.tileDisplayMode');

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

  final _$brightnessAtom = Atom(name: '_SettingsStoreBase.brightness');

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

  final _$dateFormatAtom = Atom(name: '_SettingsStoreBase.dateFormat');

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

  final _$selectedlanguageAtom =
      Atom(name: '_SettingsStoreBase.selectedlanguage');

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

  final _$languageAtom = Atom(name: '_SettingsStoreBase.language');

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

  final _$secondaryLanguageAtom =
      Atom(name: '_SettingsStoreBase.secondaryLanguage');

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

  final _$languagesAtom = Atom(name: '_SettingsStoreBase.languages');

  @override
  List<String> get languages {
    _$languagesAtom.reportRead();
    return super.languages;
  }

  @override
  set languages(List<String> value) {
    _$languagesAtom.reportWrite(value, super.languages, () {
      super.languages = value;
    });
  }

  final _$adultContentAtom = Atom(name: '_SettingsStoreBase.adultContent');

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

  final _$filterBadLanguageAtom =
      Atom(name: '_SettingsStoreBase.filterBadLanguage');

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

  final _$countryAtom = Atom(name: '_SettingsStoreBase.country');

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

  final _$timeZoneAtom = Atom(name: '_SettingsStoreBase.timeZone');

  @override
  String get timeZone {
    _$timeZoneAtom.reportRead();
    return super.timeZone;
  }

  @override
  set timeZone(String value) {
    _$timeZoneAtom.reportWrite(value, super.timeZone, () {
      super.timeZone = value;
    });
  }

  final _$timeZonesAtom = Atom(name: '_SettingsStoreBase.timeZones');

  @override
  List<String> get timeZones {
    _$timeZonesAtom.reportRead();
    return super.timeZones;
  }

  @override
  set timeZones(List<String> value) {
    _$timeZonesAtom.reportWrite(value, super.timeZones, () {
      super.timeZones = value;
    });
  }

  final _$autoDetectTimeZoneAtom =
      Atom(name: '_SettingsStoreBase.autoDetectTimeZone');

  @override
  bool get autoDetectTimeZone {
    _$autoDetectTimeZoneAtom.reportRead();
    return super.autoDetectTimeZone;
  }

  @override
  set autoDetectTimeZone(bool value) {
    _$autoDetectTimeZoneAtom.reportWrite(value, super.autoDetectTimeZone, () {
      super.autoDetectTimeZone = value;
    });
  }

  final _$selectedWatchProvidersAtom =
      Atom(name: '_SettingsStoreBase.selectedWatchProviders');

  @override
  ObservableList<int> get selectedWatchProviders {
    _$selectedWatchProvidersAtom.reportRead();
    return super.selectedWatchProviders;
  }

  @override
  set selectedWatchProviders(ObservableList<int> value) {
    _$selectedWatchProvidersAtom
        .reportWrite(value, super.selectedWatchProviders, () {
      super.selectedWatchProviders = value;
    });
  }

  final _$movieGenresAtom = Atom(name: '_SettingsStoreBase.movieGenres');

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

  final _$tvShowGenresAtom = Atom(name: '_SettingsStoreBase.tvShowGenres');

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

  final _$selectedMovieGenresAtom =
      Atom(name: '_SettingsStoreBase.selectedMovieGenres');

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

  final _$selectedTvShowGenresAtom =
      Atom(name: '_SettingsStoreBase.selectedTvShowGenres');

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

  final _$avaliableRegionsAtom =
      Atom(name: '_SettingsStoreBase.avaliableRegions');

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

  final _$avaliableContentLanguagesAtom =
      Atom(name: '_SettingsStoreBase.avaliableContentLanguages');

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

  final _$selectedSortByAtom = Atom(name: '_SettingsStoreBase.selectedSortBy');

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

  final _$selectedContentTypeAtom =
      Atom(name: '_SettingsStoreBase.selectedContentType');

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

  final _$voteCountActiveAtom =
      Atom(name: '_SettingsStoreBase.voteCountActive');

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

  final _$voteCountMinAtom = Atom(name: '_SettingsStoreBase.voteCountMin');

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

  final _$voteCountMaxAtom = Atom(name: '_SettingsStoreBase.voteCountMax');

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

  final _$voteAvgActiveAtom = Atom(name: '_SettingsStoreBase.voteAvgActive');

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

  final _$voteAvgMinAtom = Atom(name: '_SettingsStoreBase.voteAvgMin');

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

  final _$voteAvgMaxAtom = Atom(name: '_SettingsStoreBase.voteAvgMax');

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

  final _$runTimeActiveAtom = Atom(name: '_SettingsStoreBase.runTimeActive');

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

  final _$runTimeMinAtom = Atom(name: '_SettingsStoreBase.runTimeMin');

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

  final _$runTimeMaxAtom = Atom(name: '_SettingsStoreBase.runTimeMax');

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

  final _$getMovieGenresAsyncAction =
      AsyncAction('_SettingsStoreBase.getMovieGenres');

  @override
  Future<void> getMovieGenres() {
    return _$getMovieGenresAsyncAction.run(() => super.getMovieGenres());
  }

  final _$getTvShowGenresAsyncAction =
      AsyncAction('_SettingsStoreBase.getTvShowGenres');

  @override
  Future<void> getTvShowGenres() {
    return _$getTvShowGenresAsyncAction.run(() => super.getTvShowGenres());
  }

  final _$getAvaliableRegionsAsyncAction =
      AsyncAction('_SettingsStoreBase.getAvaliableRegions');

  @override
  Future<void> getAvaliableRegions() {
    return _$getAvaliableRegionsAsyncAction
        .run(() => super.getAvaliableRegions());
  }

  final _$getAvaliableLanguagesAsyncAction =
      AsyncAction('_SettingsStoreBase.getAvaliableLanguages');

  @override
  Future<void> getAvaliableLanguages() {
    return _$getAvaliableLanguagesAsyncAction
        .run(() => super.getAvaliableLanguages());
  }

  final _$_SettingsStoreBaseActionController =
      ActionController(name: '_SettingsStoreBase');

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
  void setTimeZone(String value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.setTimeZone');
    try {
      return super.setTimeZone(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAutoDetectTimeZone(bool value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.setAutoDetectTimeZone');
    try {
      return super.setAutoDetectTimeZone(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addSelectedWatchProvider(int value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.addSelectedWatchProvider');
    try {
      return super.addSelectedWatchProvider(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeSelectedWatchProvider(int value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.removeSelectedWatchProvider');
    try {
      return super.removeSelectedWatchProvider(value);
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
tileDisplayMode: ${tileDisplayMode},
brightness: ${brightness},
dateFormat: ${dateFormat},
selectedlanguage: ${selectedlanguage},
language: ${language},
secondaryLanguage: ${secondaryLanguage},
languages: ${languages},
adultContent: ${adultContent},
filterBadLanguage: ${filterBadLanguage},
country: ${country},
timeZone: ${timeZone},
timeZones: ${timeZones},
autoDetectTimeZone: ${autoDetectTimeZone},
selectedWatchProviders: ${selectedWatchProviders},
movieGenres: ${movieGenres},
tvShowGenres: ${tvShowGenres},
selectedMovieGenres: ${selectedMovieGenres},
selectedTvShowGenres: ${selectedTvShowGenres},
avaliableRegions: ${avaliableRegions},
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
