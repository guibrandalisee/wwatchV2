import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import 'package:wwatch/Screens/sort_by/components/sort_by_tile.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class SortByScreen extends StatelessWidget {
  const SortByScreen({
    Key? key,
    required this.movieStore,
    this.fab,
  }) : super(key: key);
  final MovieStore movieStore;
  final bool? fab;
  @override
  Widget build(BuildContext context) {
    bool didChange = false;
    final SettingsStore settingsStore = GetIt.I<SettingsStore>();
    final StyleStore styleStore = GetIt.I<StyleStore>();
    //TODO change options based on which content type is selected
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
              child: Image.asset(
                "assets/images/WWatch2-png.png",
                color: settingsStore.brightness != CustomBrightness.amoled
                    ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                    : styleStore.primaryColor,
                fit: BoxFit.fitHeight,
                filterQuality: FilterQuality.medium,
              ),
            ),
          ),
        ),
        body: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: settingsStore.possibleSortBy.length + 1,
            itemBuilder: (context, index) {
              if (index == 0)
                return Column(
                  mainAxisSize: MainAxisSize.min,
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
                      child: Image.asset(
                        "assets/images/WWatch2-png.png",
                        color: styleStore.primaryColor,
                        fit: BoxFit.fitHeight,
                        filterQuality: FilterQuality.medium,
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Be aware that you will encounter some strange and/or broken content when sorting by low rated movies (Eg. Popularity | Asc )",
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
              return SortByTile(
                index: index - 1,
                onTap: () {
                  didChange = true;
                  settingsStore
                      .setSortBy(settingsStore.possibleSortBy[index - 1]);
                },
                onTap2: (a) {
                  didChange = true;
                  settingsStore
                      .setSortBy(settingsStore.possibleSortBy[index - 1]);
                },
              );
            }),
      ),
    );
  }
}
