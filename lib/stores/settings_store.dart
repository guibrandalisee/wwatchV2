import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_store.g.dart';

class SettingsStore = _SettingsStoreBase with _$SettingsStore;

abstract class _SettingsStoreBase with Store {
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
    } else {
      dateFormat = 'dd/mm/yyyy';
    }
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
  String timeZone = 'America - São Paulo';
  @action
  void setTimeZone(String value) => timeZone = value;

  @observable
  List<String> timeZones = ["America - São Paulo", "Mexico - Mato Grosso"];

  @observable
  bool autoDetectTimeZone = true;

  @action
  void setAutoDetectTimeZone(bool value) => autoDetectTimeZone = value;
}
