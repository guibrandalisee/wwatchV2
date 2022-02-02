import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';

import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class TileModeSelectorWidget extends StatelessWidget {
  TileModeSelectorWidget({Key? key}) : super(key: key);
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 156,
      child: Observer(builder: (context) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                settingsStore.setTileMode(0);
              },
              child: Container(
                height: 156,
                width: 156,
                decoration: BoxDecoration(
                    color: styleStore.shapeColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        width: 4,
                        color: settingsStore.tileDisplayMode == 0
                            ? styleStore.primaryColor!
                            : Colors.transparent)),
                child: Icon(
                  Icons.calendar_view_day_rounded,
                  color: styleStore.textColor,
                  size: 64,
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                settingsStore.setTileMode(1);
              },
              child: Container(
                height: 156,
                width: 156,
                decoration: BoxDecoration(
                    color: styleStore.shapeColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        width: 4,
                        color: settingsStore.tileDisplayMode == 1
                            ? styleStore.primaryColor!
                            : Colors.transparent)),
                child: Icon(
                  Icons.list,
                  color: styleStore.textColor,
                  size: 64,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
