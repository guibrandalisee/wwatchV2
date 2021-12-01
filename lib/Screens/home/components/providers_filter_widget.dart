import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class ProvidersFilterWidget extends StatelessWidget {
  ProvidersFilterWidget({Key? key}) : super(key: key);
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: styleStore.shapeColor,
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        title: Text(
          "Watch Providers",
          style: GoogleFonts.getFont(
            'Mitr',
            color: styleStore.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w100,
          ),
        ),
        backgroundColor: styleStore.shapeColor,
        collapsedIconColor: styleStore.textColor,
        iconColor: styleStore.primaryColor,
        children: [
          //TODO make it change color when clicked
          //TODO make the filter work
          //TODO add reamining watch providers
          //TODO
          //#1 Netflix
          //#2 Amazon Prime Video
          //#2 Disney+
          //#4 Funimation
          //#4 Hulu
          //#4 HBO Max
          //#4 Peacock
          //#8 Crunchyroll
          //#9 Paramount+
          //#10 Apple TV+

          Observer(builder: (_) {
            return Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (settingsStore.selectedWatchProviders
                                .contains(1)) {
                              settingsStore.removeSelectedWatchProvider(1);
                            } else {
                              settingsStore.addSelectedWatchProvider(1);
                            }
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                                color: settingsStore.selectedWatchProviders
                                        .contains(1)
                                    ? styleStore.primaryColor
                                    : styleStore.backgroundColor,
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Text(
                                "Netflix",
                                style: GoogleFonts.getFont(
                                  'Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (settingsStore.selectedWatchProviders
                                .contains(2)) {
                              settingsStore.removeSelectedWatchProvider(2);
                            } else {
                              settingsStore.addSelectedWatchProvider(2);
                            }
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                                color: settingsStore.selectedWatchProviders
                                        .contains(2)
                                    ? styleStore.primaryColor
                                    : styleStore.backgroundColor,
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Text(
                                "Prime Video",
                                style: GoogleFonts.getFont(
                                  'Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (settingsStore.selectedWatchProviders
                                .contains(3)) {
                              settingsStore.removeSelectedWatchProvider(3);
                            } else {
                              settingsStore.addSelectedWatchProvider(3);
                            }
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                                color: settingsStore.selectedWatchProviders
                                        .contains(3)
                                    ? styleStore.primaryColor
                                    : styleStore.backgroundColor,
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Text(
                                "HBO Max",
                                style: GoogleFonts.getFont(
                                  'Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (settingsStore.selectedWatchProviders
                                .contains(4)) {
                              settingsStore.removeSelectedWatchProvider(4);
                            } else {
                              settingsStore.addSelectedWatchProvider(4);
                            }
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                                color: settingsStore.selectedWatchProviders
                                        .contains(4)
                                    ? styleStore.primaryColor
                                    : styleStore.backgroundColor,
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Text(
                                "Disney Plus",
                                style: GoogleFonts.getFont(
                                  'Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (settingsStore.selectedWatchProviders
                                .contains(5)) {
                              settingsStore.removeSelectedWatchProvider(5);
                            } else {
                              settingsStore.addSelectedWatchProvider(5);
                            }
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                                color: settingsStore.selectedWatchProviders
                                        .contains(5)
                                    ? styleStore.primaryColor
                                    : styleStore.backgroundColor,
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Text(
                                "Star+",
                                style: GoogleFonts.getFont(
                                  'Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (settingsStore.selectedWatchProviders
                                .contains(6)) {
                              settingsStore.removeSelectedWatchProvider(6);
                            } else {
                              settingsStore.addSelectedWatchProvider(6);
                            }
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                                color: settingsStore.selectedWatchProviders
                                        .contains(6)
                                    ? styleStore.primaryColor
                                    : styleStore.backgroundColor,
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Text(
                                "Apple TV",
                                style: GoogleFonts.getFont(
                                  'Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Note that results may vary based in which country is selected in app configurations",
                    style: GoogleFonts.getFont(
                      'Mitr',
                      color: styleStore.textColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
