import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class GenreTile extends StatelessWidget {
  GenreTile({
    Key? key,
    required this.index,
    required this.onTap,
    required this.onTap2,
  }) : super(key: key);
  final int index;
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  final VoidCallback onTap;
  final void Function(bool?) onTap2;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: styleStore.shapeColor,
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                settingsStore.movieGenres[index].name,
                style: GoogleFonts.getFont('Mitr',
                    color: styleStore.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w200),
              ),
              Observer(builder: (context) {
                return Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  activeColor: styleStore.primaryColor,
                  checkColor: AppColors.textOnPrimaries[styleStore.colorIndex!],
                  fillColor: !settingsStore.selectedGenres
                          .contains(settingsStore.movieGenres[index].id)
                      ? MaterialStateProperty.all(styleStore.textColor)
                      : null,
                  value: settingsStore.selectedGenres
                      .contains(settingsStore.movieGenres[index].id),
                  onChanged: onTap2,
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
