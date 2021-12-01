import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class BrightnessSelector extends StatelessWidget {
  const BrightnessSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final styleStore = GetIt.I<StyleStore>();
    final settingsStore = GetIt.I<SettingsStore>();
    return Observer(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(24),
            child: Ink(
              decoration: BoxDecoration(
                color: AppColors.background,
                border: settingsStore.brightness == CustomBrightness.dark
                    ? Border.all(
                        color: styleStore.primaryColor!,
                        width: 3,
                      )
                    : null,
                boxShadow: [
                  settingsStore.brightness == CustomBrightness.dark
                      ? BoxShadow(
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.4),
                          offset: Offset(4, 4))
                      : BoxShadow()
                ],
                borderRadius: BorderRadius.circular(24),
              ),
              height: 80,
              width: 106,
              child: Center(
                child: Text(
                  "Dark",
                  style: GoogleFonts.getFont('Mitr',
                      color: AppColors.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            onTap: () {
              settingsStore.setBrightness(CustomBrightness.dark);
              styleStore.changeBrihtness();
            },
          ),
          InkWell(
            borderRadius: BorderRadius.circular(24),
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.black,
                border: settingsStore.brightness == CustomBrightness.amoled
                    ? Border.all(
                        color: styleStore.primaryColor!,
                        width: 3,
                      )
                    : null,
                boxShadow: [
                  settingsStore.brightness == CustomBrightness.amoled
                      ? BoxShadow(
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.4),
                          offset: Offset(4, 4))
                      : BoxShadow()
                ],
                borderRadius: BorderRadius.circular(24),
              ),
              height: 80,
              width: 106,
              child: Center(
                child: Text(
                  "AMOLED",
                  style: GoogleFonts.getFont('Mitr',
                      color: AppColors.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            onTap: () {
              settingsStore.setBrightness(CustomBrightness.amoled);
              styleStore.changeBrihtness();
            },
          ),
          InkWell(
            borderRadius: BorderRadius.circular(24),
            child: Ink(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: settingsStore.brightness == CustomBrightness.light
                      ? Border.all(
                          color: styleStore.primaryColor!,
                          width: 3,
                        )
                      : null,
                  boxShadow: [
                    settingsStore.brightness == CustomBrightness.light
                        ? BoxShadow(
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.4),
                            offset: Offset(4, 4))
                        : BoxShadow()
                  ],
                  borderRadius: BorderRadius.circular(24)),
              height: 80,
              width: 106,
              child: Center(
                child: Text(
                  "Light",
                  style: GoogleFonts.getFont('Mitr',
                      color: Color(0xff16161D),
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            onTap: () {
              settingsStore.setBrightness(CustomBrightness.light);
              styleStore.changeBrihtness();
            },
          ),
        ],
      );
    });
  }
}
