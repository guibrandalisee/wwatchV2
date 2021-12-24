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
    } else {
      dateFormat = 'dd/mm/yyyy';
      brightness = CustomBrightness.dark;
    }
  }
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

  @observable
  CustomBrightness brightness = CustomBrightness.dark;
  @action
  setBrightness(CustomBrightness value) {
    prefs!.setInt('brightness', value.index);
    brightness = value;
  }

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
  String language = 'English - US';
  @action
  void setLanguage(String value) => language = value;

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

  @observable
  String adultContent = 'No';
  @action
  void setAdultContent(String value) => adultContent = value;

  @observable
  String filterBadLanguage = 'Yes';
  @action
  void setFilterBadLanguage(String value) => filterBadLanguage = value;

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

  @observable
  var selectedWatchProviders = ObservableList<int>();

  @action
  void addSelectedWatchProvider(int value) => selectedWatchProviders.add(value);

  @action
  void removeSelectedWatchProvider(int value) =>
      selectedWatchProviders.remove(value);

  @observable
  List<Genre> movieGenres = [];

  @observable
  String selectedGenre = "Genres";

  @action
  void setSelectedGenre(String value) => selectedGenre = value;

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
}
