import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/settings_store.dart';

part 'style_store.g.dart';

class StyleStore = _StyleStoreBase with _$StyleStore;

abstract class _StyleStoreBase with Store {
  final SharedPreferences? prefs;
  final settingsStore = GetIt.I<SettingsStore>();
  _StyleStoreBase({
    this.prefs,
  }) {
    if (prefs != null) {
      if (prefs!.containsKey('primaryColor')) {
        primaryColor = AppColors.primaries[prefs!.getInt('primaryColor')!];
        colorIndex = prefs!.getInt('primaryColor');

        errorImage = AppColors.imagesNoConnection[colorIndex!];
        nothingFoundImage = AppColors.imagesNothingFound[colorIndex!];
      } else {
        primaryColor = AppColors.primary;
        colorIndex = 0;

        errorImage = AppColors.imagesNoConnection[0];
        nothingFoundImage = AppColors.imagesNothingFound[0];
      }

      if (prefs!.containsKey('fabPosition')) {
        fabPosition = prefs!.getInt('fabPosition');
      } else {
        fabPosition = 1;
      }
    } else {
      primaryColor = AppColors.primary;
      colorIndex = 0;
    }
    changeBrihtness();
  }

  @observable
  Color? primaryColor;

  @observable
  Color? dropdownColor;

  @observable
  Color? backgroundColor;

  @observable
  Color? textColor;

  @observable
  Color? textOnPrimaryColor;

  @observable
  Color? shapeColor;

  @observable
  int? colorIndex;

  @observable
  int? fabPosition;

  @observable
  String? errorImage;
  @observable
  String? nothingFoundImage;

  @action
  void setPrimaryColor(Color value, int index) {
    prefs?.setInt('primaryColor', index);
    colorIndex = index;
    primaryColor = value;
    errorImage = AppColors.imagesNoConnection[colorIndex!];
    nothingFoundImage = AppColors.imagesNothingFound[colorIndex!];
  }

  @action
  void setFabPosition(int value) {
    prefs!.setInt('fabPosition', value);
    fabPosition = value;
  }

  @action
  changeBrihtness() {
    switch (settingsStore.brightness) {
      case CustomBrightness.dark:
        backgroundColor = AppColors.background;
        textColor = AppColors.text;
        shapeColor = AppColors.shape;
        dropdownColor = AppColors.dropdownButton;
        break;
      case CustomBrightness.amoled:
        backgroundColor = AppColors.backgroundAmoled;
        textColor = AppColors.textAmoled;
        shapeColor = AppColors.shapeAmoled;
        dropdownColor = AppColors.dropdownAmoled;
        break;
      case CustomBrightness.light:
        backgroundColor = AppColors.backgroundLight;
        textColor = AppColors.textLight;
        shapeColor = AppColors.shapeLight;
        dropdownColor = AppColors.dropdownLight;
        break;
    }
  }
}
