import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';

part 'style_store.g.dart';

class StyleStore = _StyleStoreBase with _$StyleStore;

abstract class _StyleStoreBase with Store {
  final SharedPreferences? prefs;

  _StyleStoreBase({
    this.prefs,
  }) {
    if (prefs != null) {
      if (prefs!.containsKey('primaryColor')) {
        primaryColor = AppColors.primaries[prefs!.getInt('primaryColor')!];
        colorIndex = prefs!.getInt('primaryColor');
      } else {
        primaryColor = AppColors.primary;
        colorIndex = 0;
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
  }

  @observable
  Color? primaryColor;

  @observable
  int? colorIndex;

  @observable
  int? fabPosition;

  @action
  void setPrimaryColor(Color value, int index) {
    prefs?.setInt('primaryColor', index);
    colorIndex = index;
    primaryColor = value;
  }

  @action
  void setFabPosition(int value) {
    prefs!.setInt('fabPosition', value);
    fabPosition = value;
  }
}
