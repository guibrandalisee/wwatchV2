import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class GenreModeSelector extends StatelessWidget {
  GenreModeSelector({
    Key? key,
    required this.movieStore,
  }) : super(key: key);
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  final MovieStore movieStore;
  @override
  Widget build(BuildContext context) {
    bool movie = settingsStore.selectedContentType == 0;
    return Observer(
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Filter Mode",
                    style: GoogleFonts.getFont(
                      'Mitr',
                      color: styleStore.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w100,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: styleStore.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 2,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {
                  if (movie) {
                    settingsStore.setMovieGenreMode(GenreMode.all);
                  } else {
                    settingsStore.setTvShowGenreMode(GenreMode.all);
                  }
                  movieStore.didChange = true;
                },
                child: Container(
                  //need this color to "render" the container
                  //so the user is able to click anywhere near the text to check the checkbox
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Has all selected genres",
                        style: GoogleFonts.getFont(
                          'Mitr',
                          color: styleStore.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w100,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      movie
                          ? Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              activeColor: styleStore.primaryColor,
                              checkColor: AppColors
                                  .textOnPrimaries[styleStore.colorIndex!],
                              fillColor: !(settingsStore.movieGenreMode ==
                                      GenreMode.all)
                                  ? MaterialStateProperty.all(
                                      styleStore.textColor)
                                  : null,
                              value:
                                  settingsStore.movieGenreMode == GenreMode.all,
                              onChanged: (value) {
                                settingsStore.setMovieGenreMode(GenreMode.all);
                                movieStore.didChange = true;
                              },
                            )
                          : Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              activeColor: styleStore.primaryColor,
                              checkColor: AppColors
                                  .textOnPrimaries[styleStore.colorIndex!],
                              fillColor: !(settingsStore.tvShowGenreMode ==
                                      GenreMode.all)
                                  ? MaterialStateProperty.all(
                                      styleStore.textColor)
                                  : null,
                              value: settingsStore.tvShowGenreMode ==
                                  GenreMode.all,
                              onChanged: (value) {
                                settingsStore.setTvShowGenreMode(GenreMode.all);
                                movieStore.didChange = true;
                              },
                            ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  if (movie) {
                    settingsStore.setMovieGenreMode(GenreMode.one);
                  } else {
                    settingsStore.setTvShowGenreMode(GenreMode.one);
                  }
                  movieStore.didChange = true;
                },
                child: Container(
                  //need this color to "render" the container
                  //so the user is able to click anywhere near the text to check the checkbox
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Has one of the selected genres",
                        style: GoogleFonts.getFont(
                          'Mitr',
                          color: styleStore.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w100,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      movie
                          ? Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              activeColor: styleStore.primaryColor,
                              checkColor: AppColors
                                  .textOnPrimaries[styleStore.colorIndex!],
                              fillColor: !(settingsStore.movieGenreMode ==
                                      GenreMode.one)
                                  ? MaterialStateProperty.all(
                                      styleStore.textColor)
                                  : null,
                              value:
                                  settingsStore.movieGenreMode == GenreMode.one,
                              onChanged: (value) {
                                settingsStore.setMovieGenreMode(GenreMode.one);
                                movieStore.didChange = true;
                              },
                            )
                          : Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              activeColor: styleStore.primaryColor,
                              checkColor: AppColors
                                  .textOnPrimaries[styleStore.colorIndex!],
                              fillColor: !(settingsStore.tvShowGenreMode ==
                                      GenreMode.one)
                                  ? MaterialStateProperty.all(
                                      styleStore.textColor)
                                  : null,
                              value: settingsStore.tvShowGenreMode ==
                                  GenreMode.one,
                              onChanged: (value) {
                                settingsStore.setTvShowGenreMode(GenreMode.one);
                                movieStore.didChange = true;
                              },
                            ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  color: styleStore.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}
