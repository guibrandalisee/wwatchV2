import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class SortByTile extends StatelessWidget {
  SortByTile({
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
    return Observer(builder: (context) {
      return Column(
        children: [
          Container(
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
                      convertToTitleCase(settingsStore.possibleSortBy[index]
                          .replaceAll('.', ' | ')
                          .replaceAll('_', ' ')
                          .trim()),
                      style: GoogleFonts.getFont('Mitr',
                          color: styleStore.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w200),
                    ),
                    Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        activeColor: styleStore.primaryColor,
                        checkColor:
                            AppColors.textOnPrimaries[styleStore.colorIndex!],
                        fillColor: settingsStore.selectedSortBy ==
                                settingsStore.possibleSortBy[index]
                            ? null
                            : MaterialStateProperty.all(styleStore.textColor),
                        value: settingsStore.selectedSortBy ==
                            settingsStore.possibleSortBy[index],
                        onChanged: onTap2)
                  ],
                ),
              ),
            ),
          ),
          if (index % 2 == 1) Divider()
        ],
      );
    });
  }
}

String convertToTitleCase(String text) {
  if (text.length <= 1) {
    return text.toUpperCase();
  }

  // Split string into multiple words
  final List<String> words = text.split(' ');

  // Capitalize first letter of each words
  final capitalizedWords = words.map((word) {
    if (word.trim().isNotEmpty) {
      final String firstLetter = word.trim().substring(0, 1).toUpperCase();
      final String remainingLetters = word.trim().substring(1);

      return '$firstLetter$remainingLetters';
    }
    return '';
  });

  // Join/Merge all words back to one String
  return capitalizedWords.join(' ');
}
