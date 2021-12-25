// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsStore on _SettingsStoreBase, Store {
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
  String get adultContent {
    _$adultContentAtom.reportRead();
    return super.adultContent;
  }

  @override
  set adultContent(String value) {
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

  final _$countriesAtom = Atom(name: '_SettingsStoreBase.countries');

  @override
  List<String> get countries {
    _$countriesAtom.reportRead();
    return super.countries;
  }

  @override
  set countries(List<String> value) {
    _$countriesAtom.reportWrite(value, super.countries, () {
      super.countries = value;
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

  final _$selectedGenresAtom = Atom(name: '_SettingsStoreBase.selectedGenres');

  @override
  ObservableList<int> get selectedGenres {
    _$selectedGenresAtom.reportRead();
    return super.selectedGenres;
  }

  @override
  set selectedGenres(ObservableList<int> value) {
    _$selectedGenresAtom.reportWrite(value, super.selectedGenres, () {
      super.selectedGenres = value;
    });
  }

  final _$getMovieGenresAsyncAction =
      AsyncAction('_SettingsStoreBase.getMovieGenres');

  @override
  Future<void> getMovieGenres() {
    return _$getMovieGenresAsyncAction.run(() => super.getMovieGenres());
  }

  final _$_SettingsStoreBaseActionController =
      ActionController(name: '_SettingsStoreBase');

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
  void setLanguage(String value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.setLanguage');
    try {
      return super.setLanguage(value);
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
  void addSelectedGenre(int value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.addSelectedGenre');
    try {
      return super.addSelectedGenre(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeSelectedGenre(int value) {
    final _$actionInfo = _$_SettingsStoreBaseActionController.startAction(
        name: '_SettingsStoreBase.removeSelectedGenre');
    try {
      return super.removeSelectedGenre(value);
    } finally {
      _$_SettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
brightness: ${brightness},
dateFormat: ${dateFormat},
language: ${language},
secondaryLanguage: ${secondaryLanguage},
languages: ${languages},
adultContent: ${adultContent},
filterBadLanguage: ${filterBadLanguage},
country: ${country},
countries: ${countries},
timeZone: ${timeZone},
timeZones: ${timeZones},
autoDetectTimeZone: ${autoDetectTimeZone},
selectedWatchProviders: ${selectedWatchProviders},
movieGenres: ${movieGenres},
selectedGenres: ${selectedGenres}
    ''';
  }
}
