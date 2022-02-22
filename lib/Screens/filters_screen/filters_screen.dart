import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:transition/transition.dart';

import 'package:wwatch/Screens/filters_screen/components/custom_slider_widget.dart';
import 'package:wwatch/Screens/filters_screen/components/filter_widget_base.dart';
import 'package:wwatch/Screens/genres/genres_screen.dart';
import 'package:wwatch/Screens/sort_by/sort_by_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class FiltersScreen extends StatelessWidget {
  FiltersScreen({
    Key? key,
    required this.movieStore,
    this.fab,
  }) : super(key: key);
  final MovieStore movieStore;
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final bool? fab;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (movieStore.didChange) {
          movieStore.movies = [];
          movieStore.getPopularMovies();
          movieStore.didChange = false;
        }
        return true;
      },
      child: Scaffold(
        floatingActionButton: fab != null && fab!
            ? FloatingActionButton(
                onPressed: () {
                  if (movieStore.didChange) {
                    movieStore.movies = [];
                    movieStore.getPopularMovies();
                    movieStore.didChange = false;
                  }
                  Navigator.of(context).pop();
                },
                backgroundColor: styleStore.primaryColor,
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColors.textOnPrimaries[styleStore.colorIndex!],
                  ),
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
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                  width: double.infinity,
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
                      color: settingsStore.brightness != CustomBrightness.amoled
                          ? styleStore.textColor
                          : styleStore.primaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 65,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "None of this filters apply while searching",
                    style: GoogleFonts.getFont(
                      'Mitr',
                      color: styleStore.textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w100,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                // FilterWidgetBase(
                //   value: true,
                //   title: 'Date period',
                //   onChanged: (a) {},
                // ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 2,
                          offset: Offset(0, 4),
                          spreadRadius: 0)
                    ],
                    color: settingsStore.brightness == CustomBrightness.amoled
                        ? styleStore.shapeColor
                        : styleStore.backgroundColor!
                            .withBlue(styleStore.backgroundColor!.blue - 2)
                            .withGreen(styleStore.backgroundColor!.green - 2)
                            .withRed(styleStore.backgroundColor!.red - 2),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: () {
                      Navigator.push(
                          context,
                          Transition(
                              transitionEffect: TransitionEffect.RIGHT_TO_LEFT,
                              child: SortByScreen(
                                movieStore: movieStore,
                              )));
                    },
                    child: Ink(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
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
                SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 2,
                          offset: Offset(0, 4),
                          spreadRadius: 0)
                    ],
                    color: settingsStore.brightness == CustomBrightness.amoled
                        ? styleStore.shapeColor
                        : styleStore.backgroundColor!
                            .withBlue(styleStore.backgroundColor!.blue - 2)
                            .withGreen(styleStore.backgroundColor!.green - 2)
                            .withRed(styleStore.backgroundColor!.red - 2),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: () {
                      Navigator.push(
                          context,
                          Transition(
                              transitionEffect: TransitionEffect.RIGHT_TO_LEFT,
                              child: GenresScreen(
                                movieStore: movieStore,
                              )));
                    },
                    child: Ink(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
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
                SizedBox(
                  height: 16,
                ),
                FilterWidgetBase(
                    value: settingsStore.voteCountActive,
                    title: 'Vote Count',
                    onChanged: (a) {
                      settingsStore.toogleVoteCountFilter(a);
                      movieStore.didChange = true;
                    },
                    child: CustomSlider(
                      min: 0,
                      max: 15000,
                      step: FlutterSliderStep(step: 100),
                      values: [
                        settingsStore.voteCountMin.toDouble(),
                        settingsStore.voteCountMax.toDouble()
                      ],
                      onDragging: (handlerIndex, minValue, maxValue) {
                        settingsStore.voteCountMin = minValue.toInt();
                        settingsStore.voteCountMax = maxValue.toInt();
                        if (settingsStore.voteCountActive) {
                          movieStore.didChange = true;
                        }
                      },
                    )),
                FilterWidgetBase(
                  value: settingsStore.voteAvgActive,
                  title: 'Vote Average',
                  onChanged: (a) {
                    settingsStore.toogleVoteAvgFilter(a);
                    movieStore.didChange = true;
                  },
                  child: CustomSlider(
                    min: 0,
                    max: 10,
                    values: [
                      settingsStore.voteAvgMin.toDouble(),
                      settingsStore.voteAvgMax.toDouble()
                    ],
                    onDragging: (handlerIndex, minValue, maxValue) {
                      settingsStore.voteAvgMin = minValue.toInt();
                      settingsStore.voteAvgMax = maxValue.toInt();
                      if (settingsStore.voteAvgActive) {
                        movieStore.didChange = true;
                      }
                    },
                  ),
                ),
                FilterWidgetBase(
                  value: settingsStore.runTimeActive,
                  title: 'Runtime (minutes)',
                  onChanged: (a) {
                    settingsStore.toogleRunTimeFilter(a);
                    movieStore.didChange = true;
                  },
                  child: Column(
                    children: [
                      CustomSlider(
                        minimumDistance: 0,
                        min: 3,
                        max: 180,
                        values: [
                          settingsStore.runTimeMin.toDouble(),
                          settingsStore.runTimeMax.toDouble()
                        ],
                        onDragging: (handlerIndex, minValue, maxValue) {
                          settingsStore.runTimeMin = minValue.toInt();
                          settingsStore.runTimeMax = maxValue.toInt();
                          if (settingsStore.runTimeActive) {
                            movieStore.didChange = true;
                          }
                        },
                      ),
                      Center(
                        child: Text(
                          "Episode Runtime for Tv Shows*",
                          style: GoogleFonts.getFont(
                            'Mitr',
                            color: styleStore.textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w100,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 56,
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
