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
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();

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
    return Observer(
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
                  if (_prefs != null) {
                    _prefs!.setString('language', value);
                    _prefs!.setString('languageISO', settingsStore.language);
                  }
                  widget.movieStore.getPopularContent();
                  settingsStore.getMovieGenres();
                  settingsStore.getTvShowGenres();
                }
              },
            ),
            SizedBox(
              height: 32,
            ),
            // IconButton(
            //     onPressed: () {
            //       _prefs!.clear();
            //     },
            //     icon: Icon(Icons.refresh)),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.sContentLanguage,
                    style: GoogleFonts.getFont('Mitr',
                        color: styleStore.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                  IconButton(
                    tooltip: "Info",
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: styleStore.shapeColor,
                              title: Text(
                                AppLocalizations.of(context)!.sContentLanguage,
                                style: GoogleFonts.getFont('Mitr',
                                    color: styleStore.textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              content: Text(
                                "Secondary content language is used to display text such as Movie/TV Show overview that is not available in primary content language",
                                style: GoogleFonts.getFont('Mitr',
                                    color: styleStore.textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w100),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              styleStore.primaryColor)),
                                  child: Text(
                                    'Ok',
                                    style: GoogleFonts.getFont('Mitr',
                                        color: AppColors.textOnPrimaries[
                                            styleStore.colorIndex!],
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300),
                                  ),
                                )
                              ],
                            );
                          });
                    },
                    icon: Icon(
                      Icons.info,
                      size: 16,
                      color: styleStore.textColor,
                    ),
                    constraints: BoxConstraints(),
                    padding: EdgeInsets.zero,
                    splashRadius: 16,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            DropDownButtonWidget(
              items: settingsStore.avaliableContentLanguages
                  .map<String>((e) => e.englishName)
                  .toList(),
              value: settingsStore.selectedSecondaryLanguage,
              onChanged: (value) {
                if (value != null) {
                  settingsStore.selectedSecondaryLanguage = value;
                  settingsStore.secondaryLanguage = settingsStore
                      .avaliableContentLanguages
                      .firstWhere((element) => element.englishName == value)
                      .iso_639_1;

                  if (_prefs != null) {
                    _prefs!.setString('secondaryLanguage', value);
                    _prefs!.setString('secondaryLanguageISO',
                        settingsStore.secondaryLanguage);
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
              height: 16,
            ),
          ],
        );
      },
    );
  }
}
