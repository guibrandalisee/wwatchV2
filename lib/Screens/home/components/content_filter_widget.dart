import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wwatch/Screens/genres/genres_screen.dart';
import 'package:wwatch/Screens/sort_by/sort_by_screen.dart';

import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class ContentFilter extends StatelessWidget {
  final FocusNode focusNode;
  final MovieStore movieStore;

  ContentFilter({
    Key? key,
    required this.focusNode,
    required this.movieStore,
  }) : super(key: key);

  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    controller.text = movieStore.searchString;
    controller.selection =
        TextSelection.collapsed(offset: movieStore.searchString.length);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: styleStore.shapeColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: TextField(
              controller: controller,
              onSubmitted: (_) {
                movieStore.search();
              },
              textInputAction: TextInputAction.search,
              onChanged: movieStore.setSearch,
              focusNode: focusNode,
              style: GoogleFonts.getFont('Mitr',
                  color: styleStore.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w100),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: GoogleFonts.getFont('Mitr',
                    color: styleStore.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w100),
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (movieStore.searchString.isNotEmpty)
                      InkWell(
                        onTap: () {
                          movieStore.setSearch('');
                          movieStore.search();
                        },
                        child: Icon(
                          Icons.close,
                          color: styleStore.textColor,
                          size: 18,
                        ),
                      ),
                    const SizedBox(
                      width: 16,
                    ),
                    InkWell(
                      onTap: movieStore.search,
                      child: Icon(
                        LineIcons.search,
                        color: styleStore.textColor,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 48,
            decoration: BoxDecoration(
                color: styleStore.shapeColor,
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 56,
                    child: TextButton(
                      onPressed: () {
                        settingsStore.setSelectedContentType(0);
                        if (movieStore.searchString.isEmpty) {
                          movieStore.getPopularMovies();
                        }
                      },
                      child: Text(
                        "Movies",
                        style: GoogleFonts.getFont('Mitr',
                            color: settingsStore.selectedContentType == 1
                                ? styleStore.textColor
                                : AppColors
                                    .textOnPrimaries[styleStore.colorIndex!],
                            fontSize: 16,
                            fontWeight: settingsStore.selectedContentType == 1
                                ? FontWeight.w100
                                : FontWeight.w400),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            settingsStore.selectedContentType == 0
                                ? styleStore.primaryColor
                                : Colors.transparent),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 36,
                  color: styleStore.textColor,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 56,
                    child: TextButton(
                      onPressed: () {
                        settingsStore.setSelectedContentType(1);
                        if (movieStore.searchString.isEmpty) {
                          movieStore.getPopularMovies();
                        }
                      },
                      child: Text(
                        "TV Shows",
                        style: GoogleFonts.getFont('Mitr',
                            color: settingsStore.selectedContentType == 0
                                ? styleStore.textColor
                                : AppColors
                                    .textOnPrimaries[styleStore.colorIndex!],
                            fontSize: 16,
                            fontWeight: settingsStore.selectedContentType == 0
                                ? FontWeight.w100
                                : FontWeight.w400),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            settingsStore.selectedContentType == 1
                                ? styleStore.primaryColor
                                : Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 8,
          ),
          Observer(builder: (_) {
            if (movieStore.searchString.isEmpty)
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(4),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SortByScreen(
                                      movieStore: movieStore,
                                    )));
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                            color: styleStore.shapeColor,
                            borderRadius: BorderRadius.circular(4)),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          width: 340,
                          height: 48,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sort By",
                                style: GoogleFonts.getFont('Mitr',
                                    color: styleStore.textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w100),
                              ),
                              Icon(
                                LineIcons.angleDoubleRight,
                                color: styleStore.textColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(4),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GenresScreen(
                                      movieStore: movieStore,
                                    )));
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                            color: styleStore.shapeColor,
                            borderRadius: BorderRadius.circular(4)),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          width: 340,
                          height: 48,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Genres",
                                style: GoogleFonts.getFont('Mitr',
                                    color: styleStore.textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w100),
                              ),
                              Icon(
                                LineIcons.angleDoubleRight,
                                color: styleStore.textColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            return Container();
          }),
          const SizedBox(
            height: 8,
          ),
          //TODO Make this \/

          // Observer(
          //   builder: (_) {
          //     if (movieStore.searchString.isEmpty)
          //       return ProvidersFilterWidget();
          //     else
          //       return Container();
          //   },
          // ),
        ],
      ),
    );
  }
}
