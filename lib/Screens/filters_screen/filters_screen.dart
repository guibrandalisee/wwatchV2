import 'package:another_xlider/models/slider_step.dart';
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
import 'package:wwatch/Screens/watch_providers/watch_providers_scren.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/configuration_models.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          movieStore.getPopularContent();
          settingsStore.saveSelectedWatchProviders();
          movieStore.didChange = false;
        }
        return true;
      },
      child: Scaffold(
        floatingActionButtonLocation: styleStore.fabPosition == 0
            ? FloatingActionButtonLocation.startFloat
            : FloatingActionButtonLocation.endFloat,
        floatingActionButton: fab != null && fab!
            ? FloatingActionButton(
                onPressed: () {
                  if (movieStore.didChange) {
                    movieStore.movies = [];
                    movieStore.getPopularContent();
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
                    AppLocalizations.of(context)!.descriptionFilterScreen,
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
                              transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
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
                              AppLocalizations.of(context)!.sortBy,
                              style: GoogleFonts.getFont('Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w100),
                            ),
                            Icon(
                              LineIcons.sort,
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
                              transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
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
                              AppLocalizations.of(context)!.genres,
                              style: GoogleFonts.getFont('Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w100),
                            ),
                            Icon(
                              LineIcons.gripLinesVertical,
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
                          transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
                          child: WatchProvidersScreen(movieStore: movieStore),
                        ),
                      );
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
                              AppLocalizations.of(context)!.watchProviders,
                              style: GoogleFonts.getFont('Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w100),
                            ),
                            Icon(
                              LineIcons.television,
                              color: styleStore.textColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                FilterWidgetBase(
                    value: settingsStore.voteCountActive,
                    title: AppLocalizations.of(context)!.voteCount,
                    onChanged: (a) {
                      settingsStore.toogleVoteCountFilter(a);
                      movieStore.didChange = true;
                    },
                    child: CustomSlider(
                      min: FilterDefaultValues.voteCountMinValue,
                      max: FilterDefaultValues.voteCountMaxValue,
                      step: FlutterSliderStep(step: 10),
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
                  title: AppLocalizations.of(context)!.voteAverage,
                  onChanged: (a) {
                    settingsStore.toogleVoteAvgFilter(a);
                    movieStore.didChange = true;
                  },
                  child: CustomSlider(
                    min: FilterDefaultValues.voteAvgMinValue,
                    max: FilterDefaultValues.voteAvgMaxValue,
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
                  title: AppLocalizations.of(context)!.runtimeFilter,
                  onChanged: (a) {
                    settingsStore.toogleRunTimeFilter(a);
                    movieStore.didChange = true;
                  },
                  child: Column(
                    children: [
                      CustomSlider(
                        minimumDistance: 0,
                        min: FilterDefaultValues.runTimeMinValue,
                        max: FilterDefaultValues.runTimeMaxValue,
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
                          AppLocalizations.of(context)!.runtimeText,
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
