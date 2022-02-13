import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/api.dart';

part 'settings_store.g.dart';

class SettingsStore = _SettingsStoreBase with _$SettingsStore;
enum CustomBrightness { dark, amoled, light }

abstract class _SettingsStoreBase with Store {
  String apiKey = API().apiKey;
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

  //WIP change app language
  //TODO get list itens from API
  //or just set suported languages manually
  @observable
  String language = 'English - US';
  @action
  void setLanguage(String value) => language = value;
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

  //WIP Change app country to filter movie watch providers results
  @observable
  String country = 'Brazil';
  @action
  void setCountry(String value) => country = value;

  @observable
  List<String> countries = [
    "United States",
    "Canada",
    "Brazil",
    "United Kingdom",
    "France"
  ];

  //WIP Change app timezone
  @observable
  String timeZone = "Brasil - São Paulo";
  @action
  void setTimeZone(String value) => timeZone = value;

  @observable
  List<String> timeZones = ["Brasil - São Paulo", "Brasil - Belo Horizonte"];

  @observable
  bool autoDetectTimeZone = true;

  @action
  void setAutoDetectTimeZone(bool value) => autoDetectTimeZone = value;

  //WIP Watch Providers Filter
  @observable
  var selectedWatchProviders = ObservableList<int>();

  @action
  void addSelectedWatchProvider(int value) => selectedWatchProviders.add(value);

  @action
  void removeSelectedWatchProvider(int value) =>
      selectedWatchProviders.remove(value);

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
      'api_key': apiKey,
      'language': language,
    });

    movieGenres = response.data['genres'].map<Genre>((e) {
      return Genre(id: e['id'], name: e['name']);
    }).toList();
  }

  @action
  Future<void> getTvShowGenres() async {
    final response = await fetchData(path: '/genre/tv/list', parameters: {
      'api_key': apiKey,
      'language': language,
    });

    tvShowGenres = response.data['genres'].map<Genre>((e) {
      return Genre(id: e['id'], name: e['name']);
    }).toList();
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
}
