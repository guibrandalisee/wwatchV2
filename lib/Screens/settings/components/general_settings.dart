import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wwatch/Screens/settings/components/dropdown_button_widget.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GeneralSettings extends StatefulWidget {
  GeneralSettings({
    Key? key,
    required this.movieStore,
  }) : super(key: key);
  final MovieStore movieStore;

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  bool didChange = false;
  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  void getPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences? _prefs;
  @override
  Widget build(BuildContext context) {
    SettingsStore settingsStore = GetIt.I<SettingsStore>();
    StyleStore styleStore = GetIt.I<StyleStore>();
    return WillPopScope(
      onWillPop: () async {
        if (didChange) widget.movieStore.getPopularContent();
        return true;
      },
      child: Observer(
        builder: (_) {
          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  AppLocalizations.of(context)!.dateFormat,
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              DropDownButtonWidget(
                items: ['dd/mm/yyyy', 'mm/dd/yyyy', 'yyyy/mm/dd'],
                value: settingsStore.dateFormat,
                onChanged: (value) {
                  if (value != null) {
                    settingsStore.setdateFormat(value);
                  }
                },
              ),
              SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  AppLocalizations.of(context)!.pContentLanguage,
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              DropDownButtonWidget(
                items: settingsStore.avaliableContentLanguages
                    .map<String>((e) => e.englishName)
                    .toList(),
                value: settingsStore.selectedlanguage,
                onChanged: (value) {
                  if (value != null) {
                    settingsStore.selectedlanguage = value;
                    settingsStore.language = settingsStore
                        .avaliableContentLanguages
                        .firstWhere((element) => element.englishName == value)
                        .iso_639_1;
                    widget.movieStore.language = settingsStore.language;
                    didChange = true;
                    if (_prefs != null) {
                      _prefs!.setString('language', value);
                      _prefs!.setString('languageISO', settingsStore.language);
                    }
                  }
                },
              ),
              SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  AppLocalizations.of(context)!.sContentLanguage,
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              DropDownButtonWidget(
                items: settingsStore.languages,
                value: settingsStore.secondaryLanguage,
                onChanged: (value) {
                  if (value != null) {
                    settingsStore.setSecondaryLanguage(value);
                  }
                },
              ),
              SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  AppLocalizations.of(context)!.includeAdult,
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              DropDownButtonWidget(
                items: [
                  AppLocalizations.of(context)!.yes,
                  AppLocalizations.of(context)!.no
                ],
                value: settingsStore.adultContent
                    ? AppLocalizations.of(context)!.yes
                    : AppLocalizations.of(context)!.no,
                onChanged: (value) {
                  if (value != null) {
                    settingsStore.setAdultContent(value);
                  }
                },
              ),
              SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  AppLocalizations.of(context)!.country,
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              DropDownButtonWidget(
                items: settingsStore.avaliableRegions.map<String>((e) {
                  return e.englishName;
                }).toList()
                  ..sort(),
                value: settingsStore.country,
                onChanged: (value) {
                  if (value != null) {
                    settingsStore.setCountry(value);
                  }
                },
              ),
              SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.timeZone,
                      style: GoogleFonts.getFont('Mitr',
                          color: styleStore.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Checkbox(
                        checkColor:
                            AppColors.textOnPrimaries[styleStore.colorIndex!],
                        fillColor:
                            MaterialStateProperty.all(styleStore.primaryColor),
                        value: settingsStore.autoDetectTimeZone,
                        onChanged: (value) {
                          if (value != null) {
                            settingsStore.setAutoDetectTimeZone(value);
                          }
                        }),
                    Text(
                      AppLocalizations.of(context)!.autoDetect,
                      style: GoogleFonts.getFont('Mitr',
                          color: styleStore.textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              DropDownButtonWidget(
                items: settingsStore.timeZones,
                value: settingsStore.timeZone,
                onChanged: (value) {
                  if (value != null) {
                    settingsStore.setTimeZone(value);
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
