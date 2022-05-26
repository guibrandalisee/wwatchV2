import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wwatch/Shared/models/configuration_models.dart';
import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wwatch/Shared/models/movie_watch_providers_model.dart';

part 'settings_store.g.dart';

class SettingsStore = _SettingsStoreBase with _$SettingsStore;

enum CustomBrightness { dark, amoled, light }

abstract class _SettingsStoreBase with Store {
  String token = dotenv.env['TOKEN']!;
  //Check if user has changed any settings before
  final SharedPreferences? prefs;
  _SettingsStoreBase({
    this.prefs,
  }) {
    if (prefs != null) {
      if (prefs!.containsKey('dateFormat')) {
        dateFormat = prefs!.getString('dateFormat')!;
      } else {
        dateFormat = 'dd/mm/yyyy';
      }
      if (prefs!.containsKey('brightness')) {
        brightness = CustomBrightness.values[prefs!.getInt('brightness')!];
      } else {
        brightness = CustomBrightness.dark;
      }
      if (prefs!.containsKey('adultContent')) {
        adultContent = prefs!.getBool('adultContent')!;
      }
      if (prefs!.containsKey('tileMode')) {
        tileDisplayMode = prefs!.getInt('tileMode')!;
      }
      if (prefs!.containsKey('country')) {
        country = prefs!.getString('country')!;
      }
      if (prefs!.containsKey('language')) {
        selectedlanguage = prefs!.getString('language')!;
      }
      if (prefs!.containsKey('languageISO')) {
        language = prefs!.getString('languageISO')!;
      }
    } else {
      dateFormat = 'dd/mm/yyyy';
      brightness = CustomBrightness.dark;
      adultContent = false;
    }
  }
  //Default http request function
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

      final response = await dio.get(path, queryParameters: parameters);
      return response;
    } on DioError catch (e) {
      print(e);
    }
  }

  //Change tiles mode on home screen
  @observable
  int tileDisplayMode = 0;
  //0 = Card
  //1 = Tile
  //2 = maybe on the future
  @action
  void setTileMode(int value) {
    prefs?.setInt('tileMode', value);
    tileDisplayMode = value;
  }

  @action
  void setCountry(String value) {
    prefs?.setString('country', value);
    country = value;
  }

  //Change Brightness settigns (Dark|Light|AMOLED)
  @observable
  CustomBrightness brightness = CustomBrightness.dark;
  @action
  setBrightness(CustomBrightness value) {
    prefs!.setInt('brightness', value.index);
    brightness = value;
  }

  //Change date format
  @observable
  String dateFormat = 'dd/mm/yyyy';
  @action
  void setdateFormat(String value) {
    prefs?.setString('dateFormat', value);
    dateFormat = value;
  }

  //TODO get list itens from API
  //or just set suported languages manually
  @observable
  String selectedlanguage = 'English - US';
  @observable
  String language = 'en';

  //WIP change app secondary language
  @observable
  String secondaryLanguage = 'English - US';
  @action
  void setSecondaryLanguage(String value) => secondaryLanguage = value;

  @observable
  List<String> languages = [
    "English - US",
    "Portuguese - BR",
    "Portuguese - PT",
    "Spanish - ES",
  ];

  //Change if the app will display adult content
  @observable
  bool adultContent = false;
  @action
  void setAdultContent(String value) {
    if (value == 'No') {
      adultContent = false;
      prefs!.setBool('adultContent', false);
    } else {
      adultContent = true;
      prefs!.setBool('adultContent', true);
    }
  }

  //WIP Change if app will diplay bad language
  @observable
  String filterBadLanguage = 'Yes';
  @action
  void setFilterBadLanguage(String value) => filterBadLanguage = value;
  @observable
  String country = 'United States of America';

  //Movie Genres Filter
  @observable
  List<Genre> movieGenres = [];

  @observable
  List<Genre> tvShowGenres = [];

  @observable
  ObservableList<int> selectedMovieGenres = ObservableList<int>();

  @observable
  ObservableList<int> selectedTvShowGenres = ObservableList<int>();

  @action
  void addSelectedTvShowGenre(int value) {
    selectedTvShowGenres.add(value);
  }

  @action
  void removeSelectedTvShowGenre(int value) {
    selectedTvShowGenres.remove(value);
  }

  @action
  void addSelectedMovieGenre(int value) {
    selectedMovieGenres.add(value);
  }

  @action
  void removeSelectedMovieGenre(int value) {
    selectedMovieGenres.remove(value);
  }

  @action
  Future<void> getMovieGenres() async {
    final response = await fetchData(path: '/genre/movie/list', parameters: {
      'language': language,
    });

    movieGenres = response.data['genres'].map<Genre>((e) {
      return Genre(id: e['id'], name: e['name']);
    }).toList();
  }

  @action
  Future<void> getTvShowGenres() async {
    final response = await fetchData(path: '/genre/tv/list', parameters: {
      'language': language,
    });

    tvShowGenres = response.data['genres'].map<Genre>((e) {
      return Genre(id: e['id'], name: e['name']);
    }).toList();
  }

//!Watch Providers ---------------------------------------------------------------------------

  @observable
  List<AvaliableWatchProviderRegions> avaliableRegions = [];

  @action
  Future<void> getAvaliableRegions() async {
    final response =
        await fetchData(path: '/watch/providers/regions', parameters: {
      'language': language,
    });

    avaliableRegions =
        response.data['results'].map<AvaliableWatchProviderRegions>((e) {
      return AvaliableWatchProviderRegions(
        iso_3166_1: e['iso_3166_1'],
        englishName: e['english_name'],
        nativeName: e['native_name'],
      );
    }).toList();
  }

  @observable
  bool? rememberWatchProviders;

  @observable
  List<AvaliableWatchProvider> avaliableWatchProvidersMovies = [];

  @observable
  List<AvaliableWatchProvider> avaliableWatchProvidersTvShows = [];

  @observable
  bool loadingWatchProviders = false;

  @action
  Future<void> getPossibleWatchProviders(bool movie) async {
    String iso = avaliableRegions
        .firstWhere((element) => element.englishName == country)
        .iso_3166_1;
    loadingWatchProviders = true;
    final response = await fetchData(
        path: '/watch/providers/' + (movie ? 'movie' : 'tv'),
        parameters: {
          'language': language,
          'watch_region': iso,
        });

    if (movie) {
      avaliableWatchProvidersMovies =
          response.data['results'].map<AvaliableWatchProvider>((e) {
        return AvaliableWatchProvider(
          displayPriority: e['display_priority'],
          logoPath: e['logo_path'],
          providerId: e['provider_id'],
          providerName: e['provider_name'],
        );
      }).toList();
      avaliableWatchProvidersMovies
          .sort(((a, b) => a.displayPriority.compareTo(b.displayPriority)));
      loadingWatchProviders = false;
    } else {
      avaliableWatchProvidersTvShows =
          response.data['results'].map<AvaliableWatchProvider>((e) {
        return AvaliableWatchProvider(
          displayPriority: e['display_priority'],
          logoPath: e['logo_path'],
          providerId: e['provider_id'],
          providerName: e['provider_name'],
        );
      }).toList();
      avaliableWatchProvidersTvShows
          .sort(((a, b) => a.displayPriority.compareTo(b.displayPriority)));
      loadingWatchProviders = false;
    }
  }

  @observable
  bool rememberSelectedWatchPMovies = false;

  @observable
  bool rememberSelectedWatchPTVShows = false;

  @action
  void setRememberSelectedWatchPMovies(bool value) =>
      rememberSelectedWatchPMovies = value;

  @action
  void setRememberSelectedWatchPTVShows(bool value) =>
      rememberSelectedWatchPTVShows = value;

  @observable
  ObservableList<int> selectedWatchProvidersMovies = ObservableList<int>();

  @observable
  ObservableList<int> selectedWatchProvidersTVShows = ObservableList<int>();

  @action
  void saveSelectedWatchProviders() {
    //TODO save changes to shared preferences
    //get selected changes when loading settings store for first time
    //apply filters to API requests
  }

  //!------------------------------------------------------------------------------

  @observable
  List<AvaliableContentLanguages> avaliableContentLanguages = [];

  @action
  Future<void> getAvaliableLanguages() async {
    avaliableContentLanguages = [
      AvaliableContentLanguages(
          iso_639_1: 'pt-BR',
          englishName: 'Portuguese - BR',
          name: 'Português - BR'),
      AvaliableContentLanguages(
          iso_639_1: 'en-US',
          englishName: 'English - US',
          name: 'English - US'),
      AvaliableContentLanguages(
          iso_639_1: 'es-ES',
          englishName: 'Spanish - ES',
          name: 'Español - ES'),
      AvaliableContentLanguages(
          iso_639_1: 'fr-FR',
          englishName: 'French - FR',
          name: 'Français - FR'),
    ];

    avaliableContentLanguages.sort((a, b) {
      return a.englishName
          .toString()
          .toLowerCase()
          .compareTo(b.englishName.toString().toLowerCase());
    });
  }

  @observable
  String selectedSortBy = "popularity.desc";

  @action
  void setSortBy(String value) => selectedSortBy = value;

  List<String> possibleSortBy = [
    "popularity.asc",
    "popularity.desc",
    "release_date.asc",
    " release_date.desc",
    "revenue.asc",
    "revenue.desc",
    "primary_release_date.asc",
    "primary_release_date.desc",
    "original_title.asc",
    "original_title.desc",
    "vote_average.asc",
    "vote_average.desc",
    "vote_count.asc",
    "vote_count.desc"
  ];

  @observable
  int selectedContentType = 0;

  @action
  void setSelectedContentType(int value) => selectedContentType = value;

  @action
  void switchContentType() {
    if (selectedContentType == 0)
      selectedContentType = 1;
    else
      selectedContentType = 0;
  }

  @observable
  bool voteCountActive = true;
  @observable
  int voteCountMin = 50;
  @observable
  int voteCountMax = 10000;
  @action
  void toogleVoteCountFilter(bool value) => voteCountActive = value;

  @observable
  bool voteAvgActive = false;
  @observable
  int voteAvgMin = 3;
  @observable
  int voteAvgMax = 7;
  @action
  void toogleVoteAvgFilter(bool value) => voteAvgActive = value;

  @observable
  bool runTimeActive = false;
  @observable
  int runTimeMin = 60;
  @observable
  int runTimeMax = 120;
  @action
  void toogleRunTimeFilter(bool value) => runTimeActive = value;
}
