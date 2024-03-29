import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wwatch/Screens/genres/components/genre_mode_selector.dart';

import 'package:wwatch/Screens/genres/components/genre_tile_widget.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({
    Key? key,
    required this.movieStore,
  }) : super(key: key);
  final MovieStore movieStore;

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SettingsStore settingsStore = GetIt.I<SettingsStore>();
    final StyleStore styleStore = GetIt.I<StyleStore>();

    return Scaffold(
      floatingActionButtonLocation: styleStore.fabPosition == 0
          ? FloatingActionButtonLocation.startFloat
          : FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: styleStore.primaryColor,
        child: Center(
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
        ),
      ),
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
      ),
      body: Observer(builder: (context) {
        bool movie = settingsStore.selectedContentType == 0;
        return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: movie
                ? (settingsStore.movieGenres.length + 2)
                : (settingsStore.tvShowGenres.length + 2),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Hero(
                      tag: 'logoImage',
                      child: Container(
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
                              height: 420,
                              width: 420),
                          filterQuality: FilterQuality.medium,
                          color: settingsStore.brightness !=
                                  CustomBrightness.amoled
                              ? styleStore.textColor
                              : styleStore.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    //*AppLocalizations.of(context)!.genresDescription,
                    GenreModeSelector(
                      movieStore: widget.movieStore,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                );
              }
              if (index ==
                  (movie
                      ? (settingsStore.movieGenres.length + 1)
                      : (settingsStore.tvShowGenres.length + 1))) {
                return SizedBox(
                  height: 80,
                );
              } else {
                return movie
                    ? GenreTile(
                        onTap: () {
                          widget.movieStore.didChange = true;
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
                          widget.movieStore.didChange = true;
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
                      )
                    : GenreTile(
                        onTap: () {
                          widget.movieStore.didChange = true;
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
                          widget.movieStore.didChange = true;
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
      }),
    );
  }
}
