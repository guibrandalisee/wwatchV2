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
            color: AppColors.text,
            fontSize: 16,
            fontWeight: FontWeight.w100,
          ),
        ),
        backgroundColor: styleStore.shapeColor,
        collapsedIconColor: AppColors.text,
        iconColor: styleStore.primaryColor,
        children: [
          //TODO make the filter work
          //TODO add reamining watch providers
          //TODO Make a custom widget to reduce lines
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

          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomProviderWidget(id: 1, title: 'Netflix'),
                    const SizedBox(
                      width: 8,
                    ),
                    CustomProviderWidget(id: 2, title: 'Prime Video'),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    CustomProviderWidget(id: 3, title: 'HBO Max'),
                    const SizedBox(
                      width: 8,
                    ),
                    CustomProviderWidget(id: 4, title: 'Disney Plus'),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    CustomProviderWidget(id: 5, title: 'Star+'),
                    const SizedBox(
                      width: 8,
                    ),
                    CustomProviderWidget(id: 6, title: 'Apple TV'),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Note that results may vary based in which country is selected in app configurations",
                  style: GoogleFonts.getFont(
                    'Mitr',
                    color: AppColors.text,
                    fontSize: 12,
                    fontWeight: FontWeight.w100,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomProviderWidget extends StatelessWidget {
  CustomProviderWidget({
    Key? key,
    required this.id,
    required this.title,
  }) : super(key: key);
  final int id;
  final String title;
  @override
  Widget build(BuildContext context) {
    SettingsStore settingsStore = GetIt.I<SettingsStore>();
    StyleStore styleStore = GetIt.I<StyleStore>();
    return Observer(builder: (context) {
      return Expanded(
        child: InkWell(
          onTap: () {
            if (settingsStore.selectedWatchProviders.contains(id)) {
              settingsStore.removeSelectedWatchProvider(id);
            } else {
              settingsStore.addSelectedWatchProvider(id);
            }
          },
          child: Container(
            height: 48,
            decoration: BoxDecoration(
                color: settingsStore.selectedWatchProviders.contains(id)
                    ? styleStore.primaryColor
                    : styleStore.backgroundColor,
                borderRadius: BorderRadius.circular(4)),
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.getFont(
                  'Mitr',
                  color: settingsStore.selectedWatchProviders.contains(id)
                      ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                      : styleStore.textColor,
                  fontSize: 16,
                  fontWeight: settingsStore.selectedWatchProviders.contains(id)
                      ? FontWeight.w400
                      : FontWeight.w200,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
