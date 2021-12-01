import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Screens/settings/components/dropdown_button_widget.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class GeneralSettings extends StatelessWidget {
  const GeneralSettings({Key? key}) : super(key: key);

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
                "Date Format",
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
                "Primary Language",
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
              value: settingsStore.language,
              onChanged: (value) {
                if (value != null) {
                  settingsStore.setLanguage(value);
                }
              },
            ),
            SizedBox(
              height: 32,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Secondary Language",
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
                "Include Adult Content",
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
              items: ["Yes", "No"],
              value: settingsStore.adultContent,
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
                "Filter Bad Language",
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
              items: ["Yes", "No"],
              value: settingsStore.filterBadLanguage,
              onChanged: (value) {
                if (value != null) {
                  settingsStore.setFilterBadLanguage(value);
                }
              },
            ),
            SizedBox(
              height: 32,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Country",
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
              items: settingsStore.countries,
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
                    "Time Zone",
                    style: GoogleFonts.getFont('Mitr',
                        color: styleStore.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Checkbox(
                      fillColor:
                          MaterialStateProperty.all(styleStore.primaryColor),
                      value: settingsStore.autoDetectTimeZone,
                      onChanged: (value) {
                        if (value != null) {
                          settingsStore.setAutoDetectTimeZone(value);
                        }
                      }),
                  Text(
                    "Auto Detect",
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
    );
  }
}
