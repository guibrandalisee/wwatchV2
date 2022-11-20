import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wwatch/Screens/home/components/back_to_top_button_widget.dart';
import 'package:wwatch/Screens/home/components/content_filter_widget.dart';
import 'package:wwatch/Screens/home/components/loading_screen.dart';
import 'package:wwatch/Screens/home/components/error_screen.dart';
import 'package:wwatch/Screens/home/components/movie_tile_list.dart';
import 'package:wwatch/Screens/home/components/nothing_found_error_screen.dart';
import 'package:wwatch/Screens/home/components/speed_dial.dart';
import 'package:wwatch/Screens/login/login_screen.dart';
import 'package:wwatch/Screens/settings/settings_screen.dart';
import 'package:wwatch/Screens/user/user_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Screens/home/components/movie_tile.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wwatch/stores/user_store.dart';

enum Type { movie, tvShows }

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.contentType, required this.prefs})
      : super(key: key);
  final contentType;
  final SharedPreferences prefs;
  final UserStore userStore = GetIt.I<UserStore>();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    //TODO make cache for genres and regions
    settingsStore.getAvaliableLanguages();
    settingsStore.getAvaliableRegions();
    settingsStore.getMovieGenres();
    settingsStore.getTvShowGenres();
    movieStore.getPopularContent();

    if (widget.prefs.containsKey("sessionId")) {
      widget.userStore.getUserDetails();
    }

    if (widget.contentType != Type.movie) {
      settingsStore.setSelectedContentType(1);
    }
    if (!widget.prefs.containsKey('language') ||
        !widget.prefs.containsKey('languageISO') ||
        !widget.prefs.containsKey('country')) {
      String lang = AppLocalizations.delegate
              .isSupported(WidgetsBinding.instance.window.locale)
          ? '${WidgetsBinding.instance.window.locale.languageCode}-${WidgetsBinding.instance.window.locale.countryCode}'
          : 'en-US';
      movieStore.language = lang;
      settingsStore.language = lang;
      //Set Current Device Language as Default
      if (AppLocalizations.delegate
          .isSupported(WidgetsBinding.instance.window.locale)) {
        widget.prefs.setString('languageISO',
            '${WidgetsBinding.instance.window.locale.languageCode}-${WidgetsBinding.instance.window.locale.countryCode}');

        widget.prefs.setString(
            'language',
            settingsStore.avaliableContentLanguages.firstWhere((element) {
              return element.name.substring(element.name.length - 2) ==
                  WidgetsBinding.instance.window.locale.countryCode;
            }).englishName);
        settingsStore.selectedlanguage =
            settingsStore.avaliableContentLanguages.firstWhere((element) {
          return element.name.substring(element.name.length - 2) ==
              WidgetsBinding.instance.window.locale.countryCode;
        }).englishName;

        Future.delayed(Duration(seconds: 5)).then((value) {
          if (settingsStore.avaliableRegions.isNotEmpty) {
            String country = settingsStore.avaliableRegions
                .firstWhere((element) =>
                    element.iso_3166_1 ==
                    WidgetsBinding.instance.window.locale.countryCode)
                .englishName;
            widget.prefs.setString('country', country);
            settingsStore.setCountry(country);
          }
        });
      }
    }
  }

  final ScrollController scrollController =
      ScrollController(initialScrollOffset: 120);

  final FocusNode focusNode = FocusNode();
  final MovieStore movieStore = MovieStore();

  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();

  @override
  Widget build(BuildContext context) {
    reaction((_) => styleStore.fabPosition, (value) {
      setState(() {});
    });
    reaction((_) => styleStore.primaryColor, (value) {
      setState(() {});
    });
    reaction((_) => settingsStore.dateFormat, (value) {
      setState(() {});
    });
    reaction((_) => styleStore.backgroundColor, (value) {
      setState(() {});
    });
    reaction((_) => settingsStore.tileDisplayMode, (value) {
      setState(() {});
    });

    return Scaffold(
      floatingActionButtonLocation: styleStore.fabPosition == 0
          ? FloatingActionButtonLocation.startFloat
          : FloatingActionButtonLocation.endFloat,
      floatingActionButton: CustomSpeedDialHomeScreen(
        movieStore: movieStore,
        focusNode: focusNode,
        scrollController: scrollController,
      ),
      backgroundColor: styleStore.backgroundColor,
      appBar: AppBar(
        backgroundColor: settingsStore.brightness == CustomBrightness.amoled
            ? styleStore.backgroundColor
            : styleStore.primaryColor,
        leading: InkWell(
          // onTap: () {
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => WelcomeScreen(),
          //     ),
          //   );
          // },
          child: Ink(
            child: Center(
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
        actions: [
          IconButton(
            splashRadius: 20,
            tooltip: AppLocalizations.of(context)!.settings,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsScreen(
                            movieStore: movieStore,
                          )));
            },
            icon: Icon(
              LineIcons.cog,
              color: settingsStore.brightness != CustomBrightness.amoled
                  ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                  : styleStore.primaryColor,
              size: 28,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          IconButton(
            splashRadius: 20,
            tooltip: 'User Profile',
            onPressed: () {
              if (widget.userStore.sessionId != null &&
                  widget.userStore.sessionId!.isNotEmpty) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserScreen()));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }
            },
            icon: Hero(
              tag: 'User Profile',
              child: Icon(
                LineIcons.user,
                color: settingsStore.brightness != CustomBrightness.amoled
                    ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                    : styleStore.primaryColor,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (movieStore.temporarySearchString.isNotEmpty &&
              movieStore.searchString.isNotEmpty) {
            movieStore.temporarySearchString = '';
            movieStore.setSearch();
            movieStore.search();
            return false;
          }

          return true;
        },
        child: DoubleBackToCloseApp(
          snackBar: SnackBar(
            content: Text(AppLocalizations.of(context)!.tapAgainToLeave),
          ),
          child: Observer(
            builder: (context) {
              if (movieStore.error)
                return CustomErrorScree(
                  movieStore: movieStore,
                );
              if (movieStore.empty)
                return CustomNothingFoundErrorScreen(
                  movieStore: movieStore,
                  focusNode: focusNode,
                );
              if (movieStore.movies.length == 0) return CustomLoadingScreen();
              return Stack(
                children: [
                  ListView.builder(
                      controller: scrollController,
                      physics: BouncingScrollPhysics(),
                      itemCount: movieStore.movies.length + 2,
                      itemBuilder: (context, index) {
                        if (index == 0)
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 120,
                              ),
                              const SizedBox(
                                height: 28,
                              ),
                              ContentFilter(
                                focusNode: focusNode,
                                movieStore: movieStore,
                              ),
                            ],
                          );
                        else if (index < movieStore.movies.length + 1)
                          return settingsStore.tileDisplayMode == 0
                              ? MovieTile(
                                  prefs: widget.prefs,
                                  movie: movieStore.movies[index - 1],
                                  contentType:
                                      settingsStore.selectedContentType == 0
                                          ? CustomContentType.MOVIE
                                          : CustomContentType.TVSHOW,
                                )
                              : MovieTileList(
                                  prefs: widget.prefs,
                                  movie: movieStore.movies[index - 1],
                                  contentType:
                                      settingsStore.selectedContentType == 0
                                          ? CustomContentType.MOVIE
                                          : CustomContentType.TVSHOW);
                        else if (movieStore.totalPages != null &&
                            movieStore.page < movieStore.totalPages!) {
                          movieStore.getMoreContent();
                          return LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                              styleStore.primaryColor,
                            ),
                            backgroundColor: styleStore.backgroundColor,
                          );
                        } else {
                          return Container();
                        }
                      }),
                  Positioned(
                      bottom: MediaQuery.of(context).viewPadding.bottom + 128,
                      left: styleStore.fabPosition == 0 ? 24 : null,
                      right: styleStore.fabPosition == 1 ? 24 : null,
                      child: BackToTopButton(
                        scrollController: scrollController,
                      )),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
