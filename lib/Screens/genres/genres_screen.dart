import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import 'package:wwatch/Screens/genres/components/genre_tile_widget.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class GenresScreen extends StatelessWidget {
  const GenresScreen({
    Key? key,
    required this.movieStore,
    this.fab,
  }) : super(key: key);
  final MovieStore movieStore;
  final bool? fab;
//TODO make possible for the user to choose if they want to view only movies that have all selected genres
// or view all movies that has at least one of these genres

//You can do this using the parameter without_genres, just exclude all genders except the selected ones
  @override
  Widget build(BuildContext context) {
    bool didChange = false;
    final SettingsStore settingsStore = GetIt.I<SettingsStore>();
    final StyleStore styleStore = GetIt.I<StyleStore>();

    return WillPopScope(
      onWillPop: () async {
        if (didChange) {
          movieStore.movies = [];
          movieStore.getPopularMovies();
        }
        return true;
      },
      child: Scaffold(
        floatingActionButton: fab != null && fab!
            ? FloatingActionButton(
                onPressed: () {
                  if (didChange) {
                    movieStore.movies = [];
                    movieStore.getPopularMovies();
                  }
                  Navigator.pop(context);
                },
                backgroundColor: styleStore.primaryColor,
                child: Icon(
                  LineIcons.arrowLeft,
                  color: AppColors.textOnPrimaries[styleStore.colorIndex!],
                ),
              )
            : Container(),
        backgroundColor: styleStore.backgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: settingsStore.brightness != CustomBrightness.amoled
                ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                : styleStore.primaryColor,
          ),
          backgroundColor: settingsStore.brightness == CustomBrightness.amoled
              ? styleStore.backgroundColor
              : styleStore.primaryColor,
          title: Hero(
            tag: "logo",
            child: SizedBox(
              height: 56,
              child: Image(
                image: ResizeImage(
                    AssetImage(
                      'assets/images/WWatch2-png.png',
                    ),
                    height: 156,
                    width: 156),
                filterQuality: FilterQuality.medium,
                color: settingsStore.brightness != CustomBrightness.amoled
                    ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                    : styleStore.primaryColor,
              ),
            ),
          ),
        ),
        body: Observer(builder: (context) {
          if (settingsStore.selectedContentType == 0)
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: settingsStore.movieGenres.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(50),
                              blurRadius: 32,
                              spreadRadius: 0,
                            )
                          ]),
                          height: 140,
                          child: Image(
                            image: ResizeImage(
                                AssetImage(
                                  'assets/images/WWatch2-png.png',
                                ),
                                height: 196,
                                width: 196),
                            filterQuality: FilterQuality.medium,
                            color: settingsStore.brightness !=
                                    CustomBrightness.amoled
                                ? AppColors
                                    .textOnPrimaries[styleStore.colorIndex!]
                                : styleStore.primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "This filter works by showing only movies with all selected genres",
                            style: GoogleFonts.getFont(
                              'Mitr',
                              color: styleStore.textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w100,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    );
                  } else {
                    return GenreTile(
                      onTap: () {
                        didChange = true;
                        if (settingsStore.selectedContentType == 0) {
                          if (!settingsStore.selectedMovieGenres.contains(
                              settingsStore.movieGenres[index - 1].id)) {
                            settingsStore.addSelectedMovieGenre(
                                settingsStore.movieGenres[index - 1].id);
                          } else {
                            settingsStore.removeSelectedMovieGenre(
                                settingsStore.movieGenres[index - 1].id);
                          }
                        }
                      },
                      onTap2: (a) {
                        didChange = true;
                        if (settingsStore.selectedContentType == 0) {
                          if (!settingsStore.selectedMovieGenres.contains(
                              settingsStore.movieGenres[index - 1].id)) {
                            settingsStore.addSelectedMovieGenre(
                                settingsStore.movieGenres[index - 1].id);
                          } else {
                            settingsStore.removeSelectedMovieGenre(
                                settingsStore.movieGenres[index - 1].id);
                          }
                        }
                      },
                      index: index - 1,
                    );
                  }
                });
          if (settingsStore.selectedContentType == 1)
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: settingsStore.tvShowGenres.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(50),
                              blurRadius: 32,
                              spreadRadius: 0,
                            )
                          ]),
                          height: 140,
                          child: Image(
                            image: ResizeImage(
                                AssetImage(
                                  'assets/images/WWatch2-png.png',
                                ),
                                height: 196,
                                width: 196),
                            filterQuality: FilterQuality.medium,
                            color: settingsStore.brightness !=
                                    CustomBrightness.amoled
                                ? AppColors
                                    .textOnPrimaries[styleStore.colorIndex!]
                                : styleStore.primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "This filter works by showing only movies with all selected genres",
                            style: GoogleFonts.getFont(
                              'Mitr',
                              color: styleStore.textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w100,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    );
                  } else {
                    return GenreTile(
                      onTap: () {
                        didChange = true;
                        if (settingsStore.selectedContentType == 1) {
                          if (!settingsStore.selectedTvShowGenres.contains(
                              settingsStore.tvShowGenres[index - 1].id)) {
                            settingsStore.addSelectedTvShowGenre(
                                settingsStore.tvShowGenres[index - 1].id);
                          } else {
                            settingsStore.removeSelectedTvShowGenre(
                                settingsStore.tvShowGenres[index - 1].id);
                          }
                        }
                      },
                      onTap2: (a) {
                        didChange = true;
                        if (settingsStore.selectedContentType == 1) {
                          if (!settingsStore.selectedTvShowGenres.contains(
                              settingsStore.tvShowGenres[index - 1].id)) {
                            settingsStore.addSelectedTvShowGenre(
                                settingsStore.tvShowGenres[index - 1].id);
                          } else {
                            settingsStore.removeSelectedTvShowGenre(
                                settingsStore.tvShowGenres[index - 1].id);
                          }
                        }
                      },
                      index: index - 1,
                    );
                  }
                });
          else
            return Container();
        }),
      ),
    );
  }
}
